From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix rebase interactive to allow specifying branch to rebase along with the base
Date: Thu, 2 Aug 2007 00:40:14 +0200
Message-ID: <20070801224014.GD2911@steel.home>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site> <20070712222640.GA30532@steel.home> <Pine.LNX.4.64.0708011654510.14781@racer.site> <20070801214556.GA2911@steel.home> <20070801223241.GB2911@steel.home> <Pine.LNX.4.64.0708012336170.14781@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:40:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMrh-0000kI-Gd
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXHAWkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753587AbXHAWkR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:40:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:14521 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbXHAWkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:40:16 -0400
Received: from tigra.home (Fae16.f.strato-dslnet.de [195.4.174.22])
	by post.webmailer.de (klopstock mo11) (RZmta 10.3)
	with ESMTP id 006255j71Ixs2t ; Thu, 2 Aug 2007 00:40:14 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 425B8277BD;
	Thu,  2 Aug 2007 00:40:14 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0B597C21D; Thu,  2 Aug 2007 00:40:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708012336170.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3urCQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54494>

Johannes Schindelin, Thu, Aug 02, 2007 00:36:58 +0200:
> On Thu, 2 Aug 2007, Alex Riesen wrote:
> >  		require_clean_work_tree
> > +		mkdir "$DOTEST" || die "Could not create temporary $DOTEST"
> 
> Heh.  I take that as an ACK from you to my patch?  Mine has a test case, 
> too ;-)

ACK, indeed 8)
