From: Gianluca Pacchiella <gianluca.pacchiella@ktln2.org>
Subject: Checkout of orphan branch files into mainline worktree
Date: Thu, 25 Mar 2010 11:39:42 +0100
Message-ID: <hofehl$jbn$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 11:45:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NukYr-0006OD-Fk
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 11:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab0CYKpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 06:45:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:56836 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752570Ab0CYKpE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 06:45:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NukYg-0006Kv-TC
	for git@vger.kernel.org; Thu, 25 Mar 2010 11:45:02 +0100
Received: from 151.59.101.45 ([151.59.101.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 11:45:02 +0100
Received: from gianluca.pacchiella by 151.59.101.45 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 11:45:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 151.59.101.45
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090706)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143176>

Hi folks,

I have a repository where I maintain a project for a web site with a branch
(disconnected from the mainline history) that contains some files
(necessary only for a particular instance of a site) that don't intersect
with others files in the main project. Since I don't want to use submodule
and subtree I manage myself to this sequence of commands ("deploy" is the
branch name of the mainline history and "index" of the --orphan branch) to
checkout the index's files into the mainline files

git read-tree index && ( git ls-files --with-tree=index | git
checkout-index --stdin ) && git read-tree deploy

Are there some other ways to do this? I'm crazy? are there side effects?

Thanks,
	Gianluca
