From: Elrond <elrond+kernel.org@samba-tng.org>
Subject: Re: Remote git-cat-file?
Date: Sun, 28 May 2006 10:57:43 +0000 (UTC)
Message-ID: <loom.20060528T124835-757@post.gmane.org>
References: <loom.20060528T002420-957@post.gmane.org> <Pine.LNX.4.64.0605271727110.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 28 12:58:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkIyB-0005iR-H4
	for gcvg-git@gmane.org; Sun, 28 May 2006 12:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWE1K5x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 06:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWE1K5x
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 06:57:53 -0400
Received: from main.gmane.org ([80.91.229.2]:58286 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750709AbWE1K5w (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 06:57:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FkIxx-0005hi-CE
	for git@vger.kernel.org; Sun, 28 May 2006 12:57:49 +0200
Received: from p54A73631.dip0.t-ipconnect.de ([84.167.54.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 12:57:49 +0200
Received: from elrond+kernel.org by p54A73631.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 28 May 2006 12:57:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.167.54.49 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.3) Gecko/20060326 Firefox/1.5.0.3 (Debian-1.5.dfsg+1.5.0.3-2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20879>

Linus Torvalds <torvalds <at> osdl.org> writes:
[...]
> But in the general case, the answer is no. Set up a gitweb thing, and look 
> up the objects that way. Or just pull the repo, and look at it locally.

I ended up doing that (clone whole remote repo).


> Just out of interest, why would you ever want to just look at a single 
> object?

Well...
I screwed up my local clone of a repo. git-fsck told me what objects I needed.
So I finally ended up downloading the whole repo again to extract 16 objects. ;)


The other possible use for remote git-cat-file:
It might be useful in shallow repos to selectively load objects "on demand".
(In fact, I screwed my repo by trying to make it shallow.)


    Elrond
