From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 03:12:06 -0500
Message-ID: <20080225081206.GO8410@spearce.org>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <20080225030404.GL8410@spearce.org> <20080225072658.GB15761@auto.tuwien.ac.at> <7vwsotmqq2.fsf@gitster.siamese.dyndns.org> <20080225075242.GD15761@auto.tuwien.ac.at> <7vmyppmpko.fsf@gitster.siamese.dyndns.org> <20080225080653.GA20048@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 25 09:12:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYSA-0004I2-Fk
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbYBYIMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 03:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYBYIMP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:12:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52115 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbYBYIMO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 03:12:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JTYRS-0006Yo-H5; Mon, 25 Feb 2008 03:12:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BF36020FBAE; Mon, 25 Feb 2008 03:12:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080225080653.GA20048@auto.tuwien.ac.at>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75009>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> On Mon, Feb 25, 2008 at 12:02:15AM -0800, Junio C Hamano wrote:
> > mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> > 
> > > What about
> > > #define OBJ_BAD -2
> > 
> > You mean "#define OBJ_ANY -2"?
> 
> Yes.
> 
> Should it go into cache.h or should it stay in fsck.h?

I'd rather see this declared at the end of enum object_type, as
essentially OBJ_MAX-1.  But Nico may have a different opinion.

As such it shouldn't need a numerical constant.  We don't encode
this constant into packfiles.

-- 
Shawn.
