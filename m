From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 07/11] git-fetch: Limit automated tag following to only
 fetched objects
Date: Sat, 10 Nov 2007 15:10:11 +0100
Message-ID: <4735BBC3.5040207@op5.se>
References: <20071109110631.GG19368@spearce.org> <20071109121228.GA4241@prefect.vdbonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: CJ van den Berg <cj@vdbonline.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqr2o-0003UV-NX
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbXKJOKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 09:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbXKJOKS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 09:10:18 -0500
Received: from mail.op5.se ([193.201.96.20]:35544 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbXKJOKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 09:10:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A072C1F0873D;
	Sat, 10 Nov 2007 15:10:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vaFdl1k22oPD; Sat, 10 Nov 2007 15:10:13 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 43AD21F0873B;
	Sat, 10 Nov 2007 15:10:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071109121228.GA4241@prefect.vdbonline.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64352>

CJ van den Berg wrote:
> On Fri, Nov 09, 2007 at 06:06:31AM -0500, Shawn O. Pearce wrote:
>> We now redefine the rule to be: "tags are fetched if they refer
>> to an object that was just transferred; that is an object that is
>> new to your repository".  This rule is quite simple to understand,
>> you only get a tag if you just got the object it refers to.
> 
> With this new rule a retrospectively pushed tag will never be fetched,
> right? With our local work flow tags are only ever pushed retrospectively
> because the tagged commit has to first pass regression tests. So this would
> be a major regression for us.
> 

Same for us. Deciding after something has been pushed that "ok, this version
works, let's make that one the release" is, I think, fairly common behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
