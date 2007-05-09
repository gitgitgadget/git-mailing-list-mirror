From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 16:32:09 -0400
Message-ID: <20070509203209.GM23778@fieldses.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site> <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site> <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site> <20070509170725.GB23778@fieldses.org> <Pine.LNX.4.64.0705092208230.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@suse.cz>, kha@treskal.com, junio@cox.net,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 22:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlspm-0000LC-IZ
	for gcvg-git@gmane.org; Wed, 09 May 2007 22:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbXEIUcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 16:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXEIUcW
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 16:32:22 -0400
Received: from mail.fieldses.org ([66.93.2.214]:55145 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbXEIUcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 16:32:21 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlspV-0002p2-O8; Wed, 09 May 2007 16:32:09 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705092208230.4167@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46785>

On Wed, May 09, 2007 at 10:15:19PM +0200, Johannes Schindelin wrote:
> If you parse a number, passed to a program, with strtol(argv[1], NULL, 0) 
> you would expect something like this on an Intel processor:
> 
> Input 0x1234 -> memory 0x34 0x12 0x00 0x00.

Right, but this is something special to integers.  If it made sense for
some strange reason to define the structure carrying a sha1 as int[5]
instead of char[20] then I'd understand the confusion, but char[20] is
totally unambiguous.

> But if all this sounds too confusing, I agree to delete the 
> "(big-endian)".

Yeah, I think that'd be best; thanks.

--b.
