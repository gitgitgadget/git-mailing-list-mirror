From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git config error message
Date: Mon, 12 Nov 2007 23:23:17 +0100
Message-ID: <20071112222317.GF2918@steel.home>
References: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhhQ-00074Y-94
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423AbXKLWXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759381AbXKLWXU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:23:20 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54186 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423AbXKLWXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:23:19 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (klopstock mo62) (RZmta 14.0)
	with ESMTP id v047dejACK9Urm ; Mon, 12 Nov 2007 23:23:17 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9431D277AE;
	Mon, 12 Nov 2007 23:23:17 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7505256D22; Mon, 12 Nov 2007 23:23:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64723>

Jon Smirl, Mon, Nov 12, 2007 16:35:07 +0100:
> I'm not in a git repo, this error message is misleading.
> 
> jonsmirl@terra:~/foo$ git config remote.origin.url
> http://git.digispeaker.com/projects/digispeaker-kernel.git
> could not lock config file
> 

Cygwin or any crashes in this repo lately?
If cygwin, than we probably have a file handle leak in config code.
