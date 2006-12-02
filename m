X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 12:44:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de>
 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061202201826.GR18810@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 20:44:45 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061202201826.GR18810@admingilde.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33046>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqbiy-0001WR-IH for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031785AbWLBUoh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031786AbWLBUoh
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:44:37 -0500
Received: from smtp.osdl.org ([65.172.181.25]:39344 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031785AbWLBUoh (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:44:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2KiLjQ023043
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 12:44:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2KiKVO028416; Sat, 2 Dec
 2006 12:44:21 -0800
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Martin Waitz wrote:
> 
> I don't buy your scalability argument.

Try it.

Really. Get the mozilla import (450MB project), and clone it on a machine 
with half a gig of RAM or less.

Then, clone a couple of smaller archives that end up being 450MB 
_combined_, but clone them separately.

And watch the memory usage.

> By separating the repositories you just make reachability analyis be
> totally awkward, without winning anything.

Trust me. Try it out.

