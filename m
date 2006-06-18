From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] auto-detect changed $prefix in Makefile and properly rebuild to avoid broken install
Date: Sun, 18 Jun 2006 15:31:38 +0200
Message-ID: <20060618133138.GO2609@pasky.or.cz>
References: <0J0V00LDT7B9BU00@mxout2.netvision.net.il> <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yakov Lerner <iler.ml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 15:30:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrxMJ-0007Ey-EX
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWFRNac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 09:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWFRNac
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:30:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2264 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932221AbWFRNac (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 09:30:32 -0400
Received: (qmail 22405 invoked by uid 2001); 18 Jun 2006 15:31:38 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vver3cxlw.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22080>

Dear diary, on Wed, Jun 14, 2006 at 10:04:43PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - we may want to make the state file a bit more visible (IOW, I
>    somewhat do mind the name being dot-git-dot-prefix).

What is the point? It is just a bit of internal build system state made
persistent and shouldn't be interesting for the user, so why give it
extra publicity in the tree?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
