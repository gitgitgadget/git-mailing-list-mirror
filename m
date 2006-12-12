X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 19:39:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612111936240.6452@woody.osdl.org>
References: <200612112210.08327.andyparkins@gmail.com>
 <BAYC1-PASMTP114CF00792AB16B95C1597AED70@CEZ.ICE> <7v7iwx2a0z.fsf@assigned-by-dhcp.cox.net>
 <BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 03:40:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP092A9E80667F373BF69AA6AED70@CEZ.ICE>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34057>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtyV6-0002yd-Hz for gcvg-git@gmane.org; Tue, 12 Dec
 2006 04:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751065AbWLLDkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 22:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWLLDkI
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 22:40:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38878 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751066AbWLLDkH
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 22:40:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBC3e0ID025090
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 19:40:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBC3dwW6019706; Mon, 11 Dec
 2006 19:39:59 -0800
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Sean wrote:
> 
> Technically it is workable.. but why even start down the road of having
> anything but branch names after a "branch."?   There has to be a better
> spot for this variable, and it makes it more future proof, as you
> highlighted.

I do agree with Sean, both for the stability reason, but perhaps even more 
because I personally think it would just be better to have a separate 
"[color]" subsection.

In fact, I'd almost prefer to see

	[color]
		diff = auto

over

	[diff]
		color = auto

exactly because once we have different things that take colorization 
arguments, it's just nicer to have them all together (and we already have 
"status", and now we're getting "branch" too.

