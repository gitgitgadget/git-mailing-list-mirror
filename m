From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to say HEAD~"all the way back - 1"
Date: Thu, 22 Feb 2007 21:53:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222153010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17885.60477.53356.123095@lisa.zopyra.com>
 <7vodnmdk8y.fsf@assigned-by-dhcp.cox.net> <20070222204737.GC18622@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Bill Lear <rael@zopyra.com>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKx5-0003Ww-0O
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbXBVUyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXBVUyD
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:54:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:42757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751880AbXBVUyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:54:01 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:53:59 -0000
X-Provags-ID: V01U2FsdGVkX1/oYTchMtnoAXUFNWOd9KQ6jysKMoTd1/9s3C25C/
	VWQg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070222204737.GC18622@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40388>

Hi,

On Thu, 22 Feb 2007, J. Bruce Fields wrote:

> I can do something like
> 
> 	git rev-list origin..topic | tail -2 | head -1
> 
> but in practice it's faster just to fire up gitk origin.. and
> cut-n-paste object id's.

Or something like

	git rev-list --reverse origin..topic | sed -n 2p

But that's even longer! (Although conceptually shorter...)

Ciao,
Dscho
