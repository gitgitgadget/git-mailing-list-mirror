X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] INSTALL: no need to have GNU diff installed
Date: Thu, 14 Dec 2006 12:46:34 -0800
Message-ID: <20061214204634.GF8179@localdomain>
References: <Pine.LNX.4.63.0612141139540.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:46:52 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612141139540.3635@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34397>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxTW-0004vV-GD for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751013AbWLNUqj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWLNUqj
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:46:39 -0500
Received: from hand.yhbt.net ([66.150.188.102]:56816 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751013AbWLNUqi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 15:46:38 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id E96482DC034; Thu, 14 Dec 2006 12:46:34 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 14 Dec 2006
 12:46:34 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Since a long time, we have inbuilt diff generation.

We still require it for running tests.  And git-rerere just
added a dependency on it (my fault :)

-- 
