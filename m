From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 05/26] Move "get_ack()" back to fetch-pack
Date: Thu, 29 Oct 2009 08:08:35 -0700
Message-ID: <20091029150835.GW10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-6-git-send-email-spearce@spearce.org> <7vljiudgrr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:08:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WcR-0006Fa-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbZJ2PId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755130AbZJ2PIc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:08:32 -0400
Received: from george.spearce.org ([209.20.77.23]:49870 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbZJ2PIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:08:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 36F35381D3; Thu, 29 Oct 2009 15:08:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vljiudgrr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131597>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > In 41cb7488 Linus moved this function to connect.c for reuse inside
> > of the git-clone-pack command.  That was 2005, but in 2006 Junio
> > retired git-clone-pack in commit efc7fa53.  Since then the only
> > caller has been fetch-pack.  Since this ACK/NAK exchange is only
> > used by the fetch-pack/upload-pack protocol we should keep move
> > it back to a private detail of fetch-pack.
> 
> Should we keep it there or should we move it?  which? ;-)

Right.  Fixed.

-- 
Shawn.
