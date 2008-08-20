From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Wed, 20 Aug 2008 21:54:01 +0200
Message-ID: <20080820195401.GD16626@blimp.local>
References: <20080819234433.GJ24212@spearce.org> <20080820193557.GB16626@blimp.local> <20080820194407.GJ3483@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtlw-0000b0-RW
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbYHTTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbYHTTyG
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:54:06 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:38175 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbYHTTyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:54:05 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (mrclete mo58) (RZmta 16.47)
	with ESMTP id p03732k7KIhjQG ; Wed, 20 Aug 2008 21:54:01 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C985E277AE;
	Wed, 20 Aug 2008 21:54:01 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id B3E4D36D18; Wed, 20 Aug 2008 21:54:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080820194407.GJ3483@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93023>

Shawn O. Pearce, Wed, Aug 20, 2008 21:44:07 +0200:
> 
> We could pick any number for the limit, just so long as its so
> large that the size of the reflog for it to be a valid @{nth}
> request would be something like 1 TB, and thus be highly unlikely.
> 
> I was just trying to be cute by using the original commit timestamp
> of Git itself.  Perhaps 12936648 (1TB / 83)?

How about the maximum value the platform's size_t can handle?

Not because it is "highly unlikely", but because you and me frankly
have no idea exactly how unlikely for example a "12936648 terabytes" is?
