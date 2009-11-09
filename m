From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Re: Git drawbacks?
Date: Mon, 9 Nov 2009 16:11:48 +0000 (UTC)
Message-ID: <loom.20091109T170054-451@post.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 17:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Wqx-0006JR-Ow
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 17:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbZKIQMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 11:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbZKIQMQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:12:16 -0500
Received: from lo.gmane.org ([80.91.229.12]:51752 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756453AbZKIQMP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 11:12:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7Wqj-0006DY-Ml
	for git@vger.kernel.org; Mon, 09 Nov 2009 17:12:13 +0100
Received: from 212.92.145.7 ([212.92.145.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 17:12:13 +0100
Received: from divis1969 by 212.92.145.7 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 17:12:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 212.92.145.7 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.27 Safari/532.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132491>

Dmitry Potapov <dpotapov <at> gmail.com> writes:


> Actually, in most use cases, there is no reason to have more than one
> working tree. Git is designed to work well with plenty branches and one
> working tree. So, switching between two branches and recompiling a few
> changed files is much faster then going to another directory and try to
> work there, because when you go to another directory, you may hit cold
> cache and disk is *slow*... Another thing is that you can do a lot of
> things without checking out some branch. You can grep any revision in
> your repository, you can insect any file from it, etc and you do not
> have to checkout this revision in your working tree.

Shouldn't I even worry about my not yet commited changes before switching the 
branch?

I would say that this approach does not work if the build and test could take
significant time. While in CR fix I don't want to wait for a build to complete
before I countinue with another bug/fix. That is why I'm curious about 
few working trees...
