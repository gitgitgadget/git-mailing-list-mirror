From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 12:35:24 +0200
Message-ID: <200705131235.25281.jnareb@gmail.com>
References: <20070512064159.GA7471@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	cworth@cworth.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 14 01:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZ0-0002hy-2a
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbXEMXcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758395AbXEMXcf
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:32:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267AbXEMXce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:32:34 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1226383uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 16:32:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I/oCOAmYGhbPe6tGaKP/KPjkz0T5q9cUrtUCYwJTvT8fA+o8Ag0FHCr2f10jWoS4QuphNkhL0ourigR52nOGnbJJLqTG1JSQ+AJ5quAay/NDWyWprzoAxjqIxcdpj3fstZoJb/dTuxc3dkoOp9OwPBa71Qli4hnpnNOg0hAQlUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BIrWdQWEl4GIo30HlBF9zAaNxdsyGk+iBwMqjZ5FXsLpLg7xWEikazpqPCThP0H89SQF37L1fjlVfzBN1AHbNC03WL9mm2PSsTG2FVSRLitkYFiO/nN9+Nf8J92IkW2f+W7C5gjE44MAQ1hMmcz4m2fNknhC/mc1unxHN3nDARY=
Received: by 10.67.29.12 with SMTP id g12mr4757829ugj.1179099152755;
        Sun, 13 May 2007 16:32:32 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e33sm12678053ugd.2007.05.13.16.32.30;
        Sun, 13 May 2007 16:32:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070512064159.GA7471@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47189>

On Sat, 12 May 2007, Jeff King wrote:

> Rather than updating all working tree paths, we limit
> ourselves to paths listed on the command line.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This turned out to be quite easy to implement. Patch is slightly larger
> than necessary due to removing _all_ from the variable names, but I
> think that better expresses the new functionality.
> 
> I'm not sure that the documentation needs updated at all; I had just
> assumed after reading it that 'git-add -u foo' would DWIM.

Do git-add *needs* path specifier (even if it is '.') also for `-u'?
The changes in documentation were to reflect that `-u' is incompatibile
with explicit paths, or that `-u' does not require explicit paths
contrary to git-add without `-u'.

The fact that "add --interactive does not take any parameters" is
separate issue (which, accidentally, was adressed in the same patch).

-- 
Jakub Narebski
Poland
