X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 11:13:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121111510.3535@woody.osdl.org>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121021270.3535@woody.osdl.org> <Pine.LNX.4.64.0612121400530.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 19:13:46 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612121400530.18171@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34130>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuD4P-00087b-IW for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932364AbWLLTNi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWLLTNi
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:13:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59687 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932364AbWLLTNh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:13:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBCJDVID012526
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 11:13:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBCJDT62012754; Tue, 12 Dec
 2006 11:13:30 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Nicolas Pitre wrote:
> 
> Maybe object sharing between repos could be a good idea too?

We often do. Many people have used "git clone -s -l", and as long as you 
repack with the "-l" flag too, the object sharing actually increases over 
time as the base repo gets repacked and the cloned repo keeps using the 
growing base pack..

