From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Fri, 08 Jun 2012 11:08:54 +0200
Message-ID: <vpqy5nyyxuh.fsf@bauges.imag.fr>
References: <4FCE07A5.9020001@ensimag.imag.fr>
	<1338902756-4162-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338902756-4162-3-git-send-email-simon.cathebras@ensimag.imag.fr>
	<vpqobow8a9l.fsf@bauges.imag.fr> <4FD1B209.702@ensimag.imag.fr>
	<vpqboku18qk.fsf@bauges.imag.fr>
	<CA+hdvHhPf-p0N36fXH6Spd-svQ2i1sU7Wc9g7T17Gh8dnA2T6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon.Cathebras@ensimag.imag.fr, git@vger.kernel.org,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, peff@peff.net, gitster@pobox.com,
	Charles Roussel <charles.roussel@ensimag.fr>
To: Simon Perrat <simon.perrat@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 11:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScvBu-0008Kq-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 11:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023Ab2FHJJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 05:09:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36048 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382Ab2FHJJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 05:09:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5890Bje029899
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 11:00:11 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScvBf-0007ob-3s; Fri, 08 Jun 2012 11:08:55 +0200
In-Reply-To: <CA+hdvHhPf-p0N36fXH6Spd-svQ2i1sU7Wc9g7T17Gh8dnA2T6Q@mail.gmail.com>
	(Simon Perrat's message of "Fri, 8 Jun 2012 11:04:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 11:00:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5890Bje029899
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339750812.68687@tA1jEWvrppGv0oaMr1dgkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199475>

Simon Perrat <simon.perrat@ensimag.imag.fr> writes:

> 2012/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>>
>> "Simon.Cathebras" <Simon.Cathebras@ensimag.imag.fr> writes:
>> > Do you mean that we should split the third patch into two patches =
?
>> > For instance::
>> > =A0 =A0 Patch 3/4: tests for git pull
>> > =A0 =A0 Patch 4/4: tests for git push
>>
>> Yes, except the title should mention git-remote-mediawiki, of course=
=2E
>>
>
> Should we split our test file in two then ? Currently they're all in =
t9361.

The patch I was commenting does

 t/t9360-git-mediawiki.sh | 265 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t9361-git-mediawiki.sh | 213 +++++++++++++++++++++++++++++++++++++

(BTW, you can find a better naming for the files, if one tests clone,
then clone should appear in the title, same for push/pull).

There's nothing wrong with touching several files in the same commit,
but when your commit messages looks like

- first file: does this
- second file: does that

and there's no dependencies, it's usually better to split the commit.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
