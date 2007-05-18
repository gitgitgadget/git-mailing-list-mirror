From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 09/16] entry.c: optionally checkout submodules
Date: Fri, 18 May 2007 23:56:42 +0200
Message-ID: <20070518215642.GC10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <1179516307425-git-send-email-skimo@liacs.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Fri May 18 23:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpARN-0006xz-FC
	for gcvg-git@gmane.org; Fri, 18 May 2007 23:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXERV4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 17:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbXERV4p
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 17:56:45 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:51557 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbXERV4o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 17:56:44 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (mrclete mo12) (RZmta 6.5)
	with ESMTP id 9042a4j4IKGciS ; Fri, 18 May 2007 23:56:42 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B4551277BD;
	Fri, 18 May 2007 23:56:42 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 9312DD195; Fri, 18 May 2007 23:56:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1179516307425-git-send-email-skimo@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47661>

skimo@liacs.nl, Fri, May 18, 2007 21:24:58 +0200:
> +	if (err)
> +		return error("failed to run git-checkout in submodule '%s'", path);

We may need an option to ignore these failures. Maybe even active by
default. Imagine a superproject with _optional_ submodules, where it
is just nice to know that some submodules weren't checked out. BTW,
doesn't git-checkout already prints an error?
