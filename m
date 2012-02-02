From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 02:57:14 +0100
Message-ID: <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
	<20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
	<CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
	<7vliom13lm.fsf@alter.siamese.dyndns.org>
	<CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
	<7v7h06109t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 02:57:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RslvN-0005xD-4N
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab2BBB5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:57:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38096 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab2BBB5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 20:57:16 -0500
Received: by wgbdt10 with SMTP id dt10so1980651wgb.1
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 17:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1LNwrHUNEh162TZxpQKUPyF7ftoTlUXlHXkDEc00CEY=;
        b=Lp0mOQ52mBAmvRk4rsjF8kJalRt8V32W5NTIlIevZYszKqu/tyKiGSgOvW302NaoM+
         SBG0x1Wsqe8utb1ccAw5epZ8CB1Zvt1rWeCYPTgG8X7NprmNArKpF56GjLooPS0RgDxQ
         QPDAe0fCBuExTKOwqey69z/XbWd+nabZM767s=
Received: by 10.216.138.149 with SMTP id a21mr3859667wej.0.1328147835008; Wed,
 01 Feb 2012 17:57:15 -0800 (PST)
Received: by 10.216.174.145 with HTTP; Wed, 1 Feb 2012 17:57:14 -0800 (PST)
In-Reply-To: <7v7h06109t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189574>

On 2 February 2012 02:39, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> On 2 February 2012 01:27, Junio C Hamano <gitster@pobox.com> wrote:
>>> demerphq <demerphq@gmail.com> writes:
>>>
>>>> user.name=!ldap_full_name
>>>> user.email=!ldap_email
>>>
>>> I didn't get the impression that that was what he was proposing, but
>>> regardless of who's suggesting it, the above does not make any sense,
>>> from the syntax point of view.
>>
>> Does that mean that from a utility point of view it does?
>
> Not really.
>
> I do not think whatever "utility" value outweighs the hassle of having to
> think through the ramifications (including but not limited to security) of
> running arbitrary user command every time a value is looked up.

Why is that your problem? If I have to enable it then isn't that my choice?

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
