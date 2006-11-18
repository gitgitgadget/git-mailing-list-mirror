X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 10:20:54 -0800
Message-ID: <455F4F06.3090902@gmail.com>
References: <455F1595.9020009@lsrfire.ath.cx>	<20061118092644.a9f15669.seanlkml@sympatico.ca>	<20061118143511.GM7201@pasky.or.cz>	<455F210B.8000107@lsrfire.ath.cx> <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 18:21:29 +0000 (UTC)
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NvC0MzKyGtlMmy+XScmmeJeEYVosn27oCww1CPWoLN2uJ7YDJ4x7jEmthPR1+mJH6oatCHBrAci/4HD4dIbFy6EuNJu97TCXBm/Ui0m//05bJSe78lDJS18ukBK3WhEwZwzzBPB1nZ+qj/wzUmpBWjiJLLkb0IP9VEYLstaJo6Q=
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
In-Reply-To: <BAYC1-PASMTP06C814AB518D7544770C01AEEF0@CEZ.ICE>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31783>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlUob-00031Z-Qp for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753511AbWKRSVS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbWKRSVS
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:21:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:32095 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1753511AbWKRSVR
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:21:17 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1756386nfa for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 10:21:16 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr3403443hue.1163874075953; Sat, 18
 Nov 2006 10:21:15 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.87.236]) by mx.google.com with ESMTP id
 27sm5176297hua.2006.11.18.10.21.13; Sat, 18 Nov 2006 10:21:15 -0800 (PST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean wrote:
> On Sat, 18 Nov 2006 16:04:43 +0100
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> 
>> git-status is a wrapper around git-runstatus that takes the same
>> options as git-commit.  It could have been named 'git-commit --dry-run'.
> 
> What could be said in the docs as to when the use of one is preferred
> over the other?
> 
>>> All commands deserve a man page.
>> Exactly.  Even plumbers read manuals ;-).  Well, me at least.
> 
> Heh, I suppose you and Petr are right.  It's just that in recent
> discussions the great number of commands provided by Git is seen
> as a UI problem.  Thus having two commands that seem to do the
> exact same thing gives more such pain for no gain.
> 
> It's possible that plumbers should not be seen as "users" but
> rather as coders capable of reading traditional text based
> (non man-page) documentation for their purposes, and man pages
> should only exist (or at least installed) for user level commands.

