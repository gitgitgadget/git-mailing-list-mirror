From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t7004: ship trustdb to avoid gpg warnings
Date: Sat, 30 Jun 2007 20:14:01 -0700
Message-ID: <7v1wfsak92.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706301956240.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 05:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4ptC-0002TA-Vt
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 05:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbXGADOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 23:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbXGADOE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 23:14:04 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60925 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXGADOD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 23:14:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701031402.QWRS1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 23:14:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J3E11X0021kojtg0000000; Sat, 30 Jun 2007 23:14:01 -0400
In-Reply-To: <Pine.LNX.4.64.0706301956240.4438@racer.site> (Johannes
	Schindelin's message of "Sat, 30 Jun 2007 19:56:52 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51271>

This avoids warning messages from gpg while verifying the tags; without it,
the program complains that the key is not certified with a trusted signature.

---
 t/t7004/trustdb.gpg |  Bin 0 -> 1280 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 t/t7004/trustdb.gpg

diff --git a/t/t7004/trustdb.gpg b/t/t7004/trustdb.gpg
new file mode 100644
index 0000000000000000000000000000000000000000..abace962b8bf84be688a6f27e4ebd0ee7052f210
GIT binary patch
literal 1280
zcmZQfFGy!*W@Ke#U|?`dKkWykumMIcY@%4iM%7^n6rj+M4;MLzzlOX&pwTnxkD-}P
zc^HbXN0fL!SIq1?>env3?W^3`d(OOU5YNaX{KU(k^<0;M@87ONv)_6ZxD={-=<kYO
M2Ud3=2BC}r0AuhNr2qf`

literal 0
HcmV?d00001

-- 
1.5.2
