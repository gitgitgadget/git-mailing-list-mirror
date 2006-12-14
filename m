X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 12:42:57 -0500
Message-ID: <20061214174251.GA16819@tuxdriver.com>
References: <200612141519.44294.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 18:11:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1692 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 13:11:22 EST
Content-Disposition: inline
In-Reply-To: <200612141519.44294.andyparkins@gmail.com>
User-Agent: Mutt/1.4.1i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34379>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guv3U-0007M0-1U for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751904AbWLNSLY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbWLNSLX
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:11:23 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:3609 "EHLO ra.tuxdriver.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751904AbWLNSLW
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 13:11:22 -0500
Received: from bilbo.hq.tuxdriver.com (azure.tuxdriver.com [70.61.120.53]) by
 ra.tuxdriver.com (8.13.7/8.13.7) with ESMTP id kBEHgwth011087
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 14
 Dec 2006 12:43:03 -0500
Received: from bilbo.hq.tuxdriver.com (localhost.localdomain [127.0.0.1]) by
 bilbo.hq.tuxdriver.com (8.13.1/8.13.1) with ESMTP id kBEHgv3n020032; Thu, 14
 Dec 2006 12:42:57 -0500
Received: (from linville@localhost) by bilbo.hq.tuxdriver.com
 (8.13.1/8.13.1/Submit) id kBEHgv5F020031; Thu, 14 Dec 2006 12:42:57 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Dec 14, 2006 at 03:19:44PM +0000, Andy Parkins wrote:
> This patch makes all merge log messages of the form:
> 
>   Merge branch XXXX into YYYY
> 
> Regardless of whether YYYY is master or not.
> 
> "master" shouldn't get special treatment; making different log messages
> based on the name of the branch is bad form.  What if a user likes
> "my/master" or "my/head" as their master branch?

Why not drop the "into YYYY" part for everyone else?  I don't find
it useful at all, and is just confusing if I merge to a temporary
branch and then pull that into master later.

John
-- 
John W. Linville
