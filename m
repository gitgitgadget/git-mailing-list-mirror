From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git-tag -s must fail if gpg is broken and cannot sign tags
Date: Thu, 6 Sep 2007 00:26:53 -0400
Message-ID: <20070906042653.GQ18160@spearce.org>
References: <20070906042115.GA343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 06:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT8xL-0000m5-8N
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXIFE07 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbXIFE06
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:26:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39019 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbXIFE06 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:26:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT8xD-0002RC-GZ; Thu, 06 Sep 2007 00:26:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC52520FBAE; Thu,  6 Sep 2007 00:26:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070906042115.GA343@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57813>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> If the user has misconfigured `user.signingkey` in their .git/config
> or just doesn't have any secret keys on their keyring and they ask
> for a signed tag with `git tag -s` we better make sure the resulting
> tag was actually signed by gpg.
...
>  I think this and my prior contrib/workdir patch should both go into
>  maint.  This one in particular; it hurt us today when an automated
>  tool that runs `git tag -s` didn't notice the GnuPG problems.

I'm sorry, despite the subject of this email this is actually a
*one* patch series.  The 2/2 is because I applied and tested this
on top of the contrib/workdir patch I was talking about above and
my email sending script thought it was a two patch series.

-- 
Shawn.
