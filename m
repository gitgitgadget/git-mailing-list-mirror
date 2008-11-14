From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 23:56:30 +0100
Message-ID: <491E021E.5020104@op5.se>
References: <491DE6CC.6060201@op5.se> <20081114213352.GA12134@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Fri Nov 14 23:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17c1-0004gL-2v
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 23:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYKNW4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 17:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbYKNW4p
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 17:56:45 -0500
Received: from mail.op5.se ([193.201.96.20]:55383 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbYKNW4p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 17:56:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A864D1B80088;
	Fri, 14 Nov 2008 23:51:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqyG885kV97x; Fri, 14 Nov 2008 23:51:09 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 96FB41B8009E;
	Fri, 14 Nov 2008 23:51:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081114213352.GA12134@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101024>

Martin Koegler wrote:
> On Fri, Nov 14, 2008 at 09:59:56PM +0100, Andreas Ericsson wrote:
>> I've put everyone who "owns" more than 500 lines of code
>> on the bcc list, figuring your permission is important
>> but that you don't want the hundreds (well, one can hope)
>> of emails from people saying "ok". The list of major owners
>> was generated with "git showners *.c" in a worktree from
>> the next branch of git.git.
> 
> I don't think, that your way for relicensing is bullet proof:
> 

I know that it's not, which is why I'm doing research to take care
of the pieces interesting for libgit2 that could possibly have
been derived from elsewhere. Reading and filling structures specific
to git is something I'd be surprised if they originated outside of
git though.

> I consider many of my GIT patches as derived work from other parts of
> GIT, even if git blame is stating me as author. I can gurantee you,
> that I comply with the "Developer's Certificate of Origin 1.1" point
> b, as its based on code out of git.git.

Right, but if we can never re-use code from git.git, libgit will never
fly. It's unfortunately as simple as that. So perhaps we're left with
the option of writing a GPL'd library or just go hang.

> But I can't tell you, from which files I reused code anymore.
> 

To a certain point, "git blame" can.

> Probably other people did the same.
> 
> Your method is ignoring such derived code.
> 

Right. If possible, I'd still like an OK from you though. If nothing
else, it'll make it possible to re-use code that originated from
someone else and that you changed, assuming that "someone else" also
agree to relicensing their code. With 100% of the authors agreeing
to that, we could have a libified git flying in a matter of months
instead of never.

It's unfortunate if the letter of the law pertaining to a particular
license should prevent the copyright owners from doing whatever
they want with the code, but perhaps that's the world we live in.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
