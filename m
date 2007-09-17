From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/8] repack -A -d: use --keep-unreachable when repacking
Date: Mon, 17 Sep 2007 12:00:23 +0200
Message-ID: <46EE5037.2080302@op5.se>
References: <11900186941912-git-send-email-gitster@pobox.com> <11900187002882-git-send-email-gitster@pobox.com> <Pine.LNX.4.64.0709171027400.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 17 12:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXDP7-00031s-BN
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 12:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbXIQKA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 06:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbXIQKA2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 06:00:28 -0400
Received: from mail.op5.se ([193.201.96.20]:50224 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753100AbXIQKA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 06:00:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 97F6619444E;
	Mon, 17 Sep 2007 12:00:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLbHckqalx1w; Mon, 17 Sep 2007 12:00:26 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 5CB7C194345;
	Mon, 17 Sep 2007 12:00:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0709171027400.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58424>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 17 Sep 2007, Junio C Hamano wrote:
> 
>> -USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
>> +USAGE='[-a|-A] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
> 
> Would "[-a] [-A]" not be better?  In other usage lines, we have the "|" 
> for alternative forms of the _same_ option, like "[-m|--merge]".
> 

Well, that depends on how you look at it. -m and --merge are (sort of) mutually
exclusive, as the use of one voids the use of the other.

Likewise, using -a and -A together on the same command-line doesn't make much
sense (although -A implies -a rather than meaning the same thing).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
