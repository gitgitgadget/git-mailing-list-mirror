X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Diffs from CVS keyword expansion
Date: Thu, 30 Nov 2006 23:44:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611302340030.3695@woody.osdl.org>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
 <17775.54363.376000.140259@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 07:44:55 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <17775.54363.376000.140259@lapjr.intranet.kiel.bmiag.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32861>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq34l-00087z-RC for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935072AbWLAHot (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935096AbWLAHot
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:44:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9399 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S935072AbWLAHos (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:44:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB17igjQ010362
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 23:44:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB17ifSC005161; Thu, 30 Nov
 2006 23:44:42 -0800
To: Juergen Ruehle <j.ruehle@bmiag.de>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, Juergen Ruehle wrote:

> Jon Smirl writes:
>  > Anyone have a nice script for suppressing diffs caused by CVS keyword
>  > expansion when someone checked the kernel sources into CVS?
> 
> I usually just say (with GNU diff)
> 
>   diff -I $$ ...
> 
> which is crude, but should be enough to get rid of the hunks listed by
> you.
> 
> You might also want -x CVS if you have the metadata files.

Also, if you are actually _using_ CVS to check it out, use

	cvs co -ko

I think, to not check out with keyword expansion at all.

(Also usable with "cvs diff -ko", I think)

		Linus

PS. Clueless user alert: I have happily not used CVS in years and years, 
