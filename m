From: Jeff King <peff@peff.net>
Subject: Re: confusion over the new branch and merge config
Date: Tue, 26 Dec 2006 02:33:49 -0500
Message-ID: <20061226073346.GA22218@segfault.peff.net>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net> <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612241544250.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 08:34:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz6pF-0004GS-8R
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 08:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWLZHdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 02:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWLZHdr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 02:33:47 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3964 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932506AbWLZHdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 02:33:47 -0500
Received: (qmail 22565 invoked by uid 1000); 26 Dec 2006 02:33:49 -0500
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612241544250.18171@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35414>

On Sun, Dec 24, 2006 at 03:49:50PM -0500, Nicolas Pitre wrote:

> What would be nice as well is to be able to provide only the _name_ of 
> the tracking branch without the refs/remotes/$origin/ prefix.  Since 
> there is already a 'branch."blah".remote = $origin' entry, then having 
> 'branch."blah".merge = $foo' could mean "refs/remotes/$origin/$foo" when 
> $foo contains no slash.

NAK. That makes branch names like "jc/foo" second-class citizens. You
would do better to say "entries without refs/ are implicitly local refs
in refs/remotes/".

-Peff
