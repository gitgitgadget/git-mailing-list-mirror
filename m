From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 20:17:37 +0100
Message-ID: <20080116191737.GD3181@steel.home>
References: <20080114202932.GA25130@steel.home> <20080115200437.GB3213@steel.home> <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com> <200801160002.51048.robin.rosenberg.lists@dewire.com> <20080116071832.GA2896@steel.home> <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com> <20080116183124.GA3181@steel.home> <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 20:18:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDm5-0005mu-1t
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbYAPTRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYAPTRk
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:17:40 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:10534 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYAPTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:17:39 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFj/1U=
Received: from tigra.home (Fad79.f.strato-dslnet.de [195.4.173.121])
	by post.webmailer.de (fruni mo4) (RZmta 15.4)
	with ESMTP id h04019k0GFrWqh ; Wed, 16 Jan 2008 20:17:37 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 640B0277AE;
	Wed, 16 Jan 2008 20:17:37 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4747256D22; Wed, 16 Jan 2008 20:17:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70728>

Paul Umbers, Wed, Jan 16, 2008 19:48:28 +0100:
> Latest output, log file attached:
> 
> paulumbers@Devteam29 ~/workspace/git/git-1.5.3
> $ uname -a > somefile
> 
> paulumbers@Devteam29 ~/workspace/git/git-1.5.3
> $ git init
> Initialized empty Git repository in .git/
> 
> paulumbers@Devteam29 ~/workspace/git/git-1.5.3
> $ strace -o log -f -m syscall ./git --exec-path=$(pwd) add somefile
> 

Could you please retry with "-m all"? "-m syscall" is not what one
might expect, its some tracing of cygwin and not enough at that.
