From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 13:28:27 +0200
Message-ID: <46EFB65B.6030202@op5.se>
References: <20070918072627.GB3506@coredump.intra.peff.net> <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se> <20070918103051.GA22239@coredump.intra.peff.net> <Pine.LNX.4.64.0709181217200.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXbFt-0005wh-VS
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbXIRL2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754442AbXIRL2c
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:28:32 -0400
Received: from mail.op5.se ([193.201.96.20]:36002 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754269AbXIRL2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:28:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 475A819445E;
	Tue, 18 Sep 2007 13:28:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.382
X-Spam-Level: 
X-Spam-Status: No, score=-4.382 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.017, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtbHIyHS7C8h; Tue, 18 Sep 2007 13:28:29 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 140291943F5;
	Tue, 18 Sep 2007 13:28:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0709181217200.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58582>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Sep 2007, Jeff King wrote:
> 
>> I think he means a dump that you can meaningfully edit with sed or a 
>> text editor. And even nicer, one that could be fed back into 
>> git-fast-import. So you could do something like:
>>
>> git-fast-export A..B >dump
>> vi dump
>> git-fast-import <dump
>>
>> to rewrite history in a very flexible way.
> 
> Exactly what I meant.  Some people seem to have problems with 
> filter-branch, but somehow no proper bug report, let alone fix, evolved 
> from that.
> 

The main problem is that it in my use-cases fixes a nuisance, but not a
real problem, while the man-page SYNOPSIS consists of a full 5 lines, most
of which are far from obvious at a first glance. The seeming effort involved
just doesn't seem worth bothering with.

> I guess these people are more comfortable with what you just described.
> 

I know I would be, especially since all changes would show up in an entirely
different repo. I know filter-branch is probably completely safe, but even a
0.1% risk of losing *anything* isn't worth taking to fix a small nuisance.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
