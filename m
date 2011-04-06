From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/4] Documentation: Add filter.<driver>.* to config
Date: Wed, 6 Apr 2011 23:39:55 +0530
Message-ID: <20110406180950.GA667@kytes>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-2-git-send-email-artagnon@gmail.com>
 <4D9C4E0F.8050302@drmicha.warpmail.net>
 <20110406124235.GA5881@kytes>
 <7vpqozjpcl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7XC0-0005g3-RK
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab1DFSK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:10:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53796 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754812Ab1DFSKz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:10:55 -0400
Received: by iwn34 with SMTP id 34so1674881iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=70dqt0D3ynurOc1VxzjOEpXjYukrfcJ+/p3dH9KrZew=;
        b=cC3fAAw8M3sF7twqCAF1oRJO57myjIvEinS8Q27Midb/weLVM78UStlUPgZgGjcuXG
         ms7SXGz+1D0ua2CP19GsRGXn35BLfOdlFowsVY4XYsY80sqw0fua2waoexty1xnGtoHQ
         9ZqurEtCtuoME6ObqWvauvqZ/BQ5t8+7XQddw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=syHMlYT+WNzWuNuNZbB5CmeDy3bXsIpc5QVBnUY4KDT80hZrIGHS+pxkSk1r2FoUeJ
         0Uv1wy5cCLdTgpzYTQcK2UxKEQbI6Y14xhALmhkiWXW7uhKb7OlXoNYOk/F0Y3Xj0eQB
         NeBZ9nU8w60nmHe+qPqV69OVYkVqSticv/R10=
Received: by 10.43.54.195 with SMTP id vv3mr2140571icb.17.1302113454016;
        Wed, 06 Apr 2011 11:10:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id vw9sm199545icb.23.2011.04.06.11.10.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:10:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vpqozjpcl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170997>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > I'm very sorry to have caused so much pain.  Yes, I can imagine how
> > terrible it must be to review several iterations of a simple
> > documentation patch.  Thank you for being so patient with me so far- I
> > understand if you don't want to do this anymore.
> >
> > I do spend time proofreading patches before sending them out, but I'm
> > clearly not very good at it.  In future, I'll either try rewriting
> > entire paragraphs or simply refrain from writing documentation patches.
> 
> I do not think that is the lesson you should learn from this exchange.  A
> major part of Michael's complaint (which I think was justified) was that
> he even made a suggestion that is ready to be cut-and-pasted, but your
> reroll does not use the suggested phrasing _without_ explaining why it
> doesn't.
> 
> It is not limited to "documentation patches".  If you get a "how about
> doing it this way---isn't it cleaner?" suggestion to your code patch, you
> at least owe either "yeah, that looks better---thanks, I've used it in
> this reroll" or "no, because...; I've used the original" to the person who
> tried to help you, no?

I completely agree -- all of Michael's suggestions were excellent, and
I'd definitely owe him an explanation for not using something.  In
this particular case, it was an honest mistake though- I meant to
include Michael's version, but I'd rolled out the wrong commit after
rebasing.

-- Ram
