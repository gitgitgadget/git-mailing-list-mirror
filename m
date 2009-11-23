From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] pack-objects: split implications of --all-progress
 from  progress activation
Date: Mon, 23 Nov 2009 20:04:02 +0100
Message-ID: <20091123190402.GE26996@machine.or.cz>
References: <20091122145352.GA3941@debian.b2j>
 <20091123145959.GA13138@sigill.intra.peff.net>
 <20091123155043.GA28963@machine.or.cz>
 <20091123164319.GA23011@sigill.intra.peff.net>
 <alpine.LFD.2.00.0911231221320.2059@xanadu.home>
 <20091123181206.GD26996@machine.or.cz>
 <alpine.LFD.2.00.0911231323010.2059@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCeCr-0008L0-NX
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 20:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbZKWTD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 14:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbZKWTD6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 14:03:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43331 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbZKWTD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 14:03:58 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7919F125A0EC; Mon, 23 Nov 2009 20:04:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911231323010.2059@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133525>

On Mon, Nov 23, 2009 at 01:27:14PM -0500, Nicolas Pitre wrote:
> On Mon, 23 Nov 2009, Petr Baudis wrote:
> > Naive deduction fails:
> > 
> > 	$ git remote update --progress
> > 	error: unknown option `progress'
> 
> Usage of 'git remote" is about fetching and not pushing, right? My patch 
> only affects pushes.  So I don't know what old behavior you're after.

Oh, I'm sorry, in that case I was confused from the very beginning;
somehow I saw pull instead of push in the initial mail.

				Petr "Pasky" Baudis
