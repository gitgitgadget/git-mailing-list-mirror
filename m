From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git merge and merge message
Date: Mon, 12 Mar 2007 16:07:02 +1300
Message-ID: <46a038f90703112007y2baf7205v56a1ad4b784e93f0@mail.gmail.com>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
	 <20070311160424.GA629@fieldses.org>
	 <200703111815.l2BIFHbq010315@localhost.localdomain>
	 <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Xavier Maillard" <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 04:07:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQasO-0004u7-6o
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 04:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXCLDHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 23:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbXCLDHF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 23:07:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:18861 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964934AbXCLDHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 23:07:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1845634nfa
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 20:07:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C0Iofq91wvynUVM2xsq70e6ljYqlOFoB8NoJ3tD9G/EcAZ8FcQhpr1Lj6fuBeROYcv0wc6NN5adIYqmsfS+kfqwpXPXihR0+EyMUgiDyv/hXuyFaXS9f3BzWBKZOVlgrI+usAXU1KEvy82lDuq/gmCUl0LA5jkuvk1WWzBAL2uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AcqbrZXDT5JeRunfsuaCiCgX/QZW5vVMJb+zaWStkCaopEyOLVgxMCajc5VbI1BcRWOoICXr1tZnWFczM3RpYucZ3U51oscwNqKR+/dzmJRW82d2OIhYfiz70V5PB6GyjtRizcShGRYXWL5RTWbZJaFejMh8Piq9lDZQw7i08bw=
Received: by 10.82.188.15 with SMTP id l15mr7449629buf.1173668822089;
        Sun, 11 Mar 2007 20:07:02 -0700 (PDT)
Received: by 10.82.183.14 with HTTP; Sun, 11 Mar 2007 20:07:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42006>

On 3/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The "don't merge, just fast-forward" is the right thing to do for working
> together. However, I can well imagine that if you actually work with
> branches not as "distributed development", but *just* as "topic branches",
> then having the "useless" merge (with the parents actually being parents
> of each other) migth actually be nice from a documentation standpoint.

Well, actually I do quite a bit of work in private repos, and it is
more useful to know *trivially* that the branches are in the same
place, and get me and my team into the "it's about the content,
stupid" mindset.

So after all the flamefesting, I drank the content-is-king koolaid and
if a pull leads to a fast-forward, I'm happy. If it's a pointless
merge I often rebase to linearise.

> I'm torn on this.

Man, you're getting soft in the middle ;-) First, git gets a newline
conversion option to please windows users that don't use the many GOOD
programming editors that know a unix newline from a UFO (and those are
the majority these days, or so I hear). And now _this_! Tsk, tsk!

> I really dislike anything but fast-forward, because I
> have a strong suspicion that it will cause "alpha male" behaviour (where
> maintainers use the "useless merge" as a way to mark their territory),
> which I think is actually really bad form.

I share your concern. And for Xavier's case ref logs should do the
trick anyway.

cheers,


m
