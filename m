From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add some basic tests of rev-list --pretty=format
Date: Wed, 28 Mar 2007 21:21:11 +0200
Message-ID: <20070328192111.GA2588@steel.home>
References: <20070328000828.GA13273@coredump.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWdht-0005ug-GS
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 21:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbXC1TVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 15:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbXC1TVN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 15:21:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:44970 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbXC1TVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 15:21:13 -0400
Received: from tigra.home (Fcb18.f.strato-dslnet.de [195.4.203.24])
	by post.webmailer.de (mrclete mo27) (RZmta 5.4)
	with ESMTP id F0170cj2SGJojp ; Wed, 28 Mar 2007 21:21:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BA545277B6;
	Wed, 28 Mar 2007 21:21:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1330FD24E; Wed, 28 Mar 2007 21:21:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070328000828.GA13273@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg7nw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43380>

Jeff King, Wed, Mar 28, 2007 02:08:28 +0200:
> +test_format parents %P%n%p <<'EOF'
> +commit 131a310eb913d107dd3c09a65d1651175898735d
> +86c75cfd708a0e5868dc876ed5b8bb66c80b4873 
> +86c75cf 
> +commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +86c75cf 
> +86c75cf 
> +EOF

Isn't this a bit wrong for initial commit?
