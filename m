From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Install built-ins as symlinks
Date: Wed, 12 Jul 2006 02:01:03 +0200
Message-ID: <20060712000103.GA5910@steel.home>
References: <11526131782190-git-send-email-alp@atoker.com> <11526131781900-git-send-email-alp@atoker.com> <1152613179634-git-send-email-alp@atoker.com> <11526131791902-git-send-email-alp@atoker.com> <11526131792773-git-send-email-alp@atoker.com> <11526131792377-git-send-email-alp@atoker.com> <Pine.LNX.4.63.0607111614550.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44B3BC94.3000204@atoker.com> <Pine.LNX.4.63.0607111951350.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060711184838.GC13776@pasky.or.cz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alp Toker <alp@atoker.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 02:01:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0SAM-00039E-7h
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 02:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWGLABR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWGLABR
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 20:01:17 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:38583 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932279AbWGLABP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 20:01:15 -0400
Received: from fwd33.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1G0SAB-0003WV-00; Wed, 12 Jul 2006 02:01:11 +0200
Received: from tigra.home (VsU6I6ZTweUMZQilmbw+R4cKNBuyIC++vuV1pyi4BqNCQh0tRl-QQp@[84.160.107.50]) by fwd33.sul.t-online.de
	with esmtp id 1G0SA4-24RDJA0; Wed, 12 Jul 2006 02:01:04 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 89C86277AF;
	Wed, 12 Jul 2006 02:01:03 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1G0SA3-0001yP-Eg; Wed, 12 Jul 2006 02:01:03 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060711184838.GC13776@pasky.or.cz>
User-Agent: Mutt/1.5.6i
X-ID: VsU6I6ZTweUMZQilmbw+R4cKNBuyIC++vuV1pyi4BqNCQh0tRl-QQp
X-TOI-MSGID: a67882aa-b29a-4f96-9504-3b8118995b75
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23749>

Petr Baudis, Tue, Jul 11, 2006 20:48:38 +0200:
> > And -- just maybe -- I _did_ mention a single reason to keep hard links: 
> > It works now. So why change it?
> 
>   The original patch mentioned why hardlinks are bad, so if you argue
> that the raised points are moot, you should give some substance to your
> argument.

Windows will add that substance, even if it is a dirty one: symlinks
don't work there properly (cygwin makes that very stupid .lnk file).
