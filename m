X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 11:03:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121102390.3535@woody.osdl.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org> <Pine.LNX.4.64.0612121345180.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 19:04:18 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612121345180.18171@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34127>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCvI-0006cm-Es for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751550AbWLLTEM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbWLLTEL
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:04:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59049 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751550AbWLLTEK
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:04:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBCJ40ID011901
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 11:04:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBCJ3xtL012447; Tue, 12 Dec
 2006 11:03:59 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Nicolas Pitre wrote:
> 
> Wouldn't it be a worthy goal to exclude git repos from the rsync 
> mirroring and use git instead?

Well, one of the problems is simply maintenance of kernel.org.

It's just _simpler_ to use rsync for everything.

Look at the current gitweb caching discussion. Did anybody actually step 
up to be a gitweb maintainer on kernel.org?

Same deal. Simplicity and lack of maintenance is sometimes not just a good 
idea, it's a requirement.

