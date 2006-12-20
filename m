X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 16:58:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191644290.6766@woody.osdl.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
 <20061218140813.GA32446@spearce.org> <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
 <7v64c8thr4.fsf@assigned-by-dhcp.cox.net> <20061219090851.GH2511@spearce.org>
 <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net> <20061219102741.GA21324@spearce.org>
 <Pine.LNX.4.64.0612191524180.6766@woody.osdl.org> <7vvek7o15v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 00:58:40 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vvek7o15v.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34879>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwpn1-0006Kt-C3 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932749AbWLTA6c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWLTA6c
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:58:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50347 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932749AbWLTA6b
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 19:58:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBK0wQ2J012205
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 16:58:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBK0wP2V015664; Tue, 19 Dec
 2006 16:58:25 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Junio C Hamano wrote:
>
> Linus, your userland programming skills are _spoiled_ by Linux
> ;-).

Maybe. On the other hand, there's definitely a bit of just my programming 
style involved: the things I care most about are the kinds of things I'd 
personally use in programming. So I claim that one of the reasons Linux 
does pathname lookup well is simply that every single program I've ever 
done that cared about performance of either open() or stat() or both. And 
yes, I tend to have a tendency to mmap() rather than read. So I optimize 
stuff I do.

That said, Linux does a lot of _other_ things well too, so it's not like 
it's just the things I do.

