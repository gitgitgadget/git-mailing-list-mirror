X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 16:44:45 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611031640140.25218@g5.osdl.org>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net>
 <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com>
 <7v3b905fqi.fsf@assigned-by-dhcp.cox.net> <87velwupk6.wl%cworth@cworth.org>
 <20061103231647.GB6970@coredump.intra.peff.net> <eigjql$ql$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 4 Nov 2006 00:45:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eigjql$ql$2@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30901>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg9eZ-0000lc-ST for gcvg-git@gmane.org; Sat, 04 Nov
 2006 01:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932531AbWKDAow (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 19:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWKDAov
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 19:44:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11757 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S932531AbWKDAov (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 19:44:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA40ijoZ012080
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 3
 Nov 2006 16:44:46 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA40ijqU007602; Fri, 3 Nov
 2006 16:44:45 -0800
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org



On Sat, 4 Nov 2006, Jakub Narebski wrote:
>
> YAUO, Yet Another Undocumented Option. ::sigh::

The "--pretty=xxx" is certainly not new, and it's not even totally 
undocumented. It's mentioned in several of the examples in various forms.

All the logging commands take the "pretty" argument.

Try

	git log --pretty={oneline,short,medium,full,fuller,raw}

(and the same things work for "git whatchanged" and "git show" etc)

