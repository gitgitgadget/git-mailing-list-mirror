From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add test cases for git-am
Date: Mon, 02 Jun 2008 19:53:38 +0200
Message-ID: <484433A2.7080600@op5.se>
References: <20080530140447.GB10514@leksak.fem-net> <7vy75rh25i.fsf@gitster.siamese.dyndns.org> <20080531024027.GB5907@leksak.fem-net> <7viqwuffdy.fsf@gitster.siamese.dyndns.org> <20080531220723.GD5907@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:54:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3EF5-0002bi-Di
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 19:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbYFBRxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 13:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbYFBRxy
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:53:54 -0400
Received: from mail.op5.se ([193.201.96.20]:60302 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYFBRxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:53:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 25CF11B80088;
	Mon,  2 Jun 2008 19:49:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: 2.394
X-Spam-Level: **
X-Spam-Status: No, score=2.394 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RCVD_IN_BL_SPAMCOP_NET=1.96,
	RCVD_IN_XBL=3.033]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OuYiSvW1PbA8; Mon,  2 Jun 2008 19:49:19 +0200 (CEST)
Received: from clix.int.op5.se (nsabfw1.nsab.se [217.28.34.132])
	by mail.op5.se (Postfix) with ESMTP id EAA481B80081;
	Mon,  2 Jun 2008 19:49:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080531220723.GD5907@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83548>

Stephan Beyer wrote:
> Hi,
> 
>> "git grep 'tail.*+' -- '*.sh'" says that this will the first and only
>> instance of "tail -n +<number>".  The syntax may be POSIX but not all
>> /usr/bin/tail unfortunately knows about it.
>>
>> I tend to prefer "sed -n -e '3,$p'" for things like this for portability.
> 
> I'm fine with that, but I sometimes wonder if systems that do not like
> "tail -n +3" really tend to like a "sed -n -e '3,$p'" :)
> 

I have yet to come across a sed which doesn't support -n, the range
specifier and the p command, so yes, "sed -n -e '3,$p'" is very
portable indeed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
