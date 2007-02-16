From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add git-bundle - pack objects and references for disconnected transfer
Date: Fri, 16 Feb 2007 01:54:21 -0500
Message-ID: <20070216065421.GG28894@spearce.org>
References: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net> <11716079843500-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 07:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHwzI-0001E6-A2
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 07:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbXBPGy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 01:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXBPGy1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 01:54:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46971 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXBPGy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 01:54:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHwz9-0004IX-RU; Fri, 16 Feb 2007 01:54:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AF2DF20FBAE; Fri, 16 Feb 2007 01:54:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <11716079843500-git-send-email-mdl123@verizon.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39893>

Mark Levedahl <mdl123@verizon.net> wrote:
> +# create the tar file, clean up
> +tar cf "$bfile" --absolute-names --transform="s,$tmp-,," \
> +    --verbose --show-transformed-names \
> +    "$references" "$pack"

I'm not sure this will work on FreeBSD.  Both 5.1 and 6.1 use tar
that does not know about --absolute-names, --transform, --verbose,
or --show-transformed-names.

-- 
Shawn.
