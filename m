From: Theodore Tso <tytso@mit.edu>
Subject: Re: I just pulled and built 'next'...
Date: Tue, 9 Jan 2007 08:54:01 -0500
Message-ID: <20070109135401.GB17352@thunk.org>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org> <20070109032124.GA1904@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 14:54:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4HQc-00018c-6Z
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 14:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbXAINyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 08:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbXAINyI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 08:54:08 -0500
Received: from thunk.org ([69.25.196.29]:44390 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932090AbXAINyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 08:54:06 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H4HUv-0002pI-Sp; Tue, 09 Jan 2007 08:58:42 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H4HQP-0000ZF-I0; Tue, 09 Jan 2007 08:54:01 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20070109032124.GA1904@spearce.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36358>

On Mon, Jan 08, 2007 at 10:21:24PM -0500, Shawn O. Pearce wrote:
> So what about doing Junio's suggestion of going by topology and
> coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
> right now), and if more than one is found compute the number of
> commits between each tag and the requested revision, and take the
> tag that has a smallest number of commits?

Ah, thanks for showing the example using git-rev-list.  I was assuming
"topology" based on the distance as shown by gitk, and that's quite
different from what git-rev-list shows.  Agreed, that hueristic makes
a lot of sense.

						- Ted
