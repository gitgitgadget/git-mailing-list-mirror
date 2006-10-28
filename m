X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Generating docu in 1.4.3.3.g01929
Date: Sat, 28 Oct 2006 00:24:54 -0400
Message-ID: <BAYC1-PASMTP04E0376BEE45F9A676DB03AE050@CEZ.ICE>
References: <20061027154433.da9b29d7.seanlkml@sympatico.ca>
	<200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 04:26:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061028002454.b11fdbe6.seanlkml@sympatico.ca>
In-Reply-To: <200610272312.k9RNCo2Q002623@laptop13.inf.utfsm.cl>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Oct 2006 04:24:56.0321 (UTC) FILETIME=[05C85710:01C6FA49]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdfl2-0003YO-9e for gcvg-git@gmane.org; Sat, 28 Oct
 2006 06:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751769AbWJ1EY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 00:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWJ1EY5
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 00:24:57 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:49318 "EHLO
 BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1751769AbWJ1EY4 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006
 00:24:56 -0400
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 27 Oct 2006 21:24:56 -0700
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GdeoY-0007Fk-DC; Fri, 27 Oct 2006 23:24:54 -0400
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org

On Fri, 27 Oct 2006 20:12:50 -0300
"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:

> > > asciidoc -b docbook -d manpage -f asciidoc.conf git-daemon.txt
> > > xmlto -m callouts.xsl man git-daemon.xml
> > > error : unterminated entity reference                
> > > error : unterminated entity reference                
> > > error : unterminated entity reference             ...
> > > error : unterminated entity reference                
> > > error : unterminated entity reference                
> > > Writing git-daemon.1 for refentry
> > 
> > Can't reproduce this here on master or on next with:
> >  asciidoc-7.1.2-0 and xmlto-0.0.18-13.1
> > Maybe this is an Asciidoc 8 issue, are you using it?
> 
> Fedora rawhide i386, with:
> 
>   asciidoc-7.0.2-3.fc6
>   xmlto-0.0.18-13.1
> 
> Perhaps too old, not too new...

Can't imagine that it's too old.  You may have to bisect to figure
out what the culprit is. :o/

