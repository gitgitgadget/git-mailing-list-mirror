From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: add a From: line to
 the email header
Date: Thu, 08 Nov 2007 11:35:03 +0100
Message-ID: <4732E657.7020202@op5.se>
References: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org> <7vode52hag.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:36:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4jS-0004m6-H4
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 11:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759934AbXKHKfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 05:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759872AbXKHKfM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 05:35:12 -0500
Received: from mail.op5.se ([193.201.96.20]:57789 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758524AbXKHKfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 05:35:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0C4461F0870B;
	Thu,  8 Nov 2007 11:34:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XMsTcHUfQmX; Thu,  8 Nov 2007 11:34:39 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 95D981F0870A;
	Thu,  8 Nov 2007 11:34:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vode52hag.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63993>

Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> 
>> $committer is already extracted from the latest existing rev, so add the
>> corresponding From: line to the email header.
> 
> You may fight this out with Andy if you want to, but I think I'd
> side with the existing behaviour.
> 

I'm with Andy here, for the reasons stated below.

> commit e6dc8d60fbd2c84900a26545c5d360b0e202d95b
> Author: Andy Parkins <andyparkins@gmail.com>
> Date:   Fri Sep 28 15:24:26 2007 +0100
> 
>     post-receive-hook: Remove the From field from the generated email header so that the pusher's name is used
>     
>     Using the name of the committer of the revision at the tip of the
>     updated ref is not sensible.  That information is available in the email
>     itself should it be wanted, and by supplying a "From", we were
>     effectively hiding the person who performed the push - which is useful
>     information in itself.
>     

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
