From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 11:38:38 +0200
Message-ID: <4829619E.4020701@op5.se>
References: <200805081256.11465.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0805081313190.23581@xanadu.home> <200805130842.06112.hs4233@mail.mn-solutions.de> <200805131111.42517.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Holger Schurig <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Tue May 13 11:39:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvqyo-0001ZY-39
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 11:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbYEMJil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYEMJil
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 05:38:41 -0400
Received: from mail.op5.se ([193.201.96.20]:43309 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbYEMJik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 05:38:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E3E4C1B80BFA;
	Tue, 13 May 2008 11:35:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id luKPbvKvZw4V; Tue, 13 May 2008 11:35:12 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 341A11B80BED;
	Tue, 13 May 2008 11:35:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <200805131111.42517.hs4233@mail.mn-solutions.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82011>

Holger Schurig wrote:
>> Okay, then I presume it's a shortcoming that the @{date}
>> syntax uses .git/logs/ref.
> 
> Is there any reason sha1_name.c (which is responsible for the @{} 
> syntax) doesn't include list-objects.h and uses 
> traverse_commit_list() for it's purposes?


It would be alot slower for large projects. Otoh it would also mean
it'd work on a freshly cloned repository, so perhaps it's worth
the trade-off.


>  It wouldn't then need 
> to use .git/logs/ref anymore.
> 
> If that would be ok, then maybe I find time (in my spare time) 
> and prepare a patch in this direction.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
