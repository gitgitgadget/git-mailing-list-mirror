Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072AE1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 19:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeFCTL0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 15:11:26 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41074 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbeFCTLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 15:11:25 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53JBJpN004985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 21:11:20 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53JBJun004984;
        Sun, 3 Jun 2018 21:11:19 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53JB7J8012306;
        Sun, 3 Jun 2018 21:11:07 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53JB7t4012305;
        Sun, 3 Jun 2018 21:11:07 +0200
Date:   Sun, 3 Jun 2018 21:11:07 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603191107.GA12182@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <20180603181807.GB1750@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603181807.GB1750@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 02:18:07PM -0400, Theodore Y. Ts'o wrote:
> I would gently suggest that if you really want to engage in something
> practical than speculating how the GPDR compliance will work out in
> actual practice, that you contact a lawyer and get official legal
> advice?

I completely disagree.

Erasure is a technical issue to be solved by engineers, not by lawyers.

And that's completely in line with the GDPR. The GDPR is ultimately not 
a legal thing to be solved by lawyers writing lengthy legal 
argumentations and disclaimers and such. They are not even the ones to 
take lead in GDPR implementation. All that would be simply snake oil. 
Some legal documentation may be necessary, and having a competent 
lawyer in a GDPR compliance task force is certainly a must. But that 
gets you done only 20% of the job, 80% is engineering. Every lawyer who 
claims to give you shady legal tricks to get the job 100% done in no 
time is a liar.

The GDPRs ultimate goal is to incline the world to improve how data 
protection is implemented on a technical level. The GDPR contains 
several blanket clauses that refer to the "state of the art" of 
technology, which the GDPR itself of course does not define and which 
is of course nothing a lawyer has any competence in.

My proposal is a technical, not a legal one: Provide a generic 
possibility of having eraseability and verifiability at the same time 
in git. Improve the state of the art in version control such that it is 
more in line with the GDPRs idea that people have a right to be 
forgotten, but to also be useful for a multitude of other applications. 
The lawyers can then build on this.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
