From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 04/25] Rework make_usage to print the usage message
	immediately
Date: Tue, 16 Oct 2007 19:56:50 +0200
Message-ID: <20071016175650.GA9992@steel.home>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:57:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhqfB-0003O6-Sf
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760273AbXJPR44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbXJPR44
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:56:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27482 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759607AbXJPR4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:56:55 -0400
Received: from tigra.home (Fca67.f.strato-dslnet.de [195.4.202.103])
	by post.webmailer.de (mrclete mo3) (RZmta 13.6)
	with ESMTP id g036bej9GDuNVv ; Tue, 16 Oct 2007 19:56:51 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A1B5F277AE;
	Tue, 16 Oct 2007 19:56:51 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2584D56D22; Tue, 16 Oct 2007 19:56:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1192523998-19474-4-git-send-email-madcoder@debian.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv2MPo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61233>

Pierre Habouzit, Tue, Oct 16, 2007 10:39:37 +0200:
> From: Alex Riesen <raa.lkml@gmail.com>
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>  parse-options.c |   48 ++++++++++++++++++++++--------------------------
>  1 files changed, 22 insertions(+), 26 deletions(-)

Got it three times: you put git@kernel.org into To: and Cc:

Why stderr, BTW? For instance, the output from "git help" is on
stdout. To be fair, I don't know why it is stdout there either.
