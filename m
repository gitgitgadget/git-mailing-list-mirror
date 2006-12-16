X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: spurious .sp in manpages
Date: Sat, 16 Dec 2006 02:52:42 -0700
Message-ID: <20061216095242.GC13144@socrates.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 10:54:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 05:54:21 EST
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.11-2006-05-17
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34605>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvXBR-00084z-HN for gcvg-git@gmane.org; Sat, 16 Dec
 2006 11:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030838AbWLPKyW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 05:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030840AbWLPKyW
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 05:54:22 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45372 "EHLO
 pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030838AbWLPKyV (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 05:54:21 -0500
Received: from pd3mr2so.prod.shaw.ca (pd3mr2so-qfe3.prod.shaw.ca
 [10.0.141.178]) by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built
 Mar 15 2004)) with ESMTP id <0JAD004L023TLH50@l-daemon> for
 git@vger.kernel.org; Sat, 16 Dec 2006 02:52:41 -0700 (MST)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150]) by
 pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
 2006)) with ESMTP id <0JAD0017O23SF0U1@pd3mr2so.prod.shaw.ca> for
 git@vger.kernel.org; Sat, 16 Dec 2006 02:52:41 -0700 (MST)
Received: from socrates.priv ([68.148.57.191]) by l-daemon (Sun ONE Messaging
 Server 6.0 HotFix 1.01 (built Mar 15 2004)) with ESMTP id
 <0JAD007P623STUN1@l-daemon> for git@vger.kernel.org; Sat, 16 Dec 2006
 02:52:40 -0700 (MST)
Received: from socrates.priv (localhost [127.0.0.1]) by socrates.priv
 (8.13.4/8.13.4) with ESMTP id kBG9qgmt021071; Sat, 16 Dec 2006 02:52:42 -0700
Received: (from cougar@localhost)	by socrates.priv (8.13.4/8.13.4/Submit) id
 kBG9qg4d021070; Sat, 16 Dec 2006 02:52:42 -0700
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Dec 13, 2006 at 12:58:28AM -0800, Junio C Hamano wrote:
> This is just a random hack to work around problems people seem
> to be seeing in manpage backend of xmlto (it appears we are
> getting ".sp" at the end of line without line break).
> 
> Could people test this out?
> 

This fixes the files available in the man branch of git.git.

  Tom

P.S. I have this fragment in config.mak to install the manpages without
asciidoc. 

man:
	git-archive --format=tar --prefix=${prefix}/man/ man | tar xP
install: man

