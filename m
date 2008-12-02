From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
 topic
Date: Tue, 2 Dec 2008 23:55:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812022353410.27091@racer>
References: <20081201173037.GA41967@agadorsparticus>  <20081201183258.GB24443@coredump.intra.peff.net>  <7v7i6jqriv.fsf@gitster.siamese.dyndns.org>  <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com>
 <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 23:57:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7eAs-0001uF-IC
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 23:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYLBWzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYLBWzl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 17:55:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:53692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751944AbYLBWzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 17:55:41 -0500
Received: (qmail invoked by alias); 02 Dec 2008 22:55:39 -0000
Received: from pD9EB3008.dip0.t-ipconnect.de (EHLO noname) [217.235.48.8]
  by mail.gmx.net (mp026) with SMTP; 02 Dec 2008 23:55:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+BzVDBk5+nyuJc1QRZnSqPra+yQDFUO/OSoSo+2
	KGWYBGuHQIG8XE
X-X-Sender: gene099@racer
In-Reply-To: <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102184>

Hi,

On Tue, 2 Dec 2008, James Pickens wrote:

> On Mon, Dec 1, 2008 at 11:10 PM, Scott Chacon <schacon@gmail.com> wrote:
>
> > On Mon, Dec 1, 2008 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> If this list is meant to show "the most commonly used" basics, then 
> >> you can trim the list somewhat.  For example, "rm" and "mv" can be 
> >> safely discarded, "status" can be replaced with "diff", and "diff" 
> >> can be removed from "History Commands".
> >
> > I sent a new patch that removes 'rm' and 'mv' and removes the 
> > common-cmd.h build process. I did keep the 'status' command, since in 
> > my personal experience people tend to like having that command.
> 
> Even though 'rm' might not be used very often, I think it's an important 
> enough command that it should not be removed from the 'basics' list. 
> AFAIK, the only other way to delete a file is 'rm file' followed by 'git 
> add -u' or 'git commit -a'.  Imagine a git newbie trying to figure that 
> out.
> 
> I'm tempted to say the same thing about 'mv' as well.  And FWIW, I use 
> 'status' a lot more than I use 'diff', so I would vote to keep 'status' 
> in the list too.

If the whole thing gets longer than 24 lines, we have to leave some things 
out.  Personally, I consider rm and mv unimportant enough that they could 
be shown in an extended list, but be left out of the summary page.

Ciao,
Dscho
