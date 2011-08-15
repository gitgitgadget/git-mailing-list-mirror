From: Marko Vukovic <amasniko@yahoo.com>
Subject: Re: Core dump on commit
Date: Mon, 15 Aug 2011 15:55:06 +0000 (UTC)
Message-ID: <loom.20110815T174958-742@post.gmane.org>
References: <loom.20110815T162144-798@post.gmane.org> <CACsJy8CKFeSXy-QV=qdgtax92TdWCfem9rC-FYzptjd1JA1+AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 17:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QszWN-0001hQ-6P
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 17:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287Ab1HOPzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 11:55:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:56599 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab1HOPzU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 11:55:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QszVX-00014d-73
	for git@vger.kernel.org; Mon, 15 Aug 2011 17:55:19 +0200
Received: from CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com ([174.112.73.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 17:55:19 +0200
Received: from amasniko by CPE30469afe6059-CM001ceab6184c.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2011 17:55:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.112.73.117 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110621 Fedora/3.6.18-1.fc14 Firefox/3.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179377>

Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

> If I put a tag to HEAD, I could reproduce this. Let's assume that "git
> cat-file -t HEAD" in your repo returns "tag", how did you create the
> last commits? Did you modify a ref manually? What git version did you
> use?

Sorry, I do not understand what you mean by "modifying a ref manually". I
created the last commit and the tag with the Eclipse plugin "eGit". Later when I
could not create more commits, I deleted the tag from the command line and also
tried to commit from the command line which gave me the core dump.

I have got git.x86_64 package 1.7.4.4-1.fc14 installed on my computer.
