From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up some fallout from "setup_git_directory()" cleanups
Date: Mon, 31 Jul 2006 22:15:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607312215120.4168@g5.osdl.org>
References: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org>
 <7v7j1t5tgj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607311508060.4168@g5.osdl.org>
 <Pine.LNX.4.63.0608010118280.27436@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 07:16:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7mbo-00048N-Tz
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 07:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWHAFP6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 01:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWHAFP6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 01:15:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25487 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161050AbWHAFP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 01:15:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k715FpnW031729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Jul 2006 22:15:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k715FoPa001973;
	Mon, 31 Jul 2006 22:15:50 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608010118280.27436@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24574>



On Tue, 1 Aug 2006, Johannes Schindelin wrote:
> 
> Wouldn't this just be a _perfect_ task for 'sparse'?

Something like this?

		Linus
---
builtin-diff.c:266:7: warning: symbol 'i' shadows an earlier one
builtin-diff.c:226:6: originally declared here

builtin-fmt-merge-msg.c:141:7: warning: symbol 'len' shadows an earlier one
builtin-fmt-merge-msg.c:75:9: originally declared here

builtin-fmt-merge-msg.c:341:17: warning: symbol 'head' shadows an earlier one
builtin-fmt-merge-msg.c:252:13: originally declared here

builtin-mv.c:270:8: warning: symbol 'i' shadows an earlier one
builtin-mv.c:61:6: originally declared here

builtin-show-branch.c:755:17: warning: symbol 'commit' shadows an earlier one
builtin-show-branch.c:555:32: originally declared here

convert-objects.c:186:15: warning: symbol 'p' shadows an earlier one
convert-objects.c:154:10: originally declared here

date.c:635:14: warning: symbol 'n' shadows an earlier one
date.c:587:6: originally declared here

date.c:649:7: warning: symbol 'n' shadows an earlier one
date.c:587:6: originally declared here

fetch.c:51:16: warning: symbol 'tree' shadows an earlier one
fetch.c:37:37: originally declared here

fsck-objects.c:582:7: warning: symbol 'i' shadows an earlier one
fsck-objects.c:485:6: originally declared here

git.c:281:8: warning: symbol 'i' shadows an earlier one
git.c:263:6: originally declared here

pack-check.c:44:17: warning: symbol 'sha1' shadows an earlier one
pack-check.c:9:16: originally declared here

pack-objects.c:685:28: warning: symbol 'tree' shadows an earlier one
pack-objects.c:662:47: originally declared here

revision.c:85:17: warning: symbol 'commit' shadows an earlier one
revision.c:80:47: originally declared here

setup.c:165:7: warning: symbol 'len' shadows an earlier one
setup.c:156:6: originally declared here

tree-walk.c:116:21: warning: symbol 'entry' shadows an earlier one
tree-walk.c:113:20: originally declared here
