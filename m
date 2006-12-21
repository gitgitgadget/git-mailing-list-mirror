X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 17:08:45 -0800
Message-ID: <8664c6xdgi.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 01:10:31 +0000 (UTC)
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
Original-Lines: 20
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34997>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCS3-0006Y1-UE for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161111AbWLUBJW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWLUBJL
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:09:11 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:13759 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161109AbWLUBIr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 20:08:47 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 4D7FA8EBA4; Wed, 20 Dec 2006 17:08:46 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 02191-01-82; Wed, 20 Dec 2006 17:08:45 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 98ACA8F5FB;
 Wed, 20 Dec 2006 17:08:45 -0800 (PST)
To: "Terje Sten Bjerkseth" <terje@bjerkseth.org>
Sender: git-owner@vger.kernel.org

>>>>> "Terje" == Terje Sten Bjerkseth <terje@bjerkseth.org> writes:


Terje> +#ifndef __APPLE_CC__
Terje>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD
Terje> needs 600 for S_ISLNK() */
Terje>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
Terje> +#endif
Terje>  #define _GNU_SOURCE
Terje>  #define _BSD_SOURCE
Terje> -

I tried the moral equivalent of that, and it failed to compile many
other things then.  So that's not it.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
