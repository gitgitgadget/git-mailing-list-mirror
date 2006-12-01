X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 23:41:19 +0100
Message-ID: <4570AF8F.1000801@stephan-feder.de>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 22:41:34 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32979>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqH4P-00065r-K6 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935586AbWLAWlX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936545AbWLAWlX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:41:23 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:53722 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S935586AbWLAWlW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:41:22 -0500
Received: (qmail 4525 invoked by uid 1011); 1 Dec 2006 22:41:21 -0000
Received: from sf-gmane@stephan-feder.de by mail1 by uid 1003 with
 qmail-scanner-1.22  (ExcuBAtor: 1.0.2. 
 Clear:RC:1(213.157.24.137):SA:0(0.0/5.0):.  Processed in 0.157834 secs); 01
 Dec 2006 22:41:21 -0000
Received: from unknown (HELO mx.stephan-feder.de) (213.157.24.137) by
 mail.medianet-world.de with SMTP; 1 Dec 2006 22:41:21 -0000
Received: from [192.168.3.69] (unknown [192.168.0.2]) by mx.stephan-feder.de
 (Postfix) with ESMTP id 616D3964B4; Fri,  1 Dec 2006 23:41:20 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
...
> In contrast, a submodule that we don't fetch is an all-or-nothing 
> situation: we simply don't have the data at all, and it's really a matter 
> of simply not recursing into that submodule at all - much more like not 
> checking out a particular part of the tree.

If you do not want to fetch all of the supermodule then do not fetch the
supermodule. Instead fetch only the submodules you are interested in.
You do not have to fetch the whole repository.

Regards

