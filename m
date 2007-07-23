From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe: Add unlisted option
Date: Mon, 23 Jul 2007 03:47:36 -0400
Message-ID: <20070723074736.GJ32566@spearce.org>
References: <87sl7fmyca.wl@mail2.atmark-techno.com> <20070723070308.GH32566@spearce.org> <7vabtnmusm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 09:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICsdt-0008So-UO
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 09:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbXGWHrm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754136AbXGWHrm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 03:47:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45426 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbXGWHrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 03:47:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ICsdk-00066E-Tr; Mon, 23 Jul 2007 03:47:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87CDE20FBAE; Mon, 23 Jul 2007 03:47:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabtnmusm.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53405>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Originally I left out --candidates and --debug when I wrote the code
> > for them as I thought they were a tad too internal for casual use.
> > But maybe it makes sense to include them in the usage string.
> 
> I was actually going to suggest removing these options, that
> were primarily meant for debugging and tweaking while we figure
> out what the optimum default should be.  Do you think they are
> worth keeping?

Yea, I do.  I'd like to keep them in the code as sometimes I do
look at their output.  I'll even help maintain them, because they
change oh so often.  ;-)

But if you really want them gone, I won't stop you.

-- 
Shawn.
