From: Marko Vukovic <amasniko@yahoo.com>
Subject: Core dump on commit
Date: Mon, 15 Aug 2011 14:30:55 +0000 (UTC)
Message-ID: <loom.20110815T162144-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 16:35:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsyG1-000694-Vz
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 16:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab1HOOfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 10:35:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:42486 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761Ab1HOOfI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 10:35:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QsyFu-00063O-0t
	for git@vger.kernel.org; Mon, 15 Aug 2011 16:35:06 +0200
Received: from CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com ([174.112.73.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 16:35:06 +0200
Received: from amasniko by CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 16:35:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.112.73.117 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.6.18-1.fc14 Firefox/3.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179367>

I get this error after running "git commit"

error: Object 42504431bac2e2054483c1bbc35f1b535f8d11bb is a tag, not a commit
Segmentation fault (core dumped)

"git cat-file -p 42504431bac2e2054483c1bbc35f1b535f8d11bb" gives this:

object 1b9a97613307b5c7bbc189a0e41506cb1534740a
type commit
tag v1.0
tagger marko <marko@bib> Sun Aug 14 20:42:12 2011 -0400

The first release


I had created a tag yesterday which I deleted since with "git tag -d" command.

Curiously, I could not find file
".git/objects/42/504431bac2e2054483c1bbc35f1b535f8d11bb" which I expected based
on my very limited understanding of the Git internals. So, where does "git
cat-file" pick up that information from? But more importantly, how do I fix this
problem?
