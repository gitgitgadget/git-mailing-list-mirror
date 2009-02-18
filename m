From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
 bit-masking
Date: Wed, 18 Feb 2009 12:52:04 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902181238320.29723@kiwi.cs.ucla.edu>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302> <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 21:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtQT-0005z6-0y
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 21:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbZBRUwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 15:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbZBRUwT
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 15:52:19 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:39973 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753506AbZBRUwT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 15:52:19 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n1IKq5bm004872;
	Wed, 18 Feb 2009 12:52:05 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n1IKq4LA004868;
	Wed, 18 Feb 2009 12:52:04 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110573>

On Tue, 17 Feb 2009, Johannes Schindelin wrote:

> > >  diff.h |    3 +++
> > >  diff.c |   17 ++++++++++-------
> > >  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> If you had not so conveniently clipped what I quoted just before the three 
> dots, I could point out that it adds roughly double the number of lines as it 
> removes.

Didn't they say on Mount Sinai?

"Thou shalt not judge a patch on the diffstat alone."
