From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid to duplicate commit message when is not encoded
Date: Sun, 22 Jul 2007 10:52:25 +0200
Message-ID: <20070722085225.GB3408@steel.home>
References: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 11:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICXSH-0003Rv-Un
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 11:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764192AbXGVJKS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 05:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764083AbXGVJKR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 05:10:17 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:20289 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763460AbXGVJKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 05:10:15 -0400
Received: from tigra.home (Faa38.f.strato-dslnet.de [195.4.170.56])
	by post.webmailer.de (fruni mo58) (RZmta 9.1)
	with ESMTP id p04833j6M4Vniv ; Sun, 22 Jul 2007 11:10:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6646D277BD;
	Sun, 22 Jul 2007 10:52:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 49C89BDD0; Sun, 22 Jul 2007 10:52:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculzxto3qrA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53240>

Marco Costalba, Sun, Jul 22, 2007 10:23:05 +0200:
> +		if (encoding) // we'll strip encoding header later

You better avoid using C++ comments, not all C compilers support them.

> +		else
> +			return NULL; // nothing to do

And you better avoid such useless comments too
