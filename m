From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: Re: Bug: git-svn dies with "Index mismatch"
Date: Wed, 18 Feb 2009 02:18:20 +0000 (UTC)
Message-ID: <loom.20090218T021740-983@post.gmane.org>
References: <36366a980902171815n37c3f17dw9836d62d4ff70a23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 03:21:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZc44-0004up-Bs
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 03:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbZBRCUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 21:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbZBRCUE
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 21:20:04 -0500
Received: from main.gmane.org ([80.91.229.2]:34800 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907AbZBRCUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 21:20:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LZc2c-0001dH-9f
	for git@vger.kernel.org; Wed, 18 Feb 2009 02:20:02 +0000
Received: from 74-203-51-134.static.twtelecom.net ([74-203-51-134.static.twtelecom.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 02:20:02 +0000
Received: from eric.hanchrow by 74-203-51-134.static.twtelecom.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 02:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 74.203.51.134 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110497>

Eric Hanchrow <eric.hanchrow <at> gmail.com> writes:

> 
> This is git version 1.6.2.rc0.10.gf6b9
> 
> The attached file clearly reproduces the problem.
> 
> Attachment (bug.sh): application/x-sh, 829 bytes


*ahem*.  Here's the bugaceous output:

Initialized empty Git repository in /tmp/imported.git/.git/
W: --tags/-t not specified
r1 = 0e3f46cda7254f990c38f383dc39a70fa7a5a4d4 (trunk)
        A       fabulous
r2 = 511040f48f8c1018a6073dfcc20668c8446300df (trunk)
r3 = cc910a8be29ec182017a97bdf2dfdce5fe6905bd (fred)
Found possible branch point: file:///tmp/svn-repos/trunk => file:///tmp/svn-
repos/branches/fred, 2
Found branch parent: (fred) 511040f48f8c1018a6073dfcc20668c8446300df
Index mismatch: 6d06bbf70c4a1f12a3174c8509c198db4762ecc1 != 
4b825dc642cb6eb9a060e54bf8d69288fbee4904
rereading 511040f48f8c1018a6073dfcc20668c8446300df
Following parent with do_switch
Filesystem has no item: File not found: revision 3, path 
'/branches/fred/fabulous' at /usr/local/stow/git/libexec/git-core/git-svn line 
3288

Brought to you by
git version 1.6.2.rc0.10.gf6b9
