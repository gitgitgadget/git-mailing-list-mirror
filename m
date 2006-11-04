X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 4 Nov 2006 23:29:45 +0100
Organization: Dewire
Message-ID: <200611042329.46556.robin.rosenberg.lists@dewire.com>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org> <20061104191651.GC2517@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 4 Nov 2006 22:28:41 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061104191651.GC2517@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30940>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgU08-0002aQ-75 for gcvg-git@gmane.org; Sat, 04 Nov
 2006 23:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965723AbWKDW22 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965724AbWKDW22
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 17:28:28 -0500
Received: from [83.140.172.130] ([83.140.172.130]:63247 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S965723AbWKDW22 convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 17:28:28
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 9119D8027F2; Sat,  4 Nov 2006 23:25:05 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 01100-01; Sat,  4 Nov
 2006 23:25:05 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 3A9F18027E4; Sat,  4 Nov 2006 23:25:03 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

l=F6rdag 04 november 2006 20:16 skrev Shawn Pearce:
> But trying to abstractly represent an object in Java the same
> way that it is represented in Git costs a huge amount of memory.
> Java is at least 16 bytes of overhead per object, before you get to
> store anything in it. =20

The overhead is eigth bytes per object on a 32-bit platform and 16 on a=
 64-bit=20
platform for Sun's JDK. The granularity is eight bytes in both cases.=20

