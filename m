From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Sun, 27 Apr 2014 17:06:26 +0200 (CEST)
Message-ID: <985432164.425366.1398611186431.JavaMail.zimbra@imag.fr>
References: <20140421204622.GA9532@logfs.org> <20140425182928.GA29904@logfs.org> <vpqoazpdz1r.fsf@anie.imag.fr> <20140425201048.GB29904@logfs.org> <20140426071358.GA7558@sigill.intra.peff.net> <CACsJy8ANE+2n6fd-mF5pp+p2sXy_uRzJ2c+O=AiySyre+6KLtg@mail.gmail.com> <20140427075640.GB19976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 17:06:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeQfA-0005nZ-W4
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 17:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbaD0PGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 11:06:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33197 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154AbaD0PGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 11:06:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3RF6OgS003799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 27 Apr 2014 17:06:25 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3RF6QbZ022948;
	Sun, 27 Apr 2014 17:06:26 +0200
In-Reply-To: <20140427075640.GB19976@sigill.intra.peff.net>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF27 (Linux)/8.0.6_GA_5922)
Thread-Topic: Revert "Stop starting pager recursively"
Thread-Index: CemaUYsFf64J7COq0Tn4jMoqyvBoyQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 27 Apr 2014 17:06:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3RF6OgS003799
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1399215989.59915@7XoZn7j5qYzjkSRY56ZpfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247204>

----- Original Message -----
> On Sun, Apr 27, 2014 at 09:12:39AM +0700, Duy Nguyen wrote:
>=20
> > The intent of the commit was "that is a stupid thing to do, but it'=
s
> > not so obvious from the first glance, do not freeze my system for m=
y
> > mistake". But if it stops an actual use case, then I agree it shoul=
d
> > be reverted.
>=20
> Thanks for the explanation. I think we should just go with J=C3=B6rn'=
s patch
> as-is, then.

Agreed. At best, the commit message could be improved to explain the
situation, but the patch itself is OK.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
