From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-whatchanged -<n>
Date: Wed, 27 Aug 2008 17:07:36 -0700
Message-ID: <quack.20080827T1707.lth1w0aknnb@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:08:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYV46-0000gq-AL
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbYH1AHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754AbYH1AHh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:07:37 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:41224 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbYH1AHh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:07:37 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id B139C34468; Wed, 27 Aug 2008 17:07:36 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93995>


Is this a bug in git-whatchanged, or at least an insufficiently
documented feature?

cd git

git whatchanged 837a156197e7~20..837a156197e7 -1 

    [nothing]

git whatchanged 837a156197e7~20..837a156197e7 -3

    [1 commit]

git whatchanged 837a156197e7~20..837a156197e7 -1 -m

    [1(?) commit]

It appears that without -m, merges are filtered after commits are
counted.
