From: Cameron Hutchison <lists@xdna.net>
Subject: Adding a commit message to the index
Date: Sun, 19 Sep 2010 00:48:22 -0000
Message-ID: <3347.4c955dd6.4a79e@getafix.xdna.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 02:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox8D4-0008HN-Ow
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 02:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab0ISA4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 20:56:43 -0400
Received: from 121.140.233.220.static.exetel.com.au ([220.233.140.121]:36586
	"EHLO getafix.xdna.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab0ISA4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 20:56:43 -0400
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2010 20:56:43 EDT
Received: by getafix.xdna.net (Postfix, from userid 9)
	id 609B136197; Sun, 19 Sep 2010 10:48:22 +1000 (EST)
User-Agent: nn/6.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156480>

Is it possible to add a commit message to the index, and have it used as
the final commit message, or as the template for the final commit
message?

Witnessing AKPM's ongoing efforts on linux-kernel to get better commit
messages out of people, it seems it would be beneficial to be able to
stage a commit message and refine it over the course of the development
of the commit. The first cut is rarely the best, so being able to refine
a commit message as one can refine a commit by incrementally using the
index seems like a good idea.

I know I can use git-commit -F and store my commit message outside of
git, but it would be nice to have it in the index with the code it
comments on. That would make the commit and the message stay together
with git-stash for example. Apply this to other index-modifying
operations too.
