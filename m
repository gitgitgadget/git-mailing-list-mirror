From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.1
Date: Wed, 13 May 2009 11:31:51 -0700
Message-ID: <7vy6t04zxk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 20:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JFJ-0003uX-Iz
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242AbZEMSbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbZEMSbw
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:31:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35628 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbZEMSbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:31:51 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513183152.QJKF17670.fed1rmmtao101.cox.net@fed1rmimpo03.cox.net>;
          Wed, 13 May 2009 14:31:52 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id r6Xr1b00E4aMwMQ046Xsh7; Wed, 13 May 2009 14:31:52 -0400
X-Authority-Analysis: v=1.0 c=1 a=VwQbUJbxAAAA:8 a=rJ2SNjQboeCICQIKKwAA:9
 a=cg30MBeRlxRWnfW0QQbfP5u0ZtAA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119083>

The latest maintenance release GIT 1.6.3.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.3.1-1.fc9.$arch.rpm	(RPM)

Embarrasingly 1.6.3 has a rather grave regression when you switch to a new
branch while you have some changes added to the index.  A commit you make
from that index will record a wrong tree.  Please consider this a hotfix
and do not use vanilla 1.6.3.

----------------------------------------------------------------

Changes since v1.6.3 are as follows:

Alex Riesen (1):
      Clarify kind of conflict in merge-one-file helper

Alexander Potashev (1):
      Documentation: cloning to empty directory is allowed

Felipe Contreras (1):
      git config: clarify --add and --get-color

Junio C Hamano (4):
      Start 1.6.3.1 maintenance series.
      archive-tar.c: squelch a type mismatch warning
      Revert "checkout branch: prime cache-tree fully"
      GIT 1.6.3.1
