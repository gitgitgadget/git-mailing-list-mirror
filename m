From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git svn dcommit -> ignore one commit
Date: Wed, 01 Jun 2011 10:44:27 +0200
Message-ID: <vpqaae2lz4k.fsf@bauges.imag.fr>
References: <4DE5DA6A.8020201@codepill.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Dominik_=5C=22Socek=5C=22_D=C5=82ugajczyk?= 
	<dominik.dlugajczyk@codepill.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:44:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRh2i-0005p9-NO
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 10:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162712Ab1FAIoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2011 04:44:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50401 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162682Ab1FAIof convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 04:44:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p518iQbR030302
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2011 10:44:26 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QRh2R-0000SD-L6; Wed, 01 Jun 2011 10:44:27 +0200
In-Reply-To: <4DE5DA6A.8020201@codepill.com> ("Dominik \"Socek\"
 =?utf-8?Q?D=C5=82ugajczyk=22's?=
	message of "Wed, 01 Jun 2011 08:21:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Jun 2011 10:44:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p518iQbR030302
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1307522667.85396@5pDGyEPKlXJwgk6wcuu50w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174855>

"Dominik \"Socek\" D=C5=82ugajczyk" <dominik.dlugajczyk@codepill.com> w=
rites:

> My question: is there posibility to make dcommit ignore one specyfic =
commit?

You can probably use "git svn set-tree" for the commit after the one yo=
u
want to ignore. Test on a dumb repo before doing it in production ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
