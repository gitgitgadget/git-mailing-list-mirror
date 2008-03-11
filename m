From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Fix incorrect wording in git-merge.txt.
Date: Tue, 11 Mar 2008 08:05:51 +0100
Message-ID: <47D62F4F.8050106@op5.se>
References: <1204564483-5260-1-git-send-email-Matthieu.Moy@imag.fr> <alpine.LFD.1.00.0803031320180.2899@xanadu.home> <vpqlk4zoacw.fsf@bauges.imag.fr> <alpine.LFD.1.00.0803031519360.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyZH-000819-8p
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYCKHFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYCKHFz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:05:55 -0400
Received: from mail.op5.se ([193.201.96.20]:37429 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbYCKHFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:05:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BE78A1F080AD;
	Tue, 11 Mar 2008 08:06:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WDqr18LgC053; Tue, 11 Mar 2008 08:06:45 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id E189F1F08058;
	Tue, 11 Mar 2008 08:06:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <alpine.LFD.1.00.0803031519360.2899@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76802>

Nicolas Pitre wrote:
> On Mon, 3 Mar 2008, Matthieu Moy wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>>
>>> You don't really merge a commit _object_.
>>> You merge with one or more other commits, tipycally identified by a 
>>> branch name or a tag.
>> Strictly speaking, you can merge any commit, not necessarily a branch
>> or a tag. That can be "git merge 66f0a4d" or whatever. Admitedly, the
>> common case is to merge a tag or a branch (which is why I keep it in
>> parentheses).
> 
> Yes, and I've been meaning the same all along.
> 
>> Now, I don't understand the distinction you seem to be making between
>> "commit" and "commit object".
> 
> Objects are what the low level storage is made of.  Conceptually, The 
> merge operation doesn't work at the object level, but rather at the 
> history graph level.  You don't merge objects, you merge history.
> I think it is unnecessary and probably best not to 
> mention the word "object" in this case.
> 
> The alternative is to provide more detailed explanation, such as:
> 
>    A merge is made by joining one or more history line to the current 
>    'HEAD' branch.  Those history lines are denoted by their terminating 
>    commit.  To identify them, the SHA1 name of the corresponding commit 
>    object is used, or more frequently the name of the branch or tag 
>    currently pointing at such commit objects.
> 

"... The SHA1 name or, more frequently, branch- or tag-names currently
pointing to such commits are used to identify them."

commit object = meta-data containing author/committer info, one or more
                parent links and a tree object describing the state of
                the tracked content

commit = A particular point in history.

At least afaiu.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
