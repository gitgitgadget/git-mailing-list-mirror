From: Theodore Tso <tytso@mit.edu>
Subject: Re: git-receive-pack doesn't understand objects/info/alternates?
Date: Mon, 16 Apr 2007 14:48:51 -0400
Message-ID: <20070416184851.GH27533@thunk.org>
References: <E1HdQDl-0005ia-Bn@candygram.thunk.org> <8aa486160704160613t3ac17e4co9177ad91fda8eb36@mail.gmail.com> <20070416153040.GG27533@thunk.org> <7v3b30usth.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 20:49:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdWGN-0003cw-H8
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 20:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211AbXDPStG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 14:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbXDPStG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 14:49:06 -0400
Received: from thunk.org ([69.25.196.29]:45671 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754211AbXDPStF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 14:49:05 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HdWMO-0000y4-GR; Mon, 16 Apr 2007 14:55:33 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1HdWFv-0000LV-Nn; Mon, 16 Apr 2007 14:48:51 -0400
Content-Disposition: inline
In-Reply-To: <7v3b30usth.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44686>

On Mon, Apr 16, 2007 at 10:34:18AM -0700, Junio C Hamano wrote:
> Theoretically speaking, not necessarily.  Practically speaking
> it perhaps may.
> 
> When Linus runs 'pack-refs --prune', your kludge symlink would
> not be of any help, as the command removes everything under his
> linux-2.6.git/refs directory and records the equivalent
> information in linux-2.6.git/packed-refs file.

Right, but I thought we weren't supposed to do running pack-refs
--prune on master.kernel.org since that would break users using old
git 1.4.x clients and who are accessing the repository over the http
transport.  Or are we not considering that supported anymore on kernel.org?
	
						- Ted
