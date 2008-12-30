From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Extracting a single commit or object
Date: Tue, 30 Dec 2008 14:21:06 -0800
Message-ID: <20081230222106.GE29071@spearce.org>
References: <21223948.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: yitzhakbg <yitzhakbg@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 23:22:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmyt-0005Xw-62
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 23:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYL3WVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYL3WVJ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 17:21:09 -0500
Received: from george.spearce.org ([209.20.77.23]:37946 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYL3WVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 17:21:08 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2B59F38200; Tue, 30 Dec 2008 22:21:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <21223948.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104216>

yitzhakbg <yitzhakbg@gmail.com> wrote:
> 
> How would I extract a single commit from a repository by it's SHA1 (or any
> other treeish)?
> For that matter, how is any one single object extracted? Examples please.

git cat-file $type $sha1

e.g.

git cat-file commit $commitsha1
git cat-file blob $blobsha1

If you need to inspect a tree, ls-tree is probably better:

git ls-tree $commitsha1
git ls-tree $treesha1

-- 
Shawn.
