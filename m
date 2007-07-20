From: "Yann DIRSON" <yann.dirson@sagem.com>
Subject: qgit: failed assertion involving unapplied stgit patches
Date: Fri, 20 Jul 2007 16:31:42 +0200
Message-ID: <OF2EB5CD3A.5A6F9DF7-ONC125731E.004BD62A-C125731E.004FCEC9@sagem.com>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Cc: ydirson@altern.org, git@vger.kernel.org
To: Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBuMW-0007Cd-8M
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 17:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765652AbXGTPFN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 11:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765531AbXGTPFM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 11:05:12 -0400
Received: from ns2.sagem.com ([62.160.59.241]:39794 "EHLO mx2.sagem.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765409AbXGTPFL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 11:05:11 -0400
X-Greylist: delayed 1970 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2007 11:05:11 EDT
X-Disclaimed: 15851
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53097>


Hi Marco,

qgit 1.5.6 cannot show me the blame window for a given file, it complains
with the following errors:

ASSERT in getAncestor: ancestor of b617a11b801993b917e1598fd6c5a135ea74ce6f
not found
ASSERT in lookupAnnotation: no annotation for
FELIN1=5FDRIVERS/spi/mpc5200=5Fspi.c

The commit for which it cannot find an ancestor is an unapplied patch,
whose preceding patch has been refreshed already (ie. there is no ref
pointing to the parent commit), and I suspect this could be the reason for
the failure. At least once I have pushed this patch and popped it again,
the assertion does not show any more.

However, I'm not sure why it walks this part of the tree, since the
per-file history view does not show unapplied patches (it would be great to
see them, though, as well as showing applied patches as such).

Best regards,
--
Yann



" Ce courriel et les documents qui y sont attaches peuvent contenir des inf=
ormations confidentielles. Si vous n'etes  pas le destinataire escompte, me=
rci d'en informer l'expediteur immediatement et de detruire ce courriel  ai=
nsi que tous les documents attaches de votre systeme informatique. Toute di=
vulgation, distribution ou copie du present courriel et des documents attac=
hes sans autorisation prealable de son emetteur est interdite."=20

" This e-mail and any attached documents may contain confidential or propri=
etary information. If you are not the intended recipient, please advise the=
 sender immediately and delete this e-mail and all attached documents from =
your computer system. Any unauthorised disclosure, distribution or copying =
hereof is prohibited."
