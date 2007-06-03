From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Sun, 3 Jun 2007 13:43:31 +0200
Message-ID: <20070603114331.GA2495@steel.home>
References: <20070531222313.GA12204@steel.home> <7v4pls1qjv.fsf@assigned-by-dhcp.cox.net> <81b0412b0706010035s5fc38dc6y6f985675cc3c069@mail.gmail.com> <20070601230924.GA6360@steel.home> <7vy7j2p1r5.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 13:43:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuoUq-0004i3-Q2
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 13:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbXFCLnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 07:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757780AbXFCLnf
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 07:43:35 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:48540 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbXFCLne (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 07:43:34 -0400
Received: from tigra.home (Fac8f.f.strato-dslnet.de [195.4.172.143])
	by post.webmailer.de (mrclete mo19) (RZmta 7.1)
	with ESMTP id G06f15j53BHQbX ; Sun, 3 Jun 2007 13:43:32 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 10706277BD;
	Sun,  3 Jun 2007 13:43:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A2D0DBE86; Sun,  3 Jun 2007 13:43:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy7j2p1r5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz12i0=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48980>

Junio C Hamano, Sat, Jun 02, 2007 21:58:22 +0200:
> I think the way QUIET_CC and friends are done is quite sensible

I don't think it is possible to implement this way: QUIET_CC uses
target-global $@, which the "install" target does not have.
