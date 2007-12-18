From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-stash: RFC: Adopt the default behavior to other commands
Date: Tue, 18 Dec 2007 15:22:26 +0100
Message-ID: <4767D7A2.30703@op5.se>
References: <20071217110322.GH14889@albany.tokkee.org> <506C6191-655D-46AE-A5C2-1335A9044F44@lrde.epita.fr> <7vk5nd53lp.fsf@gitster.siamese.dyndns.org> <57F403E7-AF5B-40F1-AE9D-8EA036675A67@lrde.epita.fr> <7vfxy04ze7.fsf@gitster.siamese.dyndns.org> <20071218105941.GA17251@albany.tokkee.org> <Pine.LNX.4.64.0712181231420.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sebastian Harl <sh@tokkee.org>, Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4dLU-0001Hx-3l
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbXLROWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbXLROWa
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:22:30 -0500
Received: from mail.op5.se ([193.201.96.20]:33719 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753850AbXLROWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:22:30 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7F2E01F08043;
	Tue, 18 Dec 2007 15:22:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2UBIZn19OQim; Tue, 18 Dec 2007 15:22:27 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id BE8E81F0803F;
	Tue, 18 Dec 2007 15:22:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0712181231420.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68751>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 18 Dec 2007, Sebastian Harl wrote:
> 
>> On Mon, Dec 17, 2007 at 04:31:12PM -0800, Junio C Hamano wrote:
>>> But the original point by Sebastian hasn't been answered.  He wanted 
>>> to make the command list the stash without arguments.
>>>
>>> This was discussed already in the early days of stash and there indeed 
>>> was a suggestion to do so (I think I sided with that), but the users 
>>> did not want it.  IIRC, the argument went like: "when I say 'stash', 
>>> that is because I want a quick and immediate way to stash, and I do 
>>> not want a list.  If I do not have to have a quick way, I would create 
>>> a temporary commit on the current branch, or switch to a temporary 
>>> branch and commit there."
>> Well, "git stash save" is just five characters more - I really don't see 
>> why this would be less comfortable (and for the really lazy people there 
>> are still aliases...). On the other hand (if "list" is the default), 
>> we'd get a more consistent interface which imho is imho more important 
>> than typing five characters less.
> 
> It's more about what you're used to.  I had an alias named 'stash' long 
> before it became a git command.  And now guess how _annoying_ it would be 
> to type "git stash<Return><Curse out loud at my mouse>git stash 
> save<Return>".
> 

Not nearly as annoying as losing work because of it, and you obviously
*know* what to do when you're done cursing, while clueless-newbie-X just
hops away and uses subversion.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
