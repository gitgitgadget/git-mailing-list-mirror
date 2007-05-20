From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] allow commands to be executed in submodules
Date: Sun, 20 May 2007 22:59:33 +0200
Message-ID: <20070520205933.GD25462@steel.home>
References: <20070520153908.GF5412@admingilde.org> <20070520181433.GA19668@steel.home> <7vhcq7mjxn.fsf@assigned-by-dhcp.cox.net> <20070520204801.GH5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sun May 20 22:59:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsVB-0001e1-2Z
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756373AbXETU7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbXETU7g
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:59:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:20097 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbXETU7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:59:35 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (klopstock mo39) (RZmta 6.5)
	with ESMTP id I04736j4KIJFAV ; Sun, 20 May 2007 22:59:33 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 781F2277BD;
	Sun, 20 May 2007 22:59:33 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 59E03D195; Sun, 20 May 2007 22:59:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520204801.GH5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47916>

Martin Waitz, Sun, May 20, 2007 22:48:02 +0200:
> Do we really have so many places where we want to execute commands
> in a different directory or with different environment?  Is it worth
> keeping run-command generic and having to introduce knowledge about
> how to run submodule commands in multiple places?

Is there multiple places? Is it hard to create a specific function out
of a generic one? (which can be used from other places and your
specific can't and we would need the generic one anyway).

"Generic" is not about "multiple places". Generic is about "general"
as opposite to "specific". Gives you flexibility and wider application
range.
