From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
	add strbuf_initf()
Date: Sun, 29 Jun 2008 22:17:57 +0200
Message-ID: <20080629201757.GA27370@steel.home>
References: <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806281832510.9925@racer> <7vskuwek9w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806291436520.9925@racer>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:19:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3MU-0000J7-H2
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760155AbYF2USF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759889AbYF2USD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:18:03 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:18292 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549AbYF2USB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:18:01 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r84gO9V
Received: from tigra.home (Fa832.f.strato-dslnet.de [195.4.168.50])
	by post.webmailer.de (fruni mo42) (RZmta 16.45)
	with ESMTP id J04f73k5THWT0f ; Sun, 29 Jun 2008 22:17:58 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 98AE8277BD;
	Sun, 29 Jun 2008 22:17:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1E5A256D2A; Sun, 29 Jun 2008 22:17:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806291436520.9925@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86826>

Johannes Schindelin, Sun, Jun 29, 2008 15:40:57 +0200:
> On Sun, 29 Jun 2008, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Anyway, I'm fine with having them only in my personal fork.
> > 
> > It will cost you some "trust point" next time you try to sneak something
> > in as a part of a largely unrelated topic.  Please don't.
> 
> Fine.  Fine!
> 

See the positive side: you just won a "please review me carefully"
point. These have no negative side effects, usually.
