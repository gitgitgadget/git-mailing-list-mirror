From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 04/25] Rework make_usage to print the usage message
	immediately
Date: Wed, 17 Oct 2007 21:06:46 +0200
Message-ID: <20071017190646.GA3107@steel.home>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org> <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <20071016175650.GA9992@steel.home> <20071016221555.GB31695@olympe.madism.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEEx-0000Y0-Lf
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXJQTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761484AbXJQTGw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:06:52 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:57481 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932424AbXJQTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:06:50 -0400
Received: from tigra.home (Fcb54.f.strato-dslnet.de [195.4.203.84])
	by post.webmailer.de (klopstock mo3) (RZmta 13.6)
	with ESMTP id g00360j9HF4tNq ; Wed, 17 Oct 2007 21:06:47 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6107C277AE;
	Wed, 17 Oct 2007 21:06:47 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id F093656D22; Wed, 17 Oct 2007 21:06:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071016221555.GB31695@olympe.madism.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBL2Ow==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61409>

Pierre Habouzit, Wed, Oct 17, 2007 00:15:55 +0200:
> > Why stderr, BTW? For instance, the output from "git help" is on
> > stdout. To be fair, I don't know why it is stdout there either.
>   because it's what usage() does already ?

fair enough.
