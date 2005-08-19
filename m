From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC] Importing from a patch-oriented SCM
Date: Fri, 19 Aug 2005 20:52:45 +1200
Message-ID: <46a038f905081901521296c24@mail.gmail.com>
References: <46a038f9050819000417ed436e@mail.gmail.com>
	 <7vslx61i3s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 11:01:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E62cO-00046B-VI
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 10:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVHSIws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 04:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVHSIws
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 04:52:48 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:23793 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbVHSIws convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 04:52:48 -0400
Received: by rproxy.gmail.com with SMTP id i8so465324rne
        for <git@vger.kernel.org>; Fri, 19 Aug 2005 01:52:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GFHwaAmnrTYr/QgrvxI2JffTJcGfK52muXcA9lTD2a7XGJMZCT6eEiEIIrxoL3iNF6LDCbS3qKqNTsvBe4ywbh3BZT3eSx2R6YuFvHtCzo0ThU8tU3pEppkJkRbJRN1NsF9ur107AhehYZAg8jm4aabxw+e++EumuLALKL0FodM=
Received: by 10.38.104.44 with SMTP id b44mr48424rnc;
        Fri, 19 Aug 2005 01:52:45 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 19 Aug 2005 01:52:45 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslx61i3s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/19/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
> 
> > If I remember correctly, Junio added some stuff in the merge & rebase
> > code that will identify if a particular patch has been seen and
> > applied, and skip it even if it's a bit out of order. But I don't know
> 
> I think you are talking about git-patch-id.

Is this used at commit time, and stored somewhere (doesn't seem to be)
or do you select older patches from the destination branch at merge
time?

If you only compare patches since the last merge, patches that were
merged but somehow unreported will fall into a black hole and cause a
conflict going forward anyway. Hmm.  That seems to be a problem I
won't be able to avoid if merges happen out-of-order.

I'll try and work out how it's being used during the merge
(pointers/hints welcome) and see if I can do something smart w it.
Thanks!

cheers,


martin
