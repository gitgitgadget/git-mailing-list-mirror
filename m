From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 19:32:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221930330.30120@woody.linux-foundation.org>
References: <20071022063222.GS14735@spearce.org>
 <20071022071644.GA7290@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 04:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik9ZE-0001uf-IZ
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 04:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbXJWCcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 22:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbXJWCcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 22:32:16 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43598 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751512AbXJWCcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 22:32:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9N2W2f7029685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 19:32:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9N2W2rS027733;
	Mon, 22 Oct 2007 19:32:02 -0700
In-Reply-To: <20071022071644.GA7290@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62073>


Sorry, I missed this while being busy hacking and not reading email ;)

On Mon, 22 Oct 2007, Jeff King wrote:
> 
> Patch is below (please just squash with the one from Linus).

Your patch is better than what used to be there, but

> -			/* Already picked as a destination? */
> +			/* Already picked as a source? */
>  			if (!p->src_dst)
>  				continue;

the above is wrong, the whole thing should be dropped (we *want* to be 
able to re-use sources).

Anyway, the set of fixes I sent out earlier included fixing that stupid 
loop as one of the things.

		Linus
