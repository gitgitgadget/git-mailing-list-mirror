X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Fri, 17 Nov 2006 08:45:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611170836120.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1309599992-1163781939=:3349"
NNTP-Posting-Date: Fri, 17 Nov 2006 16:47:21 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061117162605.GA32597@spearce.org>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31707>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6qp-0005Ie-Mm for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933667AbWKQQqA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933721AbWKQQqA
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:46:00 -0500
Received: from [65.172.181.25] ([65.172.181.25]:45793 "EHLO smtp.osdl.org")
 by vger.kernel.org with ESMTP id S933667AbWKQQqA (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:46:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAHGjeix012749
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 17
 Nov 2006 08:45:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAHGjeNL006368; Fri, 17 Nov
 2006 08:45:40 -0800
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1309599992-1163781939=:3349
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 17 Nov 2006, Shawn Pearce wrote:
> 
> Although if you have reflog enabled on your current branch there
> is a 1 character shorter syntax:
> 
> 	gitk HEAD@{1}..

Heh. With a finnish keyboard, that "@" is AltGr+'2', and the '{'/'}' is 
AltGr+'7'/'0', I guarantee that it's not "1 character shorter", it's 
"three pretty complicated characters longer" and "off the normal path 
where you hold your fingers on the keyboard ;)

And that's not even mentioning that '{'/'}' is a magic sequence for 
filename expansion to the shell, so every time I see that, I have to think 
about it (and it turns out that because there is no comma in between 
there, it's ok. Otherwise you would need to quote it or escape them...)

So the reflog syntax is fine, but it's definitely not a "simple" syntax. 
I'd only use it for things where I want something that ORIG_HEAD won't 
give me ("ORIG_HEAD" you can type by just holding the shift key down all 
the time, and letting your fingers dance over the keyboard, both on a US 
and a Finnish keyboard).

And yes, I actually use a Finnish keyboard, still. Don't ask me why. I 
don't actually need the едц characters often enough for it to matter, and 
I have used US keyboards elsewhere enough that I can switch between the 
two without thinking, but I still ended up having my sister ship me a 
keyboard from Finland when I wanted to upgrade..

			Linus
