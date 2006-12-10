X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Sun, 10 Dec 2006 15:54:44 +0100
Message-ID: <20061210145444.GB4836@steel.home>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 14:55:21 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-ID: XVycB+ZJoeR4MJuhlNO9LO3ailiuHnG1xqvdJ-x66ehoR5GvcHodci
X-TOI-MSGID: 13b9689c-ef95-4331-8b9a-6ec46d93c9e6
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33893>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtQ5A-00074b-Px for gcvg-git@gmane.org; Sun, 10 Dec
 2006 15:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760836AbWLJOzH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 09:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760783AbWLJOzH
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 09:55:07 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:34238 "EHLO
 mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760836AbWLJOzG (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 09:55:06 -0500
Received: from fwd34.aul.t-online.de  by mailout11.sul.t-online.com with smtp
  id 1GtQ4v-0006Yp-05; Sun, 10 Dec 2006 15:54:57 +0100
Received: from tigra.home
 (XVycB+ZJoeR4MJuhlNO9LO3ailiuHnG1xqvdJ-x66ehoR5GvcHodci@[84.163.110.190]) by
 fwd34.sul.t-online.de with esmtp id 1GtQ4j-1UBmaW0; Sun, 10 Dec 2006 15:54:45
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id D39DC277AF; Sun, 10 Dec 2006 15:54:44 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1GtQ4i-0001m6-2E; Sun, 10 Dec 2006 15:54:44 +0100
To: Marco Costalba <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

Marco Costalba, Sun, Dec 10, 2006 12:38:42 +0100:
> So my request is if it is possible to make git-rev-list write
> _directly_ to a file, without shell redirection, I would ask if it is
> possible:

Well, it is usually possible to redirect stdout directly into a file
(see dup2). "Usually", unless you want windows which as always has
it's own stupid way of doing simple things. Nevertheless, it's
possible to do it without ever touching rev-list.

> I understand this could be not exactly a top priority feature for git
> people, but I would really like to get the best possible interface
> with the plumbing git and the -o options is also a very common one.

Sadly, you're right. Almost every command-line program got the option.
What education could have caused this, I wonder...

> P.S: On another thread I explained why I see problematic linking
> directly against libgit.a

It still is the fastest you can get.
