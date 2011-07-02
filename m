From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git svn : hook before 'git svn dcommit'
Date: Sat, 02 Jul 2011 15:54:06 +0200
Message-ID: <vpqboxcu6td.fsf@bauges.imag.fr>
References: <4E0F1383.8080804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 02 15:55:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd0fJ-0006Qt-6y
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 15:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab1GBNyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 09:54:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55392 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab1GBNyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2011 09:54:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p62Ds4ZH025843
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2011 15:54:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qd0e6-0001Se-Cn; Sat, 02 Jul 2011 15:54:06 +0200
In-Reply-To: <4E0F1383.8080804@gmail.com> (=?iso-8859-1?Q?=22Fr=E9d=E9ric?=
 Heitzmann"'s message of
	"Sat, 02 Jul 2011 14:48:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 02 Jul 2011 15:54:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p62Ds4ZH025843
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1310219648.56426@g6V2jlmG4h17nTFXNKVvrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176559>

=46r=E9d=E9ric Heitzmann <frederic.heitzmann@gmail.com> writes:

> The 'pre-svn-dcommit' hook si called before 'git svn dcommit', which =
aborts
> if return value is not zero.
> ---
>  git-svn.perl |   19 +++++++++++++++++++

What about documentation?

> +       if ($? =3D=3D -1) {
> +               print "[pre_svn_dcommit_hook] failed to execute $hook=
:
> $!\n";

whitespace damage (extra newline)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
