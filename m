From: Willy Tarreau <w@1wt.eu>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 11:52:30 +0100
Message-ID: <20070107105230.GA8345@1wt.eu>
References: <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com> <20070107090336.GA7741@1wt.eu> <20070107102853.GB26849@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 07 11:53:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Vex-0003yl-SD
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 11:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbXAGKxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 05:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbXAGKxs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 05:53:48 -0500
Received: from 1wt.eu ([62.212.114.60]:1824 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932490AbXAGKxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 05:53:47 -0500
To: Christoph Hellwig <hch@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
Content-Disposition: inline
In-Reply-To: <20070107102853.GB26849@infradead.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36151>

On Sun, Jan 07, 2007 at 10:28:53AM +0000, Christoph Hellwig wrote:
> On Sun, Jan 07, 2007 at 10:03:36AM +0100, Willy Tarreau wrote:
> > The problem is that I have no sufficient FS knowledge to argument why
> > it helps here. It was a desperate attempt to fix the problem for us
> > and it definitely worked well.
> 
> XFS does rather efficient btree directories, and it does sophisticated
> readahead for directories.  I suspect that's what is helping you there.

Ok. Do you too think it might help (or even solve) the problem on
kernel.org ?

Willy
