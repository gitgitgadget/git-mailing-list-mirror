From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Teach diff machinery to display other prefixes than "a/" and "b/"
Date: Tue, 18 Dec 2007 18:02:43 +0100
Message-ID: <vpqprx4uea4.fsf@bauges.imag.fr>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
	<Pine.LNX.4.64.0712181619550.23902@racer.site>
	<4767F935.8060207@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fqf-0001pd-Jo
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 18:03:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbXLRRCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 12:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbXLRRCz
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 12:02:55 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:53689 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbXLRRCy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 12:02:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id lBIH2hDp029457;
	Tue, 18 Dec 2007 18:02:44 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1J4fq7-0008Tf-SA; Tue, 18 Dec 2007 18:02:43 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1J4fq7-0007i9-Pe; Tue, 18 Dec 2007 18:02:43 +0100
In-Reply-To: <4767F935.8060207@obry.net> (Pascal Obry's message of "Tue\, 18 Dec 2007 17\:45\:41 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 18 Dec 2007 18:02:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68783>

Pascal Obry <pascal@obry.net> writes:

> Johannes Schindelin a =E9crit :
>> With the new option "--prefix=3D<prefix1>[:<prefix2>]" you can chang=
e
>> the shown prefix, or suppress it (by specifying the empty string).
>
> Why not ? But do you have a motivation for this change ? I mean why
> would you want to use a completely different prefix ?

It can make sense when you send the patch to someone who might not
know the context in which you wrote the patch, and who's not using
git. Then

--- your-version/foo.c
+++ my-version/foo.c

can be more expressive than a/ and b/. Some people like to have orig/
and mod/ also.

I can live without --prefix=3D... option, but doing it general at once
is a good idea, since adding this backward-compatibly on top of your
patch would mean having several redundant options.

--=20
Matthieu
