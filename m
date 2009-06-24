From: Tom Lambda <tom.lambda@gmail.com>
Subject: git pull merges current branch even when <dst> is specified
Date: Wed, 24 Jun 2009 09:47:32 -0700 (PDT)
Message-ID: <1245862052581-3149948.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 18:48:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJVeb-0000rf-19
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 18:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761293AbZFXQra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbZFXQra
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 12:47:30 -0400
Received: from kuber.nabble.com ([216.139.236.158]:37236 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759788AbZFXQr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 12:47:29 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1MJVdE-0003uI-JG
	for git@vger.kernel.org; Wed, 24 Jun 2009 09:47:32 -0700
X-Nabble-From: tom.lambda@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122144>


If I am in 'master' and 'bugfix' is a remote branch in 'repo' which I do not
have locally yet, running:

git pull repo bugfix:bugfix

creates a new local branch 'bugfix' equals to 'repo/bugfix' as expected.
However, it also merges 'bugfix' into 'master', that surprises me since I
explicitly specify that <dst> is 'bugfix'.

I know that I can get what I want by running:

git fetch repo bugfix:bugfix

But the git-pull behavior looks odd to me. I thought that <dst> was the
current branch by default and it could be overridden by specifying it in the
command line.

Thank you,
Tom

-- 
View this message in context: http://n2.nabble.com/git-pull-merges-current-branch-even-when-%3Cdst%3E-is-specified-tp3149948p3149948.html
Sent from the git mailing list archive at Nabble.com.
