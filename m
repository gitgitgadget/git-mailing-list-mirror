X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: weird strncmp usage?
Date: Thu, 02 Nov 2006 10:59:14 +0100
Message-ID: <4549C172.3090604@xs4all.nl>
References: <eibhga$tpg$1@sea.gmane.org> <45494D84.2060402@shadowen.org> <20061102065127.GA23105@coredump.intra.peff.net> <Pine.LNX.4.63.0611021008180.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 09:59:21 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0611021008180.1670@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30701>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZLm-0005m4-BL for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752054AbWKBJ7B (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbWKBJ7B
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:59:01 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:50183 "EHLO
 smtp-vbr9.xs4all.nl") by vger.kernel.org with ESMTP id S1752054AbWKBJ7A
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:59:00 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kA29wusg008767; Thu, 2 Nov 2006 10:58:56 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:

> However, in this case, you would need another macro, which automatically 
> extracts the argument, and soon you will end up with yet another getopt 
> package.

It puzzles me that git doesn't use getopt.  Git is rare in not accepting

  --option arg

but only

  --option=arg

Also, -abc doesn't seem to work for combining options.

-- 
