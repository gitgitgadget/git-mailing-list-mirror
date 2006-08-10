From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 09:47:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608100945430.13885@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net> <20060810033448.GH8776@1wt.eu>
 <7vu04lxjsv.fsf@assigned-by-dhcp.cox.net> <7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Willy Tarreau <w@1wt.eu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 09:47:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB5GR-0005Ui-78
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 09:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbWHJHrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 03:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161106AbWHJHra
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 03:47:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:63960 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161098AbWHJHra (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 03:47:30 -0400
Received: (qmail invoked by alias); 10 Aug 2006 07:47:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 10 Aug 2006 09:47:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25160>

Hi,

On Wed, 9 Aug 2006, Junio C Hamano wrote:

> +
> +	/* NUL terminate the result */
> +	if (desc.alloc <= desc.size) {
> +		desc.buffer = xrealloc(desc.buffer, desc.size + 1);
> +		desc.alloc++;

While in this particular case, desc.alloc cannot be smaller than desc.size 
(and therefore the condition in the if() is misleading), it might be 
better to write "desc.alloc = desc.size + 1;" for others to understand...

Ciao,
Dscho
