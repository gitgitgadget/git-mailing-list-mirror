From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
	descriptor
Date: Sat, 12 Jan 2008 21:16:22 +0100
Message-ID: <20080112201622.GA2992@steel.home>
References: <4787E981.7010200@nrlssc.navy.mil> <4787F1F5.2010905@nrlssc.navy.mil>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 12 21:17:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDmnG-0001Hq-Mm
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 21:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762957AbYALUQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 15:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762947AbYALUQ2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 15:16:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:20391 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762884AbYALUQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 15:16:26 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTShLis=
Received: from tigra.home (Fa8af.f.strato-dslnet.de [195.4.168.175])
	by post.webmailer.de (klopstock mo1) (RZmta 15.4)
	with ESMTP id e05affk0CDZXRp ; Sat, 12 Jan 2008 21:16:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 537E6277AE;
	Sat, 12 Jan 2008 21:16:23 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id B3E4756D22; Sat, 12 Jan 2008 21:16:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4787F1F5.2010905@nrlssc.navy.mil>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70356>

Brandon Casey, Fri, Jan 11, 2008 23:47:17 +0100:
> 
> It's reproduceable for me by amending the commit.
> 
> Any suggestions?

strace -o log -f git commit -C HEAD --amend

and post the "log" here (assuming it failed)
