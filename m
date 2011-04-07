From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Thu, 7 Apr 2011 21:49:07 +0530
Message-ID: <20110407161903.GA8392@kytes>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-2-git-send-email-artagnon@gmail.com>
 <4D9C4E0F.8050302@drmicha.warpmail.net>
 <20110406124235.GA5881@kytes>
 <7vpqozjpcl.fsf@alter.siamese.dyndns.org>
 <20110406180950.GA667@kytes>
 <4D9DA6AB.40100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:20:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7rwJ-00007M-Up
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 18:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab1DGQUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 12:20:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56504 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab1DGQUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 12:20:03 -0400
Received: by iwn34 with SMTP id 34so2615250iwn.19
        for <git@vger.kernel.org>; Thu, 07 Apr 2011 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=o69UeqWGnk4BzbIv0gxqimeue5pEhJBg5u+zt1MAzbA=;
        b=ZslgRd+88MCijIBOKERRqpAqho12kA2cRnUnkyAQaAD7CxbH+9EK9a/2wiUQZFn7JN
         N/dZG3zgxdKuwUGcUemo6s2/gAEtmpHb6C5fhSUSJ6J6i+NbB7MPbAO662r36PYjetco
         0NvI7ambwO8zsx+XZQTrgt0J7/WdPdvWnB2/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iDEeKFOV9DjD9mGb6lES7PlR5i0nT9A1NF+HCSSI+G+bnQNEbppgj3IOtOcpTzFo43
         wHH5N+Svm6J5KA7pkSorkjwZaHZvIa7D6q0XoyQlFo2O8VClv3JnkV7hk1MwFagA4vXy
         evWg5rCxR42tmIz77yKuIiixGpPimzGm0cJRY=
Received: by 10.231.116.92 with SMTP id l28mr1140280ibq.20.1302193202433;
        Thu, 07 Apr 2011 09:20:02 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id o3sm1240132ibd.27.2011.04.07.09.19.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2011 09:20:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9DA6AB.40100@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171065>

Hi Michael,

Michael J Gruber writes:
> Ramkumar Ramachandra venit, vidit, dixit 06.04.2011 20:09:
> > Junio C Hamano writes:
> >> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> >>> I'm very sorry to have caused so much pain.  Yes, I can imagine how
> >>> terrible it must be to review several iterations of a simple
> >>> documentation patch.  Thank you for being so patient with me so far- I
> >>> understand if you don't want to do this anymore.
> >>>
> >>> I do spend time proofreading patches before sending them out, but I'm
> >>> clearly not very good at it.  In future, I'll either try rewriting
> >>> entire paragraphs or simply refrain from writing documentation patches.
> >>
> >> I do not think that is the lesson you should learn from this exchange.  A
> >> major part of Michael's complaint (which I think was justified) was that
> >> he even made a suggestion that is ready to be cut-and-pasted, but your
> >> reroll does not use the suggested phrasing _without_ explaining why it
> >> doesn't.
> >>
> >> It is not limited to "documentation patches".  If you get a "how about
> >> doing it this way---isn't it cleaner?" suggestion to your code patch, you
> >> at least owe either "yeah, that looks better---thanks, I've used it in
> >> this reroll" or "no, because...; I've used the original" to the person who
> >> tried to help you, no?
> > 
> > I completely agree -- all of Michael's suggestions were excellent, and
> > I'd definitely owe him an explanation for not using something.  In
> > this particular case, it was an honest mistake though- I meant to
> > include Michael's version, but I'd rolled out the wrong commit after
> > rebasing.
> 
> Ram, all is well (explained) now, and please don't give up on
> documentation patches. You see, it happened to me again and again that I
> submitted something, and someone took over the initiative or the idea
> and submitted something under his name. And that is completely OK (after
> all I had signed off on my patch, it's part of the O in OSS) but
> "deprives" the original submitter of the "reward" of having the commit
> count incremented. And that is what I wanted to spare you by not
> submitting my own version.

Cool, thanks for understanding and bearing with my slopiness :p

Yes, I strongly believe that we should spend time writing reviews,
even if it's quicker to redo the series entirely* -- that's how we can
get more contributors :)

* This is often the case with inexperienced contributors

-- Ram
