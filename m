From: Andreas Ericsson <ae@op5.se>
Subject: Re: [(not so) random thoughts] using git as its own caching tool
Date: Wed, 12 Dec 2007 17:03:00 +0100
Message-ID: <47600634.3030207@op5.se>
References: <20071212003813.GG29110@artemis.madism.org> <475FFFB7.4010102@op5.se> <20071212154848.GA19294@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:03:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2U3W-0001YF-Kd
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384AbXLLQDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755830AbXLLQDG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:03:06 -0500
Received: from mail.op5.se ([193.201.96.20]:34600 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343AbXLLQDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:03:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A55B01F08016;
	Wed, 12 Dec 2007 17:03:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OQrvd8JM2U7Y; Wed, 12 Dec 2007 17:03:01 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7CB0C1F08008;
	Wed, 12 Dec 2007 17:03:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071212154848.GA19294@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68061>

Mike Hommey wrote:
> On Wed, Dec 12, 2007 at 04:35:19PM +0100, Andreas Ericsson <ae@op5.se> wrote:
>> A bit of both ;-)
>>
>> I like the idea to use the git object store, because that certainly
>> has an API that can't be done away with by user config. The reflog
>> and its expiration mechanism is subject to human control though, and
>> everyone doesn't even have them enabled. I don't for some repos where
>> I know I'll create a thousand-and-one loose objects by rebasing,
>> --amend'ing and otherwise fiddling with history rewrites.
>>
>> Having a tool that works on some repos but not on others because it
>> relies on me living with an auto-gc after pretty much every operation
>> would be very tiresome indeed.
> 
> There is already a tool that relies on reflogs: stash.
> 

No, "git stash save" works anyway. It's when you want to use multiple
stashes that it becomes tricky, but even that works if you're willing
to put some effort into it (although I don't use stash a lot, and not
at all in the very rebase-heavy ones).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
