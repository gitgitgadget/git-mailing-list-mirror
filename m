From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adding rebase merge strategy
Date: Tue, 2 Oct 2007 11:00:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021056280.28395@racer.site>
References: <Pine.LNX.4.64.0709281751390.28395@racer.site>
 <11912513203420-git-send-email-tom@u2i.com> <7vr6ker1lf.fsf@gitster.siamese.dyndns.org>
 <550f9510710011441t1eb50352ofc8db77f79d794d5@mail.gmail.com>
 <87ejgescnb.wl%cworth@cworth.org> <550f9510710011521s126ca747v956a6f80182444bb@mail.gmail.com>
 <20071001223050.GE2137@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tom Clarke <tom@u2i.com>, Carl Worth <cworth@cworth.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 12:02:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IceZo-0007at-9o
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 12:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXJBKB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 06:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbXJBKB5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 06:01:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:58295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751119AbXJBKB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 06:01:56 -0400
Received: (qmail invoked by alias); 02 Oct 2007 10:01:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 02 Oct 2007 12:01:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1858HsNma85qFAIigCyjAYdMX5+e9Uy9WSejuh8+i
	BbdgQbCE7/+uN0
X-X-Sender: gene099@racer.site
In-Reply-To: <20071001223050.GE2137@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59679>

Hi,

On Mon, 1 Oct 2007, Shawn O. Pearce wrote:

> But I have to agree with (was it Junio who said this?) doing a rebase
> in a merge strategy doesn't make sense when conflicts come into play.

In contrast, I think that it makes sense, absolutely.  If you asked for 
"rebase", you _have_ to know what is coming.

It's all about convenience: in many repos, I just to "git pull", because 
there is really only one upstream.

But in one repo, the upstream is svn, and I mistakenly checked in a merge.  
Not wanting to know svn deeply, I have no nice way (as I would have with 
git) to cover up my mistake.  So in this repo, I would have liked to set 
branch.master.mergeOptions to '-s rebase'.

Ciao,
Dscho
