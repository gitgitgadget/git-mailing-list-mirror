From: Karl Chen <quarl@cs.berkeley.edu>
Subject: git-update-index -q
Date: Tue, 02 Sep 2008 10:51:50 -0700
Message-ID: <quack.20080902T1051.lth1w02mo5l@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 19:53:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaa3j-0001yf-Sk
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 19:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYIBRvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 13:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYIBRvv
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 13:51:51 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:49469 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422AbYIBRvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 13:51:50 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id 3EDD034451; Tue,  2 Sep 2008 10:51:50 -0700 (PDT)
X-Quack-Archive: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94686>


The git-update-index man page entry for -q says:

       -q
           Quiet. If --refresh finds that the index needs an
           update, the default behavior is to error out. This
           option makes git-update-index continue anyway.

Can someone explain this to me?  As far as I can tell,
git-update-index without -q does not error out after the first
update.
