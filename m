From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] disable merge summaries if they are disabled
Date: Wed, 23 May 2007 21:58:23 +0200
Message-ID: <20070523195823.GA2554@steel.home>
References: <81b0412b0705230828s7fcdd836gf3bb92000d8ebd79@mail.gmail.com> <7vhcq32yda.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 23 21:59:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqwz9-0002xn-TX
	for gcvg-git@gmane.org; Wed, 23 May 2007 21:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbXEWT6b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 15:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757291AbXEWT6a
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 15:58:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:47473 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757186AbXEWT63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 15:58:29 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (mrclete mo55) (RZmta 6.7)
	with ESMTP id G04e92j4NH8VFm ; Wed, 23 May 2007 21:58:27 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B5AE3277BD;
	Wed, 23 May 2007 21:58:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1DE5DD195; Wed, 23 May 2007 21:58:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhcq32yda.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48168>

Junio C Hamano, Wed, May 23, 2007 20:22:57 +0200:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > Otherwise the merge.summary option has no visible effect.
> 
> I suspect you are mistaking a different merge summary.  The
> option affects fmt-merge-msg, iow, the shortlog looking summary
> that appears as the commit message in a merge commit.
> 
> The command line parameter --no-summary inhibits the diffstat
> given to the terminal after "git-pull/git-merge" is made.
> 

I did it again, didn't I?! :)
