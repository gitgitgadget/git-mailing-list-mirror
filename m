From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 03:06:34 +0100
Message-ID: <CANgJU+VKgYVnjABVi-cNS6MBsAAEDeOzcHoB1MFJmhC3i=8++Q@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
	<20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
	<CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
	<7vliom13lm.fsf@alter.siamese.dyndns.org>
	<CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
	<7v39au1073.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 03:06:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsm4e-0001av-2B
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 03:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2BBCGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 21:06:37 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:33242 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754570Ab2BBCGg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 21:06:36 -0500
Received: by werb13 with SMTP id b13so1463561wer.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 18:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kKEYSfb3EDRQVRet/GHQTg9YWMJcziz4x1eZXnItefc=;
        b=OqOm4E/Z85SFahGP7+dRZRCDrJRg9wZziQeRZMkDjcrjoRY3hDatXXN6hRlTVQKcbE
         3q/X0sCLUbmcKTYDEvAuet92X6DZ2cLAhvQWhuitAgjDqstnhWBhrBly2a0k+6S3CIAp
         m267ajKreYI8m/VXsTlL7Lsgi56s1D3Zl5cjk=
Received: by 10.216.132.88 with SMTP id n66mr351788wei.32.1328148394525; Wed,
 01 Feb 2012 18:06:34 -0800 (PST)
Received: by 10.216.174.145 with HTTP; Wed, 1 Feb 2012 18:06:34 -0800 (PST)
In-Reply-To: <7v39au1073.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189577>

On 2 February 2012 02:41, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>>> When you say "alias.co =3D !git checkout --foo-bar", you are not sa=
ying
>>> "instead of usual aliases like 'alias.co =3D checkout' that defines=
 what
>>> string replaces the 'co' alias, please run !whatever command, captu=
re
>>> its output, and that is the _value_ of alias.co variable, i.e. the =
command
>>> line that is going to be run".
>>
>> I think I see your point. Using the same "!" notation for "execute
>> this command and exit" and "execute this command and use its result =
as
>> the config value" might be confusing.
>
> I am afraid that you are not seeing it. =A0In "alias.co =3D !whatever=
", bang
> does *NOT* mean "execute this command and exit".

Then I have been unclear. I understand what this does:

$ git config alias.foo '!echo foo'
$ git foo
foo

And if you were trying to say that having "!" denote "execute this
command and use its return as the config value" would be confusing as
it is different from its meaning for aliases then I see your point.

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
