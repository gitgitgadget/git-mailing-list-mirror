From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] A late proposal: a modern send-email
Date: Sat, 26 Mar 2016 10:13:47 +0800
Message-ID: <CAKqreux1S2ioEEjPPCkyz1NJnXJ1RyiWdM5thZD607PkL0HKuQ@mail.gmail.com>
References: <CAKqreuyC8p9m_dgVpXCiT_hf=8qBA_5kZ5NABQGx0QDOiCBbww@mail.gmail.com>
	<xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 03:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajdje-0007WS-N6
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 03:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbcCZCNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 22:13:49 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35230 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbcCZCNs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 22:13:48 -0400
Received: by mail-ob0-f169.google.com with SMTP id fp4so67532322obb.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 19:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=vvRH9ov4sUeHNuUk3f05zAutMQfQxsHfkTPUlCCCRLI=;
        b=q2T6cdSo7aMNBrQsWPdMBdTLIaNKGezkeRio7hqNcAOaOadDtbBkT6d6bFjCIoKOI6
         BF+xhDL0wcpKNyCOgQY+nAFMcOZXaL9e6ZIakyKlAe1HMDKuZaDQxmUiqFY2fjOA3weA
         o6O2/IS0EELsMvWPbs4cyqfTF1YM2nwzD7G2YhPNcI7Hbro73RjRD71GVND2phKSJA9X
         u4QLzGfnYUYQ7b4ivvlMNgQa75zQdmnPpw9josxifb66z2CdyXyFUEPhx+Slaz3xEE5E
         xvRXeMgzEDZ4YyNI+hBXdnS3HqrMTNegT7yG+DpCpULaVrHP6q9rf73fSUe7+SImjVTv
         LtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=vvRH9ov4sUeHNuUk3f05zAutMQfQxsHfkTPUlCCCRLI=;
        b=C9w6T0q9gjffXakxO2BxrQt8PraNrCtlEUgjZTLAe31sUDCH/AreEzpenAw4IX+mow
         dmPqF3AjF7rZGvjei4f/gyBsdmnGfwMrzvFXYZiQTy04Sd19qXs5HbPozMDgOg88es8H
         i/LRon5yQsZHjypvvmPfgDC5VI5IIP8wBnzail2wGhkPZkfIOGh9BcynafrXFrJtAW86
         MzokhZ4tMiqalGONsst2hcgzHpRJczg4zr90R2YdjeVaWyasO0eDx81ZGnathcymwPit
         Xa6ZQIVtpKkN3B+b/BaNhyCk2vUIZPUcORRp3WPGu3v7b9oj2yLr0fvu86aI6v2vzf7v
         R1ng==
X-Gm-Message-State: AD7BkJKeSfTvhvuokbCO3VMstgXHkPscXU1++XQbTE0BhPOLnvgUt5QDyyRPF5izMnfr9mOgt9iMWY+G1D7iLg==
X-Received: by 10.182.138.7 with SMTP id qm7mr8318065obb.58.1458958427617;
 Fri, 25 Mar 2016 19:13:47 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 19:13:47 -0700 (PDT)
In-Reply-To: <xmqqzitm2zkj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289974>

2016-03-26 2:16 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.com> writes:
>
>> # Purpose
>> The current implementation of send-email is based on perl and has on=
ly
>> a tui, it has two problems:
>> - user must install a ton of dependencies before submit a single pat=
ch.
>> - tui and parameter are both not quite friendly to new users.
>
> Is "a ton of dependencies" true?  "apt-cache show git-email"
> suggests otherwise.  Is "a ton of dependencies" truly a problem?
> "apt-get install" would resolve the dependencies for you.

There are three perl packages needed to send patch through gmail:
- perl-mime-tools
- perl-net-smtp-ssl
- perl-authen-sasl

Yes, not too many, but is it better none of them?

What's more, when I try to send mails, I was first disrupted by
"no perl-mime-tools" then by "no perl-net-smtp-ssl or perl-authen-sasl"=
=2E
Then I think, why not just a mailto link?

>> # Plan
>> So I propose to implement following:
>> - Allow user to send mail via a [`mailto`
>> link](https://en.wikipedia.org/wiki/Mailto). so that users could
>> complete the mail in their favorite email clients such as gmail, mut=
t,
>> alpine and even gmail for android through
>
> IIRC, GMail on Android is incapable of sending a "text/plain", so
> that part may not fly well.

Really? As much as I known, GMail on Android is capable of sending
a "text/plain" while Inbox is not.

>> - Build a simple email client (maybe a web components based web app =
or
>> wxwidgets based GUI client, they are both cross-platform) which is
>> easy to use for sending patch without disrupting the mailbox format.
>
> I suspect it would yield a better result if the plan were to update
> a popular email client and make it possible to tell it to read an
> existing text file (i.e. mbox) without corrupting its contents.
> People do not have to learn a new mail client if done that way.

Maybe a plugin? I'm not sure.

If above `mail-to` is implemented, user could just using any mail
client, but a mail client adaptive for patch would be better:
- Do not allow user to edit the diff part
- always 'plan/text'
- visual

> That may not be a "Git" project, but GSoC is not limited to Git ;-)

Sorry, but I do not really mean to implement a general mail client.
In fact, this is a GUI front end for git send-mail and may be placed
under contrib/
