From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/3] Bringing git-ls-files to porcelain level
Date: Thu, 07 Jan 2010 18:40:50 +0100
Message-ID: <vpq3a2hlsnx.fsf@bauges.imag.fr>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 18:41:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwM8-0002oD-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 18:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0AGRlB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2010 12:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681Ab0AGRlB
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 12:41:01 -0500
Received: from mx2.imag.fr ([129.88.30.17]:33783 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab0AGRlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2010 12:41:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o07Hekmg010676
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Jan 2010 18:40:49 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NSwLq-000832-JV; Thu, 07 Jan 2010 18:40:50 +0100
In-Reply-To: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Fri\,  8
 Jan 2010 00\:07\:53 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Jan 2010 18:40:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o07Hekmg010676
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263490851.02777@NEI5Lbxrc5x/zJOnwzIwDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136366>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This is a hack, to scratch my itch. These patches add "git ls",
> which is equivalent to "git ls-files --max-depth 1|column"

You also want --exclude-standard to be the default in porcelain.

I've had "alias.ls =3D ls-files --exclude-standard" for a while in my
~/.gitconfig ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
