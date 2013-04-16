From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
Date: Tue, 16 Apr 2013 07:56:56 -0400
Message-ID: <CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
	<85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
	<7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
	<516888C0.90501@gmail.com>
	<CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
	<7vobdfnlc7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 13:57:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US4VR-0005Qa-S7
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 13:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab3DPL46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 07:56:58 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:33577 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab3DPL45 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 07:56:57 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so320516iah.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jE4Aon03wiovOdhO2jTX8QQkizymacFNWYkUmbpmo60=;
        b=mMbV8FtYEdTUGbUMWlxx2Pk5SJ4h4ELawQGissKwVjsyPkFxDySOAissmOoNxOee7u
         B0ROvfs29odfuHaCcgO0Wv07QQdY2kJmmSHVJZTjVePAEh8d+tzvAeFGMaYXvT+zXfAA
         9MEtS4pz1biUM9PnY2ADXmVBBaXevB2JxiNoyrPJqRx+CfFHJoZvoZIJsHFOcGBN6VSf
         v6/FYWbfccHkcOS/P6wPx5oxzKbFkITUHT5Q3+CkUcZB5TdQKJAOcoF4vlNIWE8Kl0GK
         OCJJhRrHwX4rORi3cDFVeSrpiqPV+LvXd3UblmSiA8t0mpTEK1EfCWt7h4KROF2wUIrg
         glrw==
X-Received: by 10.50.187.225 with SMTP id fv1mr1065982igc.74.1366113416809;
 Tue, 16 Apr 2013 04:56:56 -0700 (PDT)
Received: by 10.42.173.70 with HTTP; Tue, 16 Apr 2013 04:56:56 -0700 (PDT)
In-Reply-To: <7vobdfnlc7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221409>

On Tue, Apr 16, 2013 at 12:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Drew Northup <n1xim.email@gmail.com> writes:
>
>>> +  Note that the GITWEB_CONFIG_SYSTEM system-wide configuration file is
>>> +  only used for instances that lack per-instance configuration file.
>>> +  You can use GITWEB_CONFIG_COMMON common system-wide configuration
>>> +  file (normally /etc/gitweb-common.conf) to keep common default
>>> +  settings that apply to all instances.  Settings from per-instance or
>>>    system-wide configuration file override those from common system-wide
>>>    configuration file.
>>
>> That's the point of explaining SPECIFICALLY why the then current
>> behavior wasn't being replaced, and this other mechanism (which would
>> otherwise have no obvious reason for existing) was being introduced.
>
> In order to just pick and use the more appropriate one (or a useful
> combination of the two), a clean description of what each of them do
> without historical cruft is more readable and useful, isn't it?

I am not demanding the retention of cruft, and the rewording is
definitely more pleasant to read.

>  I
> would expect that most of them who are newly configuring a system
> would pick COMMON one and override per instance as needed, without
> touching the SYSTEM one (fallback default) after reading the above,
> and that is what we want to happen.
>
> Do you think sysadmins need a history lesson to understand why there
> are two different possibilities?

We don't need a full history lesson. What we do need to know is that
"Hey, they don't do that the way everybody else does because it would
break things." That's enough to get the point across, and as Jakub
noted gitweb.conf.txt is the correct place for it.

> For example, bash reads some but not all possible configuration
> files. I would expect .bashrc to be read even for login shells after
> reading .bash_login; alas, that is not what happens.  The manual
> does not apologize that the authors now know better and understand
> that it is a stupid behaviour.  The order the rc files are read is
> just described matter-of-factly, and it gives sufficient information
> without unnecessary backstory.
>
> I think the new text conveys the necessary information to the
> intended audience with more clarity without the history lesson or
> the record of your past frustration. Am I mistaken?

The back-story isn't needed; the "Hey this is different" part is. I
think Jakub's suggestion of covering that (succinctly) in
gitweb.conf.txt is the correct solution.

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
