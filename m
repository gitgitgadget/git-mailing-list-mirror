From: Eric Raible <raible@gmail.com>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Thu, 2 Jul 2009 18:04:45 +0000 (UTC)
Message-ID: <loom.20090702T174843-784@post.gmane.org>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com> <m3hbxxx5jk.fsf@localhost.localdomain> <4A4A9FA5.7000009@gnu.org> <alpine.LFD.2.01.0906301813480.3605@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:05:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMQel-0002Jn-6v
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 20:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbZGBSFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 14:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZGBSFA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 14:05:00 -0400
Received: from main.gmane.org ([80.91.229.2]:55836 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751098AbZGBSE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 14:04:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MMQea-0002fQ-PS
	for git@vger.kernel.org; Thu, 02 Jul 2009 18:05:01 +0000
Received: from adsl-64-175-41-97.dsl.pltn13.pacbell.net ([64.175.41.97])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 18:05:00 +0000
Received: from raible by adsl-64-175-41-97.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 18:05:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.175.41.97 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.33 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122662>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> On Wed, 1 Jul 2009, Paolo Bonzini wrote:
> > 
> > I think he wants something more like
> > 
> > git diff `git log -2 --pretty=format:%h` <file> -- <file>
> 
> That's a rather difficult way of saying
> 
> 	git log --no-merges -p -1 <filename>
> 
> which seems much simpler. Sure, you'll get the commit message too, but 
> that just sounds like gravy to me (you can use "--pretty=oneline" or 
> something to make it denser).
> 
> 			Linus

Isn't the first one incorrect because  <file> needs to be inside the backticks?
git diff `git log -2 --pretty=format:%h <file>` -- <file>

And isn't the replacement incorrect also (the diffs are backwards)?
git log --no-merges -p -R -1 <file>

- Eric
