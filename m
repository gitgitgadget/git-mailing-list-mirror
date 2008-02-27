From: Paul Mackerras <paulus@samba.org>
Subject: Suggestion: make --left-right work with --merge
Date: Wed, 27 Feb 2008 13:49:07 +1100
Message-ID: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 03:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUCN9-0000Gh-L9
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 03:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbYB0CtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 21:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYB0CtS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 21:49:18 -0500
Received: from ozlabs.org ([203.10.76.45]:44391 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753933AbYB0CtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 21:49:18 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 870E2DDE3A; Wed, 27 Feb 2008 13:49:15 +1100 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75200>

It would be nice if git-log --merge --left-right did what git log
--merge does but additionally, if the merge is a 2-way merge, marked
commits with '<' or '>' according to which side of the merge they came
from.  Would that be possible?  I think the visual indication that
--left-right gives in gitk would be useful with --merge.

Paul.
