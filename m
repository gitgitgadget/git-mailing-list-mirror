X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: Advice on converting to git from versioning-by-directory
Date: Thu, 23 Nov 2006 05:07:57 -0500
Message-ID: <20061123100757.GB32620@coredump.intra.peff.net>
References: <200611230916.46415.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 10:08:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611230916.46415.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32132>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBUy-0003fI-LF for gcvg-git@gmane.org; Thu, 23 Nov
 2006 11:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757301AbWKWKIA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 05:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757322AbWKWKIA
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 05:08:00 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:21457
 "HELO peff.net") by vger.kernel.org with SMTP id S1757301AbWKWKH7 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 05:07:59 -0500
Received: (qmail 29796 invoked from network); 23 Nov 2006 05:08:04 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 23 Nov 2006 05:08:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov
 2006 05:07:57 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 09:16:44AM +0000, Andy Parkins wrote:

> What should I do?  I've thought of a number of things:
>  * Recreate the whole lot by hand, the repository isn't huge and I could 
> manually apply each commit as a patch in the correct place.  It would be a 
> bit time-consuming but would mean I'd have what I wanted

If I understand you correctly, you want to take four branches, each with
data in version1/, version2/, etc, and make it look like they all had
data in the project root throughout history. Is that right?

If so, cogito's cg-admin-rewritehist can probably do what you want (I
also posted a script a while back to do this exact thing, and I can dig
it up if you want).

