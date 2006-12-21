X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 16:44:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612201643520.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>  <86vek6z0k2.fsf@blue.stonehenge.com>
  <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>  <86irg6yzt1.fsf_-_@blue.stonehenge.com>
  <7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>  <86ejquyz4v.fsf@blue.stonehenge.com>
  <86ac1iyyla.fsf@blue.stonehenge.com>  <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
  <86wt4mximh.fsf@blue.stonehenge.com>  <Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
 <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 21 Dec 2006 00:45:35 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34991>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxC3o-0002wj-6P for gcvg-git@gmane.org; Thu, 21 Dec
 2006 01:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161091AbWLUAop (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 19:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWLUAoo
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 19:44:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53863 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161091AbWLUAon
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 19:44:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBL0ia2J017630
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 20
 Dec 2006 16:44:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBL0iZVQ011441; Wed, 20 Dec
 2006 16:44:36 -0800
To: Terje Sten Bjerkseth <terje@bjerkseth.org>
Sender: git-owner@vger.kernel.org



On Thu, 21 Dec 2006, Terje Sten Bjerkseth wrote:
> 
> For Mac OS X 10.4, _XOPEN_SOURCE seems to define _POSIX_C_SOURCE which
> causes the NI_MAXSERV problem in netdb.h. The appended seems to make
> it work.

Ok, that's probably the best we can do. Along with perhaps cursing at 
apple a bit.

Your patch is whitespace-damaged, btw.

