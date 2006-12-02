X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 12:46:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021245081.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <200612021232.08699.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612021144520.3476@woody.osdl.org> <20061202202103.GS18810@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 20:46:27 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061202202103.GS18810@admingilde.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33047>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqbkc-0001uc-AQ for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162157AbWLBUqT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162465AbWLBUqT
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:46:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59824 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162157AbWLBUqT (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:46:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2Kk2jQ023159
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 12:46:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2Kk11Z028482; Sat, 2 Dec
 2006 12:46:02 -0800
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Martin Waitz wrote:
> 
> What makes a submodule so special that now we suddenly have to store
> those stuff in the object database?

I'm not sure it is. I suspect a pure commit link with just a CVS-style 
"modules" file is sufficient. I'm just saying that I don't think it is 
_wrong_ to possibly want to expand it.

