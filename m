From: Eric Raible <raible@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Thu, 5 Nov 2009 18:38:03 +0000 (UTC)
Message-ID: <loom.20091105T193641-910@post.gmane.org>
References: <26217077.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67E8-0005lz-F4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 19:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758225AbZKESiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 13:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757262AbZKESiW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 13:38:22 -0500
Received: from lo.gmane.org ([80.91.229.12]:40939 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758037AbZKESiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 13:38:21 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N67E1-0005hb-OB
	for git@vger.kernel.org; Thu, 05 Nov 2009 19:38:25 +0100
Received: from c-69-181-183-221.hsd1.ca.comcast.net ([69.181.183.221])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 19:38:25 +0100
Received: from raible by c-69-181-183-221.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 19:38:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.181.183.221 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132233>

Richard Lee <richard <at> webdezign.co.uk> writes:

> So I tried using branches for features today. Most of the time I'm the only
> person working on a project. So when I've finished working on a feature
> branch and ready to merge it back into the master branch, the master head IS
> the common ancestor of the two branches. As shown below
> 
> * b6d75f1 [feature] stuff on feature branch
> * 43dba08 stuff on feature branch
> * ab7efdd [master] init
> 
> When I merge the graph looks likes this:
> 
> * b6d75f1 [master] [feature] stuff on feature branch
> * 43dba08 stuff on feature branch
> * ab7efdd init

You're getting a so-called "fast-forward" merge,
which is the default.  Turn it off with:

git merge --no-ff
