From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Q] merging from one (kernel) stable to another?
Date: Mon, 30 Mar 2009 15:52:21 +0200
Message-ID: <49D0CE95.6020407@op5.se>
References: <200903301024.08848.brian.foster@innova-card.com> <200903301358.48864.brian.foster@innova-card.com> <49D0B8BF.2000502@op5.se> <200903301451.33956.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 15:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoHvz-0001q8-Oi
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 15:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbZC3NwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 09:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbZC3NwV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 09:52:21 -0400
Received: from mail.op5.se ([193.201.96.20]:57141 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbZC3NwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 09:52:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8ECF61B8004E;
	Mon, 30 Mar 2009 15:29:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sxZdRBVKrfmZ; Mon, 30 Mar 2009 15:29:35 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9DB8E1B80049;
	Mon, 30 Mar 2009 15:29:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200903301451.33956.brian.foster@innova-card.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115150>

Brian Foster wrote:
> On Monday 30 March 2009 14:19:11 Andreas Ericsson wrote:
>> Brian Foster wrote:
> 
>>>   (4)  Tag the result `like-this';
>>>   (5)  Checkout our.21;  and
>>>   (6)  Merge with `like-this'.
>> Merge is not necessary.
> 
>   <Shrugs/>  I'll going to try in both ways (with and without
>  merging) to better understand just what the results are like.

If you get the tree into the state you want and simply want to
connect the histories, you can do

  git merge -s ours $other_branch

which will record the tree from the current commit as the tree
for the merge-commit (ie, all changes from $other_branch are
thrown away, and the merge always succeeds without conflicts).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
