From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Git for collaborative web development
Date: Fri, 27 Mar 2009 01:57:21 +0100
Message-ID: <gqh89k$tob$1@ger.gmane.org>
References: <loom.20090326T184207-345@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 01:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln0Ph-00007e-E5
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 01:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933926AbZC0A5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 20:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933923AbZC0A5l
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 20:57:41 -0400
Received: from main.gmane.org ([80.91.229.2]:54933 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933922AbZC0A5k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 20:57:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ln0O9-0005pp-UZ
	for git@vger.kernel.org; Fri, 27 Mar 2009 00:57:37 +0000
Received: from 94.37.23.227 ([94.37.23.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 00:57:37 +0000
Received: from giuseppe.bilotta by 94.37.23.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 00:57:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 94.37.23.227
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114836>

On Thursday 26 March 2009 19:51, Carlo wrote:

> Hi,
> I'm going to work on a web project with a friend. We will host our code on a
> server and my idea was to set up a git repository (maybe using gitosis) so that
> we could work on our machines and push the changes to the server.
> 
> He said that it would be complicated, because if he's going to try some changes
> to show me on the fly he just can't. I mean, he would like to work on the code
> directly on the server, so that he can change the code, save and I can just
> refresh the page from my browser and see what he did.
> 
> Using git he should save, commit, add, push... so it's a bit longer.
> 
> Is there a nice compromise? Or a better way to use git for such a task or web
> development in general?

You could try using gitweb to expose the local repository directly.

If the web pages don't rely on hard-coded paths (i.e. all links are
relative) you should actually be able to navigate the tentative website
in plain blob view mode, for any given commit or branch.


-- 
Giuseppe "Oblomov" Bilotta
