From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: Simplify description of GITWEB_CONFIG_SYSTEM
Date: Tue, 16 Apr 2013 07:51:12 -0400
Message-ID: <CAM9Z-n=MNs4598AHjOUfbd1K3uPQBJVQ-GU=qekdsgyzHvBigg@mail.gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
	<85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
	<7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
	<516888C0.90501@gmail.com>
	<CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
	<7vobdfnlc7.fsf@alter.siamese.dyndns.org>
	<516CF98E.2050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 13:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US4Pu-0006cl-Lb
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 13:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab3DPLvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 07:51:14 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:47188 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3DPLvN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 07:51:13 -0400
Received: by mail-ia0-f169.google.com with SMTP id h23so322117iae.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=6irXhqCajpNqSOyXM1HHEK3y3rD8ZYxYy55Kq1ddDbs=;
        b=Re4rEekcP2qgvoWWC5P4WcMvBvF2ahwXg6g0S+7PwKu1MCevhWnzcTOxisAWc2OiFZ
         SBiLT8I4cL26M6PDuXl4qKDy2Ina0SpHXOSs1SPfCBFqaFzvnDL3dRZK9E14r3huTDo7
         yEX3jidBi5DUPFZmM7YXIC9kcVMpBkEs6wnuJeLAd0oMhO9NvHwZmt0QAd3YzzmdWZvj
         8bi06t/N+jcaspq/0/5fkweJlwdfIBXJ9b+oR5ErJOib163UMkPWf29hTZTc05KKv+tp
         Sae8DUe72cAqiA+IAEbBdVEtK7q5uIO+oXm6u9144eCVkovR98wS80c7det9lkYFyOu0
         9yuQ==
X-Received: by 10.50.173.102 with SMTP id bj6mr7437060igc.16.1366113072911;
 Tue, 16 Apr 2013 04:51:12 -0700 (PDT)
Received: by 10.42.173.70 with HTTP; Tue, 16 Apr 2013 04:51:12 -0700 (PDT)
In-Reply-To: <516CF98E.2050706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221408>

On Tue, Apr 16, 2013 at 3:11 AM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
> Junio C Hamano wrote:
>
>> In order to just pick and use the more appropriate one (or a useful
>> combination of the two), a clean description of what each of them do
>> without historical cruft is more readable and useful, isn't it?  I
>> would expect that most of them who are newly configuring a system
>> would pick COMMON one and override per instance as needed, without
>> touching the SYSTEM one (fallback default) after reading the above,
>> and that is what we want to happen.
>>
>> Do you think sysadmins need a history lesson to understand why there
>> are two different possibilities?
> [...]
>> I think the new text conveys the necessary information to the
>> intended audience with more clarity without the history lesson or
>> the record of your past frustration. Am I mistaken?
>
> Note also that this is about *gitweb/INSTALL*, which is meant to be
> *short* and succint description on how to install gitweb, and not
> about the reference documentation: gitweb(1) or gitweb.conf(5).
>
> Description of historical behavior (and backward compatibility)
> has place (if any) in manpages, not gitweb/INSTALL.
> --
> Jakub Nar=C4=99bski

Let us then agree that it should be mentioned somewhere in
gitweb.conf.txt then (as it currently is not).

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
