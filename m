Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD1F1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 19:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeDMTzN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 15:55:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53857 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751782AbeDMTzM (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Apr 2018 15:55:12 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 959B121BD4;
        Fri, 13 Apr 2018 15:55:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 13 Apr 2018 15:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tUyI/5
        Cp5lEDS2jkT20uEGE2hQDlnHInhyOvK1KiaBk=; b=FQFMy2geeiThKt0kjRUyqp
        /yfPRrp1bNXO6nVM6sMtvvNqYyBkSMz1vSEcjElOunzytCXkqQnabOGGJLPqPjg9
        D40zDkwtgTxsobhxI/vAWT+NoXB8l3KEh9x6unpPEdMDtahJX7roBytyBaSfRSZP
        2JnvZ2vNh888Ah6YMWepOX8YpHddVQJYbdH5NJvjgNyoxUk1qN7AbD9n8XG/SixA
        UKq12P7lRTBsFga/+s+OkbT+on5L4IjxqKSImIbHP5upiFiOb1cbJ/ZUlMWOPI7a
        E4JjcanYOCx91LHjeKysyZt0BtiOpQiy0OKquUIrZ+4ZcGFUsaLmPE0jVZYsIQwA
        ==
X-ME-Sender: <xms:HwvRWhQhn-ykoyCzi_usKXO6VqUmWGvK4tkQNnkgeiK-MOoJY5mdRA>
Received: from bod.fritz.box (p54826bc2.dip0.t-ipconnect.de [84.130.107.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15D5CE508D;
        Fri, 13 Apr 2018 15:55:11 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id 5E32E7C020F; Fri, 13 Apr 2018 21:55:09 +0200 (CEST)
Date:   Fri, 13 Apr 2018 21:55:09 +0200
From:   Michael Vogt <mvo@ubuntu.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] Add "git show --follow-symlinks HEAD:symlink"
Message-ID: <20180413195509.GB19030@bod>
References: <20180409090047.lfru2ul5fbnggfg7@bod>
 <87in90zq2a.fsf@evledraar.gmail.com>
 <20180413094314.GA2404@bod>
 <CAGZ79kZDUnxkKfqRnZiLhweJ4HNO5sSGUfxkEvJPGagV4wmtkg@mail.gmail.com>
 <20180413174819.GA19030@bod>
 <87h8oegavn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8oegavn.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 13, 2018 at 09:33:00PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Apr 13 2018, Michael Vogt wrote:
> 
> > The update patch is attached as an inline attachement.
> 
> Your patch still just shows up as a straight-up attachment in many
> E-Mail clients. Note the difference between what your patch
[..]
> This is why Documentation/SubmittingPatches suggests using format-patch
> & send-email. You don't *have* to use those tools, and can use something
> that's compatible with what's expected on-list, but what you're doing
> isn't that.

My apologizes, I resend it using "git send-email".

Cheers,
 Michael
