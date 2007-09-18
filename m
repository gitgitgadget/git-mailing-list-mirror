From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 12:28:28 +0200
Message-ID: <46EFA84C.3080906@op5.se>
References: <20070918072627.GB3506@coredump.intra.peff.net> <Pine.LNX.4.64.0709181115250.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXaJo-000523-MW
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbXIRK2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbXIRK2b
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:28:31 -0400
Received: from mail.op5.se ([193.201.96.20]:33867 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbXIRK2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:28:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 67C46194439;
	Tue, 18 Sep 2007 12:28:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.38
X-Spam-Level: 
X-Spam-Status: No, score=-4.38 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.019, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAyGV7J4Su92; Tue, 18 Sep 2007 12:28:29 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id BE98A1943B0;
	Tue, 18 Sep 2007 12:28:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0709181115250.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58573>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Sep 2007, Jeff King wrote:
> 
>> This is based on the git-import.sh script, but is a little
>> more robust and efficient. More importantly, it should
>> serve as a quick template for interfacing fast-import with
>> perl scripts.
> 
> Yes, please!  Maybe somebody will then grab the low-hanging fruit of 
> writing a "git-fast-export", which can be used to dump a complete 
> repository in text format?
> 

I thought that was already taken care of since format-patch handles
--root flag properly?

Otherwise, "git repack -a --window=0 --depth=0" should provide an
easily parseable dump of an entire repo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
