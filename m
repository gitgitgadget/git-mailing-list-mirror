X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-cvsimport: add suport for CVS pserver method HTTP/1.x
 proxying
Date: Fri, 24 Nov 2006 12:20:25 +1300
Message-ID: <45662CB9.8030902@catalyst.net.nz>
References: <11642344172790-git-send-email-iarenuno@eteo.mondragon.edu>	<7v64d5keke.fsf@assigned-by-dhcp.cox.net>	<45661C36.9010101@catalyst.net.nz> <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:20:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
In-Reply-To: <7vlkm1ix7b.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32174>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNrq-00024G-E3 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755348AbWKWXU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757484AbWKWXU1
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:20:27 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:63125 "EHLO
 mail1.catalyst.net.nz") by vger.kernel.org with ESMTP id S1755348AbWKWXU1
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:20:27 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
 by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
 (Exim 4.50) id 1GnNrk-0006DN-4B; Fri, 24 Nov 2006 12:20:24 +1300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:
>
>>This is in scalar context, and that's safe to rely on.
> 
> 
> If it were in scalar context I would agree fully.  That
> behaviour is documented.  But my point is that it is in void
> context, and I did not find document specifying what should
> happen.

Sorry! What I meant to say is: void context is always equivalent to 
scalar context.

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
