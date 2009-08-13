From: Joel Mahoney <joelmahoney@gmail.com>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 23:02:45 -0600
Message-ID: <89456E84-1A85-4D0C-9643-C191EE877E61@gmail.com>
References: <20090810011803.GA435@coredump.intra.peff.net> <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com> <20090811015615.GA8383@coredump.intra.peff.net> <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com> <20090812032740.GA26089@coredump.intra.peff.net> <7v7hx98otz.fsf@alter.siamese.dyndns.org> <20090812075833.GF15152@coredump.intra.peff.net> <7vab24ve97.fsf@alter.siamese.dyndns.org> <20090813023137.GA17358@coredump.intra.peff.net> <7v1vngmitn.fsf@alter.siamese.dyndns.org> <20090813043855.GA21158@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:03:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSSw-0007zw-D9
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZHMFC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZHMFC4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:02:56 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:62710 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZHMFCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:02:55 -0400
Received: by pzk34 with SMTP id 34so373313pzk.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=lIzRRZxeLrpdgNmIpKjB/+jpaLdjqPuMvDWBjsPDqmo=;
        b=VHkmWboCHwmHq/USMJFRHgF6Qp4I77f/wKr4u9mc0VECvGnI3zgUWRdR/9gw922Hl1
         8P62qyLEBIoVHhjzMnOyW9CmX9QJyFU4kp9SMQo1zmF8ORQ2NlojJQ4XHVd59O9Yxdd9
         Aqa58fSNwuqh8J8CmQBzFbuzZUqvz4O7h6hvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=imDBdXsVYTqekqpDFlwwpcr/6mzwbIu5x4of+jIjvH86GsR80LKYdboNbQFpzVugVi
         JOOGCrtKRbQHrDzgmIVfrQS0CEMrUyh7qDwgEUzKgtZ/5CWqWj3TO4Hozg/6ALuqNLrb
         cCVoN3DdsMHZlJJr6G952WhT1U23G8icbUKao=
Received: by 10.114.44.10 with SMTP id r10mr744030war.77.1250139776822;
        Wed, 12 Aug 2009 22:02:56 -0700 (PDT)
Received: from ?192.168.1.104? (c-67-165-212-186.hsd1.co.comcast.net [67.165.212.186])
        by mx.google.com with ESMTPS id k37sm38962197rvb.8.2009.08.12.22.02.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:02:56 -0700 (PDT)
In-Reply-To: <20090813043855.GA21158@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125776>

Hello,

I'm not sure I completely understand where you guys are at with this  
thread : - ) but I thought I would mention that the question arose  
from my inability to install a plugin into a Ruby on Rails project  
based on my having (unknowingly) set branch.master.rebase = true.

I bring this up because a lot of people are getting their first  
exposure to git through Rails/github, and installing plugins in Rails  
is (I think) a good example of brining an existing history (the  
plugin) into a separate repository (your project).  and because this  
maneuver is built into the "./script/plugin install" action, it is not  
something that cannot be easily customized.

again, I may be a little off track here, but I thought I would remind  
you of the original context for what that is worth : - )

thanks again for your help!

Joel


On Aug 12, 2009, at 10:38 PM, Jeff King wrote:

> On Wed, Aug 12, 2009 at 09:36:04PM -0700, Junio C Hamano wrote:
>
>> I honestly do not know of a sane reason (other than "because I can")
>> anybody would want to _start_ a new root in a repository with an  
>> existing
>> history.  And doing a "pull" with or without --rebase immediately  
>> after
>> starting a new root is doubly insane, as you say.
>
> IIRC, the reason I did it was to throw away history, starting a new  
> root
> at the current state. Which is at least a little bit sane, though I
> think I might just do it with a graft and filter-branch these days.
>
>> But that is the kind of "ending up to have" I am talking about; it  
>> is not
>> something you _aim to_ create on purpose.  If you want to _start_ a
>> separate history, and if you are sane, you would start the separate
>> history in a separate repository.
>
> Agreed. Let's not worry about it, then.
>
> -Peff
