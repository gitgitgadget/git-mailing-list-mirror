From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git-gui: add mingw specific startup wrapper
Date: Wed, 10 Oct 2007 16:56:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101653400.4174@racer.site>
References: <8F81028C-9924-4AA2-A58D-961AD10F5315@zib.de>
 <11919995392158-git-send-email-prohaska@zib.de> <11919995392881-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: spearce@spearce.org, git@vger.kernel.org, msysgit@googlegroups.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 17:57:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfdvW-0002c3-9T
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 17:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXJJP4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 11:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbXJJP4k
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 11:56:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:40531 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754878AbXJJP4j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 11:56:39 -0400
Received: (qmail invoked by alias); 10 Oct 2007 15:56:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 10 Oct 2007 17:56:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19b1Nl0DeRboHFXityWfYvNQdM5kMPJ7Az5kSxnsq
	Flgf7o+UuuIrB7
X-X-Sender: gene099@racer.site
In-Reply-To: <11919995392881-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60514>

Hi,

On Wed, 10 Oct 2007, Steffen Prohaska wrote:

> The wrapper adds the directory it is installed in to PATH.
> This is required for the git commands implemented in shell.
> git-gui fails to launch them if PATH is not modified.
> 
> The wrapper script also accepts an optional command line
> switch '--working-dir <dir>' and changes to <dir> before
> launching the actual git-gui. This is required to implement
> the "Git Gui Here" Explorer shell extension.

It should be mentioned here that the Explorer shell extension you talk 
about is the very simple extension provided by the Inno Installer.

I have a much larger and versatile shell extension in mind: git-cheetah.  
And fixing it is probably trivial; it can both change directory to the 
current directory (sounds wrong, doesn't it?) and extend the PATH 
appropriately before calling git-gui.

Note: the latter is not even necessary once we (correctly) add git to the 
PATH in the installer.

Ciao,
Dscho
