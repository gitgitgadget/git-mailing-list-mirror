From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC 1/3] send-pack: track errors for each ref
Date: Tue, 13 Nov 2007 21:18:59 +0100
Message-ID: <20071113201859.GE3268@steel.home>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113102709.GA2905@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is2EV-0006pR-4a
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbXKMUTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758352AbXKMUTH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:19:07 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:48237 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757926AbXKMUTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:19:05 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo49) (RZmta 14.0)
	with ESMTP id Y02236jADGdtkU ; Tue, 13 Nov 2007 21:19:00 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2C0BF277AE;
	Tue, 13 Nov 2007 21:19:00 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 966C356D22; Tue, 13 Nov 2007 21:18:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071113102709.GA2905@sigill.intra.peff.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64861>

Jeff King, Tue, Nov 13, 2007 11:27:09 +0100:
> Instead of keeping the 'ret' variable, we instead have a
> status flag for each ref that tracks what happened to it.
> We then print the ref status after all of the refs have
> been examined.

It wont apply to current master. How ready is built-in send-pack/push?
Should I fix send-pack.c properly?
