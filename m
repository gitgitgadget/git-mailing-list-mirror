X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: How to conver no branches/tags svn repo to git ?
Date: Thu, 7 Dec 2006 11:59:19 -0800
Message-ID: <20061207195919.GA8179@localdomain>
References: <4b3406f0612070531p13611c68lf65a172c5e4e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:59:28 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4b3406f0612070531p13611c68lf65a172c5e4e7b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33625>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPOv-0002iT-C2 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163248AbWLGT7W (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163250AbWLGT7W
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:59:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:46139 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1163248AbWLGT7V
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 14:59:21 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 383622DC034; Thu,  7 Dec 2006 11:59:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 07 Dec 2006
 11:59:20 -0800
To: Dongsheng Song <dongsheng.song@gmail.com>
Sender: git-owner@vger.kernel.org

Dongsheng Song <dongsheng.song@gmail.com> wrote:
> e.g.
> http://svn.berlios.de/viewcvs/open-iscsi/
> http://svn.berlios.de/svnroot/repos/open-iscsi

git svn init http://svn.berlios.de/svnroot/repos/open-iscsi
git svn fetch

-- 
