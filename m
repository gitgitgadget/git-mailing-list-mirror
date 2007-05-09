From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 13:07:25 -0400
Message-ID: <20070509170725.GB23778@fieldses.org>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site> <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site> <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Petr Baudis <pasky@suse.cz>, kha@treskal.com, junio@cox.net,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 19:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlpde-0003Jf-PM
	for gcvg-git@gmane.org; Wed, 09 May 2007 19:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbXEIRHg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 13:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbXEIRHg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 13:07:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48667 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755334AbXEIRHe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 13:07:34 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlpdN-0007ta-N6; Wed, 09 May 2007 13:07:25 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705091822590.4167@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46753>

On Wed, May 09, 2007 at 06:25:01PM +0200, Johannes Schindelin wrote:
> None. I only suspected them to be carried out in byte order. From what I 
> know, there are some shifts involved, which might or might not be helped 
> by 32-bit arithmetic.
> 
> I did not really look into it.
> 
> From my prior debugging experiences on Intel, though, I automatically 
> looked for the least significant bytes at the beginning of those "sha1" 
> variables, and came up empty.

So, I'm confused about what you actually mean by "big endian" here.  I
originally assumed that you meant that SHA1's are defined as bit arrays,
and that the first bit of the SHA1 is in the high-order bit of the first
byte.  But if you just meant that the first byte of the SHA1 is stored
in the first byte of the array...  that kind of goes without saying,
doesn't it?

In any case, maybe this is a detail that's best left to the code itself.

--b.
