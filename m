From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH 4/4] Disallow working directory commands in a bare repository.
Date: Sun, 31 Dec 2006 07:49:21 -0500
Message-ID: <20061231124921.GA14286@thunk.org>
References: <3ffc8ddd9b500c2a34d2bd6ba147dc750d951bcd.1167539318.git.spearce@spearce.org> <20061231043238.GD5823@spearce.org> <7virfsk4sd.fsf@assigned-by-dhcp.cox.net> <20061231061122.GB6106@spearce.org> <7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 13:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1083-0000hI-KI
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 13:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162AbWLaMt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 07:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933163AbWLaMt1
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 07:49:27 -0500
Received: from thunk.org ([69.25.196.29]:41077 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933162AbWLaMt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 07:49:26 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H10CF-0001vB-82; Sun, 31 Dec 2006 07:53:51 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H107t-00073d-NX; Sun, 31 Dec 2006 07:49:21 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk608fq9u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35695>

On Sun, Dec 31, 2006 at 12:01:01AM -0800, Junio C Hamano wrote:
> > Why not just tell these users to setup the working directories with
> > local .git directories and not use GIT_DIR?
> 
> suggest that we might want to bite the bullet and declare that
> these things are not supported anymore in v1.5.0.

While we're talking about potentially deprecating GIT_DIR for users,
out of curiosity, what valid workflows would cause users to want to
use GIT_INDEX_FILE and GIT_OBJECT_DIRECTORY?  Seems like they would
cause more confusion and support problems than anything else.  

						- Ted
