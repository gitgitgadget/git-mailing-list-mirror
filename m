From: Andreas Ericsson <ae@op5.se>
Subject: Re: interactive rebase not rebasing
Date: Wed, 01 Oct 2008 23:26:01 +0200
Message-ID: <48E3EAE9.5070207@op5.se>
References: <20080928235013.5c749c6e.stephen@exigencecorp.com>	<48E078BF.5030806@op5.se>	<20081001010306.01cc34eb.stephen@exigencecorp.com>	<48E32BD4.1050107@op5.se>	<20081001095225.d28de16a.stephen@exigencecorp.com>	<48E396AF.2000100@op5.se> <20081001121321.5761fc7e.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 23:27:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl9EC-00049D-JY
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 23:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbYJAV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbYJAV0O
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 17:26:14 -0400
Received: from mail.op5.se ([193.201.96.20]:57671 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbYJAV0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 17:26:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0A5A01B8005F;
	Wed,  1 Oct 2008 23:17:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.77
X-Spam-Level: 
X-Spam-Status: No, score=-2.77 tagged_above=-10 required=6.6
	tests=[AWL=-0.271, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lOvJQVZhZFYq; Wed,  1 Oct 2008 23:17:31 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 1B1FF1B80046;
	Wed,  1 Oct 2008 23:17:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001121321.5761fc7e.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97271>

Stephen Haberman wrote:
>>> I've attempted to do that. Now that I sent in the patch, if you could
>>> review it, I would appreciate your feedback.
>> I'm heading home from work now. I'll look it over tonight or tomorrow
>> morning.
> 
> Cool, thanks.
> 
> Question: how taboo is it to just add another test file?
> 

Not so taboo. Especially not if there are compelling technical reasons
not to add stuff to an existing one.

> I'm attempting to integrate my test into t3404, which is the existing
> interactive rebase test. The two test_expect_success's I added worked
> when I ran them at the start of the test and then reset --hard the
> branches back for the other tests, but if I paste my tests where they
> should probably be, in the middle after the other -p tests, they break
> because the 10 or tests before this have screwed with the DAG already.
> 

Where you add the tests doesn't matter much. Many tests are grouped by
feature simply because they were added along with the feature they're
testing. There's no other value of grouping tests together.

> I can suffer through getting it to work, but a t3409 would be much
> easier, and probably easier to read as well as a I could setup my own
> DAG instead of hacking onto 3404s.
> 

t3409 is already in spearce.git's next branch. You should be able to
add stuff to that, or add t3410 if that doesn't work so good.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
