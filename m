Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B11261F403
	for <e@80x24.org>; Sun,  3 Jun 2018 20:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeFCUHp (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 16:07:45 -0400
Received: from imap.thunk.org ([74.207.234.97]:58914 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeFCUHp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 16:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QRElOr3k4eNy7l0Ze20UKhAudFmhaD0OCTNDRghPi+E=; b=EHIeT8UqRW39XDsb5gMpk1nmOT
        hEtuKv/SJ1cNQuU6rVyIqYo4VyV8yg/CHmsDPOOR2O8pZAnA+rDO79WgE+G0jAl/jfUPLlMl3bDkE
        ZNssmyYJ1OBUOoqf9r0j8x9OqcIVvyI1c3S6lro8KBkimc2zHBsBtbpy2Wwcq2s87Px8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fPZHw-0005qo-OQ; Sun, 03 Jun 2018 20:07:40 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF1917A60A6; Sun,  3 Jun 2018 16:07:39 -0400 (EDT)
Date:   Sun, 3 Jun 2018 16:07:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603200739.GC1750@thunk.org>
References: <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
 <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
 <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603192417.GA12416@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 09:24:17PM +0200, Peter Backes wrote:
> 
> He said: It would be a tyranny of lawyers.
> 
> Let's not have a tyranny of lawyers. Let us, the engineers and hackers, 
> exercise the necessary control over those pesky lawyers by defining and 
> redefining the state of the art in technology, and prevent them from 
> defining it by themselves. For a hammer, everything looks like a nail. 
> What is the better options: To suggest people to pay for legal advice 
> by lawyers, who only offer lengthy disclaimers and such for bypassing 
> the right to be forgotten, or simply discuss technical changes for git 
> which enable its easy implementation, without legal excuses for not 
> doing supporting it?

Why don't you try to implement your proposal then, and then benchmark
it.  After you find out how much of a performance disaster it's going
to be, especially for large git repos, we can discuss who is being
tyrannical.
 
It may very well be that different people and companies will get
different legal advice, and one of the interesting things about many
git repos for open source project is that it is not owned by any one
company.  A change in the git repo format is one that has to be
adopted by the entire open source project, and if a portion of the
community isn't interesting in paying the overhead cost, and sticks
with the existing git repo format, I wonder what the "imperialistic"
(your word, not mine) EU will do --- try to lock up or sue everyone
from outside the EU that refuses to pay the 2x-10x performance
overhead and sticks with the original repo format, such that anyone
who wants to interoperate has to send git pushes in the orignial
format?

But in any case, way don't you send a patch and we can discuss?  As
the old saying goes, "code talks, bullshit walks".   :-)

Regards,

    	       	     	   	  	   	     - Ted
