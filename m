From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] check_repository_format_version(): run git_default_config()
 again
Date: Tue, 7 Aug 2007 00:26:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708070025320.14781@racer.site>
References: <2BA49414-54E0-4353-B237-7799B675FAE8@silverinsanity.com>
 <Pine.LNX.4.64.0708061831070.14781@racer.site> <7vbqdkcxy3.fsf@assigned-by-dhcp.cox.net>
 <7vsl6wbe9e.fsf@assigned-by-dhcp.cox.net> <7vy7go9s84.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:26:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIByU-0007uo-Jd
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 01:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbXHFX0z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 19:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbXHFX0z
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 19:26:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764390AbXHFX0y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 19:26:54 -0400
Received: (qmail invoked by alias); 06 Aug 2007 23:26:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 07 Aug 2007 01:26:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18i6jcbS2ginumDJZt8spbLof2AjVP3IzstYLyl3D
	pMfAwZLHNbu4gj
X-X-Sender: gene099@racer.site
In-Reply-To: <7vy7go9s84.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55187>

Hi,

On Mon, 6 Aug 2007, Junio C Hamano wrote:

> This is a minimum change in the sense that it restores the old
> behaviour of not even reading config in setup_git_directory(),
> but have the core.pager honored when we know it matters.

Looks obviously correct to me, and much better than relying on other sites 
reading the config.

ACK.

Ciao,
Dscho
