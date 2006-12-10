X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Sun, 10 Dec 2006 01:46:09 +0100
Message-ID: <200612100146.09175.Josef.Weidendorfer@gmx.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <m2d56taoqu.fsf@ziti.local> <7vfybpg9yx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 00:46:25 +0000 (UTC)
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <7vfybpg9yx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33856>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCpf-0005Z9-ES for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754278AbWLJAqQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757216AbWLJAqQ
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:46:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:50400 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1754278AbWLJAqP
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 19:46:15 -0500
Received: (qmail invoked by alias); 10 Dec 2006 00:46:14 -0000
Received: from p5496B595.dip0.t-ipconnect.de (EHLO noname) [84.150.181.149]
 by mail.gmx.net (mp017) with SMTP; 10 Dec 2006 01:46:14 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Saturday 09 December 2006 01:59, Junio C Hamano wrote:
> Maybe the "git add --interactive" would give you a transcript
> like this:
> 
>         $ git add --interactive '*.c' '*.h'
> 	showing list of modified files...
>          1) bozbar.c 2) filfre.c 3) frotz.h 4) nitfol.c 5) rezrov.h
>          6) xyzzy.c  7) yomin.h  8) z.c
>         choice> 2 3 5 6 7
> 	showing list of modified files...
>          1) bozbar.c 2* filfre.c 3* frotz.h 4) nitfol.c 5* rezrov.h
>          6* xyzzy.c  7* yomin.h  8) z.c
>         choice> 4+
> 	showing "git diff -- nitfol.c"...
>         diff --git a/nitfol.c b/nitfol.c
>         @@ -22,x +22,y @@
>          {
>         -	int i;
>         +	long i;
>         +	i = 314;
> 	 
>         stage this hunk [Yes/No/All/Done]? y

Wow.
Something like this really would be good.
And please a way to "unstage" accidently added files/hunks, too ;-)

I even miss such a feature in stgit ("specify hunks to break up one
patch into two").


