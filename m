From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 26 Nov 2007 10:09:01 +0100
Message-ID: <474A8D2D.6010800@op5.se>
References: <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org> <20071123103003.GB6754@sigill.intra.peff.net> <Pine.LNX.4.64.0711231319220.27959@racer.site> <20071124113814.GA17861@sigill.intra.peff.net> <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> <7vtznbqx2w.fsf@gitster.siamese.dyndns.org> <20071125215128.GC23820@fieldses.org> <alpine.LFD.0.99999.0711252029020.9605@xanadu.home> <20071126041521.GA21120@fieldses.org> <alpine.LFD.0.99999.0711252324360.9605@xanadu.home> <fie23u$5tc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 10:09:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwZy9-0004Vp-8s
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 10:09:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbXKZJJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 04:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbXKZJJN
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 04:09:13 -0500
Received: from mail.op5.se ([193.201.96.20]:45250 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622AbXKZJJM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 04:09:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D38C01F08104;
	Mon, 26 Nov 2007 10:09:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VEJ75D-CVeWy; Mon, 26 Nov 2007 10:09:04 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 69DB11F080F5;
	Mon, 26 Nov 2007 10:09:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <fie23u$5tc$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66060>

Jakub Narebski wrote:
> Nicolas Pitre wrote:
> 
>> On Mon, 26 Nov 2007, J. Bruce Fields wrote:
>>
>>> I do find that trying to work on top of a constantly rebased branch is
>>> annoying no matter how I do it.  So I sometimes wonder if we shouldn't
>>> instead be finding ways to avoid the practice.
>> I don't think it can't be avoided in many cases.  Some stuff gets 
>> rebased because it has to be refined before it is merged in a more 
>> stable and more "official" repository.  Working on top of a rebased 
>> branch could be much easier if there was a dedicated command to perform 
>> the local rebase of one's work after a fetch, just like the pull command 
>> does a merge after a fetch, at which point both work flows would be 
>> almost equivalent wrt ease of use.
> 
> There was idea of 'rebase' merge strategy (which was in some form
> implemented once under another name: check archives if you want).
> And there is an idea of --rebase switch git git-pull.
> 
> What is left is the implementation ;-)
> 

"git pull --rebase" already has an implementation. Dscho cooked one up
which I've been using since then. It works nicely.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
