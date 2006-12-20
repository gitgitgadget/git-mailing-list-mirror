X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 17:10:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191709320.6766@woody.osdl.org>
References: <693577.67723.qm@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 01:10:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <693577.67723.qm@web31813.mail.mud.yahoo.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34882>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpyG-0008FA-Do for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932818AbWLTBKJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWLTBKI
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:10:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50847 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932818AbWLTBKG
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 20:10:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBK1A52J012648
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 17:10:06 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBK1A4lZ015881; Tue, 19 Dec
 2006 17:10:05 -0800
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Luben Tuikov wrote:
>
> /home/luben/bin/git-merge: line 394: 12030 Segmentation fault      git-merge-$strategy $common -- "$head_arg" "$@"
> Merge with strategy recursive failed.

Can you run that by hand under gdb and get a backtrace?

