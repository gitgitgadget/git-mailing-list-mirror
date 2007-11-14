From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 08:19:29 +0100
Message-ID: <20071114071929.GA2942@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <7vmythr8xf.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 08:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsCXN-0007oi-Vb
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 08:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbXKNHTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 02:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbXKNHTc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 02:19:32 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43618 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbXKNHTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 02:19:31 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (fruni mo49) (RZmta 14.0)
	with ESMTP id Y02236jAE6MSEL ; Wed, 14 Nov 2007 08:19:29 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 57637277AE;
	Wed, 14 Nov 2007 08:19:29 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 161C656D22; Wed, 14 Nov 2007 08:19:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vmythr8xf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64954>

Junio C Hamano, Wed, Nov 14, 2007 01:02:20 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Ignore exit code of git push in t5404, as it is not relevant for the
> > test
> 
> This proposed log message solicits a "Huh? -- Since when
> ignoring exit code is an improvement?" reaction.  If this push
> is expected to error out, then wouldn't you want to make sure it
> errors out as expected?  If the problem is that the exit status
> is unreliable, maybe we need to make it reliable instead?

Well, it is kind of undefined. git push just updated some remote
references and failed on the others. It has had some failures, so it
returns non-0. And as I said, it really is not about the operation,
but about if the tracking and remote branches are set as we want them.
