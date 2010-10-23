From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Sync "git diff -h" with the manual, show options summary.
Date: Sat, 23 Oct 2010 20:04:26 +0200
Message-ID: <vpqvd4sn5ud.fsf@bauges.imag.fr>
References: <1287840825-6491-1-git-send-email-ydirson@altern.org>
	<AANLkTi=kETrjKccdVo188mKjX59mWeCRLVwGpiVP-oQ1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:08:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9iWC-0006GY-TH
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757828Ab0JWSIb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 14:08:31 -0400
Received: from imag.imag.fr ([129.88.30.1]:55568 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756842Ab0JWSIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:08:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o9NI4RKs007806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 23 Oct 2010 20:04:27 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P9iSA-0007Fv-Nw; Sat, 23 Oct 2010 20:04:26 +0200
In-Reply-To: <AANLkTi=kETrjKccdVo188mKjX59mWeCRLVwGpiVP-oQ1@mail.gmail.com> (Thiago Farina's message of "Sat\, 23 Oct 2010 16\:02\:49 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 23 Oct 2010 20:04:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159804>

Thiago Farina <tfransosi@gmail.com> writes:

> On Sat, Oct 23, 2010 at 11:33 AM, Yann Dirson <ydirson@altern.org> wr=
ote:
>> =A0static const char builtin_diff_usage[] =3D
>> -"git diff <options> <rev>{0,2} -- <path>*";
>> +"git diff [<common diff options>] <commit>{0,2} -- <path>*"
>
> Why change from <options> to <common diff options> ?

Because this is what the man page says I guess.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
