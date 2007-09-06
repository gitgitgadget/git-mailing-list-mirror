From: Andreas Ericsson <ae@op5.se>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 06 Sep 2007 11:28:40 +0200
Message-ID: <46DFC848.60201@op5.se>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <loom.20070906T044017-727@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Russ Dill <Russ.Dill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDfk-0004Ef-2a
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbXIFJ2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbXIFJ2n
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:28:43 -0400
Received: from mail.op5.se ([193.201.96.20]:53553 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754781AbXIFJ2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:28:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 961B21943E7;
	Thu,  6 Sep 2007 11:28:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QtRF8wX-cq1x; Thu,  6 Sep 2007 11:28:41 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 3051B1943C3;
	Thu,  6 Sep 2007 11:28:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <loom.20070906T044017-727@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57847>

Russ Dill wrote:
>> Ok, how about doing something like this?
>>
> 
> git add? merge? rebase? No, I have a sneakier place to invoke gc.
> 
> Whenever $EDITOR gets invoked. Heck, whenever git is waiting for any user input,
> do some gc in the background, it'd just have to be incremental so that we could
> pick up where we left off.
> 

I like it. Writing a commit-message takes anywhere from 30 seconds to 5 minutes
for me (sometimes having to check up bug id's, or verifying details in the code).
Sneaking in a repack here would be absolutely stellar :)

It's also nice in that it won't affect people who just follow a project's tip to
get the bleeding edge. For them it shouldn't matter much that they have multiple
small packs obtained while fetching, or if it's all bungled together in a big one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
