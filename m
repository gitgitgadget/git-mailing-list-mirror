From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: GIT compile error on Sun Sparc SB2000
Date: Wed, 11 May 2005 12:58:56 +0100
Message-ID: <1115812736.16187.494.camel@hades.cambridge.redhat.com>
References: <200505111141.27725.snake@penza-gsm.ru>
	 <1115809273.16187.493.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 13:52:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVpl3-0002Ry-Rd
	for gcvg-git@gmane.org; Wed, 11 May 2005 13:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVEKL7M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 07:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVEKL7M
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 07:59:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261215AbVEKL7C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 07:59:02 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DVprd-00075A-MT; Wed, 11 May 2005 12:58:58 +0100
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <1115809273.16187.493.camel@hades.cambridge.redhat.com>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 12:01 +0100, David Woodhouse wrote:
> Libraries which are in /usr/lib as opposed to /usr/lib64 are presumably
> 64-bit.

Der.... I mean 32-bit, obviously; otherwise the rest wouldn't make
sense:

>  Since the linker is claiming that they're incompatible, I assume
> your compiler is defaulting to 64-bit output. Try adding '-m32' to
> CFLAGS, or installing 64-bit libz.

-- 
dwmw2

