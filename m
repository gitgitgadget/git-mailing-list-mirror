From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] diffcore: Allow users to decide what funcname to use
Date: Tue, 13 Nov 2007 11:07:31 +0100
Message-ID: <47397763.6080307@op5.se>
References: <4738208D.1080003@op5.se>	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>	<7vhcjr2lte.fsf@gitster.siamese.dyndns.org> <4738E9E6.2040001@op5.se> <buomytin9dz.fsf@dhapc248.dev.necel.com> <473954F8.8070908@op5.se> <47396B4C.6070406@op5.se> <fhbsor$ebf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:07:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsgR-0000Zp-Gp
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbXKMKHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbXKMKHg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:07:36 -0500
Received: from mail.op5.se ([193.201.96.20]:49987 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbXKMKHf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:07:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0DB6C1F08704;
	Tue, 13 Nov 2007 11:07:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.208
X-Spam-Level: 
X-Spam-Status: No, score=-2.208 tagged_above=-10 required=6.6
	tests=[AWL=0.291, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NYRZLzbgQISD; Tue, 13 Nov 2007 11:07:33 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C6ED81F08703;
	Tue, 13 Nov 2007 11:07:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <fhbsor$ebf$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64781>

Jakub Narebski wrote:
> Andreas Ericsson wrote:
> 
>> Git can be smarter than that, and imo it should. This
>> patch lets the diffcore grok a new configuration variable,
>> "diff.funcnames", which can be set to "new", "old", or a
>> boolean value, which will cause it to be "old" (for 'true')
>> and 'none' (for 'false').
> 
> Wouldn't it be better to use existing 'diff driver' infrastructure
> for this? See "Defining a custom hunk-header" section in
> gitattributes(5).
> 
> On the other hand... no.
> 

It's impossible to do that, since that driver will only ever be
fed the "old" file with the old code. I'm guessing you noticed
that yourself, so just explaining in case anyone else wonders.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
