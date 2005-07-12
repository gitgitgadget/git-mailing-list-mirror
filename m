From: Junio C Hamano <junkio@twinsun.com>
Subject: Re: Why is there no git-update-cache --modified (aka I give up)
Date: Tue, 12 Jul 2005 20:51:17 +0000 (UTC)
Message-ID: <loom.20050712T224801-163@post.gmane.org>
References: <20050712055218.GA18192@buici.com> <7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net> <20050712155316.GA5841@buici.com> <pan.2005.07.12.16.16.45.990714@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 12 23:35:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsSOY-00065w-Fj
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 23:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVGLVYN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 17:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLVDL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 17:03:11 -0400
Received: from main.gmane.org ([80.91.229.2]:14570 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262423AbVGLVBA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 17:01:00 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DsRri-0008V1-E9
	for git@vger.kernel.org; Tue, 12 Jul 2005 23:00:34 +0200
Received: from ip-66-80-53-59.lax.megapath.net ([66.80.53.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:00:30 +0200
Received: from junkio by ip-66-80-53-59.lax.megapath.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 23:00:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.80.53.59 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf <at> smurf.noris.de> writes:

> 
> Hi, Marc Singer wrote:
> 
> >   # git-update-cache `git-diff-cache | cut -f2`
> 
> g-d-c should have an option to print file names only. All that cutting
> and argument-backtick-ing gets pretty nasty when there are a lot of files,
> or if they contain special characters.

I concur.  I'll add --name-only flag to diff brothers soonish.

Sorry I am at work and have turned the incoming connection to my home network
before I left for work today -- this is the same junkio@cox.net who is guilty
for all your diff problems ;-).
