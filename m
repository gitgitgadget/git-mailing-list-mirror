From: "Szuba, Marek (IKP)" <Marek.Szuba@kit.edu>
Subject: Possible error on the git-svn man page
Date: Fri, 28 Jun 2013 09:54:42 +0200
Organization: Karlsruhe Institute of Technology
Message-ID: <20130628095442.3304163d@ifurita.qm.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 10:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsTqU-0000of-BO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 10:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab3F1IPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 04:15:50 -0400
Received: from mailout.scc.kit.edu ([129.13.185.202]:54564 "EHLO
	mailout.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3F1IPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 04:15:48 -0400
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2013 04:15:48 EDT
Received: from KIT-MSX-04.kit.edu (kit-msx-04.kit.edu [172.21.117.14])
	by scc-mailout-02.scc.kit.edu with esmtps (Exim 4.72 #1)
	id 1UsTW0-00084t-Cq; Fri, 28 Jun 2013 09:54:44 +0200
Received: from ifurita.qm.lan (172.21.117.6) by smtp.kit.edu (172.21.117.14)
 with Microsoft SMTP Server (TLS) id 8.3.298.1; Fri, 28 Jun 2013 09:54:43
 +0200
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229178>

Hello,

On the git-svn(1) man page, the third example in the "Basic Examples"
section discusses how one can speed up the initial clone of a
Subversion repository by cloning it from Git first and linking it to
Subversion afterwards. However, it seems this example is not correct. I
have had several people try it on several different repositories, with
different git versions (specifically, 1.7 and 1.8) - and every time the
process fails at the same moment with the same error message:

$ git checkout -b master FETCH_HEAD
fatal: Cannot update paths and switch to branch 'master' at the same time.
Did you intend to checkout 'FETCH_HEAD' which can not be resolved as commit?

Therefore, I believe the man page ought to be updated so that the example works again.

If you have any questions, please let me know (by direct e-mail - I am not subscribed to the mailing list).

All the best,
-- 
MS
