From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: quieter installs
Date: Sun, 3 Jun 2007 15:17:34 +0200
Message-ID: <20070603131734.GE2495@steel.home>
References: <20070603010044.GA4507@spearce.org> <7vfy59oa71.fsf@assigned-by-dhcp.cox.net> <20070603060058.GC4507@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 15:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hupxn-0001va-5x
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 15:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbXFCNRh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 09:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762242AbXFCNRh
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 09:17:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:46071 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369AbXFCNRg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 09:17:36 -0400
Received: from tigra.home (Fad9e.f.strato-dslnet.de [195.4.173.158])
	by post.webmailer.de (mrclete mo1) (RZmta 7.1)
	with ESMTP id L06eebj53BOcr1 ; Sun, 3 Jun 2007 15:17:34 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E2685277BD;
	Sun,  3 Jun 2007 15:17:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C7644BE86; Sun,  3 Jun 2007 15:17:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070603060058.GC4507@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFkeiE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48990>

Shawn O. Pearce, Sun, Jun 03, 2007 08:00:58 +0200:
> Junio C Hamano <junkio@cox.net> wrote:
> >     make -C git-gui install
> >     make[1]: Entering directory `/git/git.git/git-gui'

You want to hide these (unless -w is given). The patch I just sent
does this.
