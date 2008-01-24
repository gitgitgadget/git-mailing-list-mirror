From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 22:36:40 -0500
Message-ID: <20080124033640.GM24004@spearce.org>
References: <20080123054709.GA13166@spearce.org> <7v7ii1ozly.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 04:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHsuC-0007NB-Vi
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 04:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYAXDgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 22:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYAXDgv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 22:36:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58896 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbYAXDgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 22:36:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JHstC-0004OX-UU; Wed, 23 Jan 2008 22:36:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 02E9620FBAE; Wed, 23 Jan 2008 22:36:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7ii1ozly.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71587>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > git-gui: Use gitattribute "encoding" for file content display
> >
> > Most folks using git-gui on internationalized files have complained
> > that it doesn't recognize UTF-8 correctly.  In the past we have just
> > ignored the problem and showed the file contents as binary/US-ASCII,
> > which is wrong no matter how you look at it.
> 
> Hmmm.
> 
> At least for now in 1.5.4, I'd prefer the way gitk shows UTF-8
> (if I recall correctly latin-1 or other legacy encoding, as long
> as LANG/LC_* is given appropriately, as well) contents without
> per-path configuration without introducing new attributes.

Hmm.  I'll try to rework something along those lines for 1.5.4 then.

-- 
Shawn.
