X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 08:58:24 +0000
Message-ID: <200612150858.25988.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612142255.33564.andyparkins@gmail.com> <7vk60uyrau.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 08:58:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Cf8x0utzPOlvwh4S7OO3waAb9/dvKSGSjTxIJzQzZWDGSg4o3itMeNEKN9bemlQpQf8leyV8ra4F0Dml8ZQjUYKJMgsvc/Z5Z3IxZRKw1D6kruuYSTW0oXM+qB21lDKP2F4x6FQTkfLmyDqRJJ4YdNtfl32vLuqDNWKGHKbuMgA=
User-Agent: KMail/1.9.5
In-Reply-To: <7vk60uyrau.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34481>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8tq-0002Iy-BQ for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751156AbWLOI6f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWLOI6f
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:58:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:28981 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751156AbWLOI6e (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 03:58:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so759271uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 00:58:33 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr799032ugg.1166173113162; Fri, 15
 Dec 2006 00:58:33 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id j34sm3203708ugc.2006.12.15.00.58.32; Fri, 15 Dec 2006 00:58:32 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 23:46, Junio C Hamano wrote:

> > There truly is something wrong with me.
>
> I did not mean it that way.  I only took it as a sign that maybe

Don't worry; I've got thicker skin than that.  I was simply amazed at my lack 
of comprehension ability. :-)

> > I'm not sure about your "commit -b"; is it wise to have /another/ way of
> > making a branch?  I mean - I'm clearly confused enough, have a heart :-)
>
> I said "commit -b <newbranch>" and deliberately avoided saying
> "commit -b <anybranch>", because I did not want to open another
> can of worms while we are discussing so many good things
> already, and my head can hold only a handful topics at once.

Absolutely.  I'd agree that only <newbranch> is worth even considering.

>  * While working on it, I find an obvious bug that I would not
>    want to fix on the branch (the topic branch I am currently on
>    is not about fixing that bug).

I find myself swayed by this.  This is indeed something that happens to me a 
lot.  In certain circumstances I've been defeated by git because I couldn't 
switch to the other branch to make that quick commit because my local changes 
conflicted with that other branch.  The solution I use is to commit the bug 
fix in the wrong branch, finish my current on-topic commit then 
rebase/reset/etc to put everything where it should be.

> I do agree that it adds one more way to do the same thing and
> would make the documentation noisier, potentially adding more to
> the confusion.  So let's not go there.

Yep.  Although you've persuaded me with the above example, I think this is the 
correct path.  It's not wise to add every bell and whistle just because we 
can.  As long as there is /a/ way to achieve every task, that's good enough, 
we don't need every way to achieve every task.  We might even argue that 
git's flexibility is what makes it harder to learn.  It's similar to UNIX in 
that respect - hard to learn, easy to use.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
