X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 12:23:21 -0700
Message-ID: <20061111192321.GJ4862@socrates.priv>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com>
 <7virhlken0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 19:24:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7virhlken0.fsf@assigned-by-dhcp.cox.net>
Mail-followup-to: git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31238>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiySl-0003z0-MG for gcvg-git@gmane.org; Sat, 11 Nov
 2006 20:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946270AbWKKTYR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 14:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947299AbWKKTYR
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 14:24:17 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:42872 "EHLO
 pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP id S1946270AbWKKTYQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 14:24:16 -0500
Received: from pd2mr8so.prod.shaw.ca (pd2mr8so-qfe3.prod.shaw.ca
 [10.0.141.11]) by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built
 Mar 15 2004)) with ESMTP id <0J8K002MPZ70W310@l-daemon> for
 git@vger.kernel.org; Sat, 11 Nov 2006 12:23:24 -0700 (MST)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149]) by
 pd2mr8so.prod.shaw.ca (Sun Java System Messaging Server 6.2-2.05 (built Apr
 28 2005)) with ESMTP id <0J8K00JVHZ6ZJXL1@pd2mr8so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 11 Nov 2006 12:23:24 -0700 (MST)
Received: from socrates.priv ([68.148.57.191]) by l-daemon (Sun ONE Messaging
 Server 6.0 HotFix 1.01 (built Mar 15 2004)) with ESMTP id
 <0J8K00KQMZ6ZBK50@l-daemon> for git@vger.kernel.org; Sat, 11 Nov 2006
 12:23:23 -0700 (MST)
Received: from socrates.priv (localhost [127.0.0.1]) by socrates.priv
 (8.13.4/8.13.4) with ESMTP id kABJNLpo030202	for <git@vger.kernel.org>; Sat,
 11 Nov 2006 12:23:21 -0700
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit) id
 kABJNLVM030201	for git@vger.kernel.org; Sat, 11 Nov 2006 12:23:21 -0700
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sat, Nov 11, 2006 at 10:43:47AM -0800, Junio C Hamano wrote:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> 
> > Hi,
> > I want to create "git-amend-commit" to be able to amend commits before
> > HEAD. So I need to check whether the commit I'm going to amend is
> > ascendent of HEAD. Is there any way to check that?
> 
> Ascendant is a word from astorology -- you mean ancestor ;-).

