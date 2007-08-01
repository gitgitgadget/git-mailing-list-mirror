From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/3] rebase -i: handle --continue more like non-interactive rebase
Date: Wed, 1 Aug 2007 23:45:56 +0200
Message-ID: <20070801214556.GA2911@steel.home>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site> <20070712222640.GA30532@steel.home> <Pine.LNX.4.64.0708011654510.14781@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:46:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGM15-0000A5-5A
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 23:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbXHAVqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 17:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXHAVp7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 17:45:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:44205 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbXHAVp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 17:45:59 -0400
Received: from tigra.home (Fae16.f.strato-dslnet.de [195.4.174.22])
	by post.webmailer.de (mrclete mo7) (RZmta 10.3)
	with ESMTP id 6072faj71Hv2BC ; Wed, 1 Aug 2007 23:45:56 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9B433277BD;
	Wed,  1 Aug 2007 23:45:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 107E6C21D; Wed,  1 Aug 2007 23:45:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708011654510.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3urCQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54479>

Johannes Schindelin, Wed, Aug 01, 2007 17:57:25 +0200:
> On Fri, 13 Jul 2007, Alex Riesen wrote:
> > Johannes Schindelin, Sun, Jul 08, 2007 04:01:29 +0200:
> > > Non-interactive rebase requires the working tree to be clean, but
> > > applies what is in the index without requiring the user to do it
> > > herself.  Imitate that, but (since we are interactive, after all)
> > > fire up an editor with the commit message.
> > 
> > Could we also have "git rebase <base> <branch>"?
> 
> Don't we do that already?  AFAICT it is already in the synopsis, ever 
> since rebase -i was introduced into the "next" branch, on June 25...
> 

Err... "git rebase -i <base> <branch>"

Does not work, just checked:

    $ git rebase -i base branch
    /usr/local/bin/git-rebase--interactive: 482: cannot create /home/user/projects/tmp/.git/.dotest-merge/output: Directory nonexistent
    cat: /home/user/projects/tmp/.git/.dotest-merge/output: No such file or directory
    Invalid branchname: branch
