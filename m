From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix an unmatched comment end in arm/sha1_arm.S
Date: Sat, 12 May 2007 11:50:54 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705121149120.24220@xanadu.home>
References: <e5bfff550705120335t6728ef82u234bb77d4f9e3d77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 17:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hmts6-0004VF-QH
	for gcvg-git@gmane.org; Sat, 12 May 2007 17:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbXELPu5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 11:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756766AbXELPu5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 11:50:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57375 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423AbXELPu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 11:50:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHX00AR4QOUN6C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 12 May 2007 11:50:54 -0400 (EDT)
In-reply-to: <e5bfff550705120335t6728ef82u234bb77d4f9e3d77@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47060>

On Sat, 12 May 2007, Marco Costalba wrote:

> Signed-off-by: Marco Costalba <mcostalba@gmail.com>

Since @ is already a line comment the spurious */ should already be 
ignored.  But worth cleaning up nevertheless.

Acked-by: Nicolas Pitre <nico@cam.org>


> ---
> arm/sha1_arm.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arm/sha1_arm.S b/arm/sha1_arm.S
> index da92d20..a328b73 100644
> --- a/arm/sha1_arm.S
> +++ b/arm/sha1_arm.S
> @@ -23,7 +23,7 @@ sha_transform:
> 	stmfd	sp!, {r4 - r8, lr}
> 
> 	@ for (i = 0; i < 16; i++)
> -	@         W[i] = ntohl(((uint32_t *)data)[i]); */
> +	@         W[i] = ntohl(((uint32_t *)data)[i]);
> 
> #ifdef __ARMEB__
> 	mov	r4, r0
> -- 
> 1.5.2.rc3
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
