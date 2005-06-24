From: Alecs King <alecsk@gmail.com>
Subject: Re: Finding what change broke ARM
Date: Fri, 24 Jun 2005 19:32:13 +0800
Message-ID: <20050624113213.GA2328@loalhost.H.qngy.gscas>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 13:26:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlmJ9-0007lq-3E
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 13:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbVFXLbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 07:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbVFXLbf
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 07:31:35 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:60702 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263251AbVFXLb0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 07:31:26 -0400
Received: by wproxy.gmail.com with SMTP id 68so310631wra
        for <git@vger.kernel.org>; Fri, 24 Jun 2005 04:31:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YH3LTTPV7WK9Oijf7Rq2cHmnBbvHI4LOh7VgKvEuEBv0mO8qhMG1+pv0YCogFKRUFaGrLuG1xe3ii+qFJRrXQArp1SiXz5kwrrY8KL9+HsxBexooODtBMWSjDiXC534fGUaS7pVW4mnwam59zHb55KuEVM6H0Yrefw5k50XbHGk=
Received: by 10.54.53.39 with SMTP id b39mr1733494wra;
        Fri, 24 Jun 2005 04:31:25 -0700 (PDT)
Received: from localhost ([210.77.2.149])
        by mx.gmail.com with ESMTP id 15sm5362560wrl.2005.06.24.04.31.22;
        Fri, 24 Jun 2005 04:31:25 -0700 (PDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050624101951.B23185@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 10:19:51AM +0100, Russell King wrote:
> When building current git for ARM, I see:
> 
>   CC      arch/arm/mm/consistent.o
> arch/arm/mm/consistent.c: In function `dma_free_coherent':
> arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
> arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
> arch/arm/mm/consistent.c:357: error: for each function it appears in.)
> make[2]: *** [arch/arm/mm/consistent.o] Error 1
> 
> How can I find what change elsewhere in the kernel tree caused this
> breakage?
> 
> With bk, you could ask for a per-file revision history of the likely
> candidates, and then find the changeset to view the other related
> changes.
> 
> With git... ?  We don't have per-file revision history so...

Wouldnt a 'git-whatchanged -p <candidates>' help?


-- 
Alecs King
