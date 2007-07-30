From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:42:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707301038380.4161@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
 <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net>
 <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org>
 <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de> <20070730081439.GA907@coredump.intra.peff.net>
 <E1575DD6-AC8C-49FD-A765-801A19E1FA73@zib.de> <20070730083223.GB3150@coredump.intra.peff.net>
 <Pine.LNX.4.64.0707300133210.6478@asgard.lang.hm>
 <20070730084138.GA4100@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: david@lang.hm, Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFZGk-0007gG-MW
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 19:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763894AbXG3Rmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763805AbXG3Rmz
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 13:42:55 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59164 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761163AbXG3Rmy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 13:42:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UHgZYj014183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Jul 2007 10:42:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6UHgTTs022033;
	Mon, 30 Jul 2007 10:42:29 -0700
In-Reply-To: <20070730084138.GA4100@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.73 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54245>



On Mon, 30 Jul 2007, Jeff King wrote:
> 
> If you followed a strict policy of always merging topics to a "base"
> branch as your first parent, then never allowing fast forwards should
> allow a very easy-to-read history in gitk.

Only if only *one* person ever does any merges.

Immediately when you have other people merging code, you're now back in 
the same boat.

This is why I personally think the whole policy of "no fast forward" is 
totally broken. It's only usable in a non-distributed environment, where 
there is one central person who does everythng (a so-called "star 
topology").

			Linus
