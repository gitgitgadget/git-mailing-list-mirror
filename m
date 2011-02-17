From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 12:06:33 +0000 (UTC)
Message-ID: <loom.20110217T130405-970@post.gmane.org>
References: <loom.20110217T074533-358@post.gmane.org> <20110217103431.GA8308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 13:06:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq2dL-0005j4-8U
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797Ab1BQMGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:06:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:48602 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565Ab1BQMGu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:06:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pq2dC-0005dS-CL
	for git@vger.kernel.org; Thu, 17 Feb 2011 13:06:46 +0100
Received: from 218.107.217.218 ([218.107.217.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 13:06:46 +0100
Received: from zhangchunlin by 218.107.217.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 13:06:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 218.107.217.218 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167071>

Jonathan Nieder <jrnieder <at> gmail.com> writes:

> 
> Chunlin Zhang wrote:
> Because you are writing a script, I'd suggest using one of the
> "low-level commands (plumbing)" listed in git(1).  Because you are
> retrieving a file, it would be one of the "interrogation commands".
> And because it is a single file, I suppose this should be git
> cat-file, git unpack-file, or git archive.
> 
> For example,
> 
> 	git cat-file blob HEAD:README
Wow,this solved my problem perfectly.
use this command for example:
git --work-tree=. --git-dir="/media/linux/t/kernel/.git" cat-file blob 
HEAD:Android.mk>Android.mk

Thanks !

> 
> will print the contents of README in the HEAD commit.
> 
> Because I am curious: what exactly would your script be used to do?
> Can the git diff-tree or git diff-files command help?
> 
