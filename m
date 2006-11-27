X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-PS1 bash prompt setting
Date: Mon, 27 Nov 2006 07:56:50 -0500
Message-ID: <BAYC1-PASMTP023A7249055A08208223F1AEE60@CEZ.ICE>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
	<Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061126094212.fde8cce7.seanlkml@sympatico.ca>
	<20061127065400.GA19174@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 12:57:14 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127075650.81a5a850.seanlkml@sympatico.ca>
In-Reply-To: <20061127065400.GA19174@spearce.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 12:56:52.0622 (UTC) FILETIME=[82846AE0:01C71223]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gog2e-0000wS-CU for gcvg-git@gmane.org; Mon, 27 Nov
 2006 13:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758162AbWK0M4x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 07:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758159AbWK0M4x
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 07:56:53 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:33909 "EHLO
 BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP id S1758162AbWK0M4w
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 07:56:52 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP02.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov
 2006 04:56:52 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gof6P-0006U6-12; Mon, 27 Nov 2006 06:56:49 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 01:54:00 -0500
Shawn Pearce <spearce@spearce.org> wrote:

> I'm using something like this, and will be adding it to
> git-completion.bash tonight:
> 
> 	__git_ps1 ()
> 	{
> 		local b="$(git symbolic-ref HEAD 2>/dev/null)"
> 		if [ -n "$b" ]; then echo "(${b##refs/heads/})"; fi
> 	}
> 	PS1='[\u@\h \W$(__git_ps1)]\$ '
> 
> it works very well...

Yeah, when I first coded it I even looked at making it a bash loadable
to make it perform better but found the prototype to run acceptably,
so never bothered.   If Git does get a --show-ps1 option, people will
still be able to roll their own version to tweak the output format
as you did above.  Hopefully the standard format will work for most
though.

