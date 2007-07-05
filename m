From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add -v|--verbose to git remote to show remote url
Date: Fri, 6 Jul 2007 00:02:47 +0200
Message-ID: <20070705220247.GD8751@steel.home>
References: <20070705215730.GC8751@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:02:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ZPY-0003C6-Qs
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 00:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760663AbXGEWCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 18:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760449AbXGEWCu
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 18:02:50 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:14439 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbXGEWCt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 18:02:49 -0400
Received: from tigra.home (Fa824.f.strato-dslnet.de [195.4.168.36])
	by post.webmailer.de (klopstock mo56) (RZmta 8.3)
	with ESMTP id 501c57j65HVxtU ; Fri, 6 Jul 2007 00:02:48 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CA323277BD;
	Fri,  6 Jul 2007 00:02:47 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 93E90C164; Fri,  6 Jul 2007 00:02:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070705215730.GC8751@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTYT9w==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51697>

Alex Riesen, Thu, Jul 05, 2007 23:57:30 +0200:
> +local $VERBOSE = 0;
> +@ARGV = grep { $VERBOSE=1,0 if $_ eq '-v' or $_ eq '--verbose' } @ARGV;
> +

Do NOT apply: this filters out _all_ of command line.
