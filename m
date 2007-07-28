From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a --user option to git-config
Date: Sat, 28 Jul 2007 21:04:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707282103150.14781@racer.site>
References: <46AB7041.8070605@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Jul 28 22:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEsWn-0000P9-4i
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 22:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbXG1UEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 16:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755072AbXG1UEg
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 16:04:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:55365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755056AbXG1UEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 16:04:35 -0400
Received: (qmail invoked by alias); 28 Jul 2007 20:04:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 28 Jul 2007 22:04:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hNQp+JLJh7YbFIaSPF+vvcuTEranPli6fTgUYQO
	KacSUaVHMsyzEi
X-X-Sender: gene099@racer.site
In-Reply-To: <46AB7041.8070605@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54056>

Hi,

On Sat, 28 Jul 2007, Ramsay Jones wrote:

> 
> At present, the --global option is something of a misnomer, so
> we introduce the --user option as a synonym, with the intention
> of removing the old option in the future.

Ack for the intention, except for "removing the old option in the future".  
We do not need to advertise it, but breaking existing functionality, which 
might be used by scripts and aliases is bad.

Ciao,
Dscho
