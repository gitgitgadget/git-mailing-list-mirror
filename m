From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 16:28:23 +0100
Message-ID: <4767E717.2060902@op5.se>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org> <Pine.LNX.4.64.0712181231420.23902@racer.site> <4767D7A2.30703@op5.se> <Pine.LNX.4.64.0712181445420.23902@racer.site> <4767E07A.2020100@op5.se> <Pine.LNX.4.64.0712181513060.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Harl <sh@tokkee.org>, Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4eNM-0002Z2-Hw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972AbXLRP2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757747AbXLRP2a
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:28:30 -0500
Received: from mail.op5.se ([193.201.96.20]:50996 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756862AbXLRP23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:28:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 653081F08046;
	Tue, 18 Dec 2007 16:28:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eqpUJRedoJGr; Tue, 18 Dec 2007 16:28:25 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E25501F08043;
	Tue, 18 Dec 2007 16:28:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0712181513060.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68761>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Dec 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> In the alternative, you could just scrap all those default actions, 
>>> showing synopses instead.  For all commands, including "git commit", 
>>> "git log", "git fetch", etc.
>> Like we do for the git wrapper, you mean? Yes, that would be one 
>> solution, although not a very good one for all commands.
> 
> Exactly.  Not a good one.
> 
>> It's probably not a bad idea for commands where the primary use is 
>> something else than producing visual output though, such as tag or 
>> branch, but those handle creation/deletion of stuff, so the default 
>> action for them is to list stuff of the kind they operate on. I fail to 
>> see why stash should be any different.
> 
> I also fail to see why stash should be any different.  And that's why I 
> expect it to have a default operation, which is -- you guessed it -- 
> "stash the changes!"
> 

Actually, I guessed "list the stashes".

> If I am not sure what I am about to do, there is -- wonder of wonders -- 
> the "-h" option!  And indeed:
> 
> 	$ git stash -h
> 	Usage: /home/gitte/bin/git-stash [  | save | list | show | apply | 
> 		clear | create ]
> 
> So what exactly was your point again?
> 

My point is that it would be nice if all git commands that actually
manipulate objects (create/delete/modify) had a safe default, and
that experienced users such as yourself could endure the insufferable
agony of retraining your fingers to type five more chars so that
people won't have to get bitten by surprises.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
