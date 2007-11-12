From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git config error message
Date: Mon, 12 Nov 2007 23:26:29 +0100
Message-ID: <20071112222629.GG2918@steel.home>
References: <9e4733910711120735p653c643eveb44627bf4532b1a@mail.gmail.com> <20071112222317.GF2918@steel.home> <Pine.LNX.4.64.0711122224190.4362@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 23:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhkL-0008AT-ER
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 23:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759786AbXKLW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 17:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759782AbXKLW0c
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 17:26:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:19456 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbXKLW0b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 17:26:31 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (mrclete mo9) (RZmta 14.0)
	with ESMTP id m0279cjACKLPwT ; Mon, 12 Nov 2007 23:26:29 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 53108277AE;
	Mon, 12 Nov 2007 23:26:29 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 32DA856D22; Mon, 12 Nov 2007 23:26:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711122224190.4362@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64725>

Johannes Schindelin, Mon, Nov 12, 2007 23:24:54 +0100:
> Hi,
> 
> On Mon, 12 Nov 2007, Alex Riesen wrote:
> 
> > Jon Smirl, Mon, Nov 12, 2007 16:35:07 +0100:
> > > I'm not in a git repo, this error message is misleading.
> > > 
> > > jonsmirl@terra:~/foo$ git config remote.origin.url
> > > http://git.digispeaker.com/projects/digispeaker-kernel.git
> > > could not lock config file
> > > 
> > 
> > Cygwin or any crashes in this repo lately?
> > If cygwin, than we probably have a file handle leak in config code.
> 
> He said that he's not in a git repo.  Thus, .git/config does not exist, 
> and is not lockable, since not even .git/ exists.
> 

Oh.
