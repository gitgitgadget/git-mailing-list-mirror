X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Fri, 27 Oct 2006 15:44:33 -0400
Message-ID: <BAYC1-PASMTP0795BBAE2A844A93124A67AE040@CEZ.ICE>
References: <200610271726.k9RHQr0F024712@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 19:53:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
In-Reply-To: <200610271726.k9RHQr0F024712@laptop13.inf.utfsm.cl>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Oct 2006 19:50:32.0093 (UTC) FILETIME=[2944E4D0:01C6FA01]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdXdM-0008Rv-CL for gcvg-git@gmane.org; Fri, 27 Oct
 2006 21:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750966AbWJ0Toh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbWJ0Toh
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 15:44:37 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:39906 "EHLO
 BAYC1-PASMTP07.CEZ.ICE") by vger.kernel.org with ESMTP id S1750987AbWJ0Tog
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 15:44:36 -0400
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP07.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 27 Oct
 2006 12:50:31 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdWh0-0006Zl-3H; Fri, 27 Oct 2006 14:44:34 -0400
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006 14:26:53 -0300
"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:

> I'm getting lots of these after today's pull:
> 
> asciidoc -b docbook -d manpage -f asciidoc.conf git-daemon.txt
> xmlto -m callouts.xsl man git-daemon.xml
> error : unterminated entity reference                
> error : unterminated entity reference                
> error : unterminated entity reference             ...
> error : unterminated entity reference                
> error : unterminated entity reference                
> Writing git-daemon.1 for refentry

Can't reproduce this here on master or on next with:
 asciidoc-7.1.2-0 and xmlto-0.0.18-13.1
Maybe this is an Asciidoc 8 issue, are you using it?

