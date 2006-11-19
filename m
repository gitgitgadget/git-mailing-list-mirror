X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 17:59:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611181758290.3692@woody.osdl.org>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net> <20061118184345.GO7201@pasky.or.cz>
 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net> <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org> <7vfycg9pu5.fsf@assigned-by-dhcp.cox.net>
 <7vac2o9pln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 19 Nov 2006 01:59:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac2o9pln.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31822>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glbxw-0005vx-LU for gcvg-git@gmane.org; Sun, 19 Nov
 2006 02:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755510AbWKSB7P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 20:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755525AbWKSB7O
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 20:59:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48579 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1755510AbWKSB7N (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 20:59:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAJ1x9ix031471
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 18
 Nov 2006 17:59:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAJ1x863025309; Sat, 18 Nov
 2006 17:59:09 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sat, 18 Nov 2006, Junio C Hamano wrote:
> 
> There is something seriously wrong about Marco's number with or
> without my patch.  I am getting something like this from
> linux-2.6 with fully packed and pruned refs;

Well, Marco is testing cold-cache numbers. But I agree, even with 
cold-cache, it shouldn't be anywhere close to that bad. 

