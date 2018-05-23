Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC16F1F42D
	for <e@80x24.org>; Wed, 23 May 2018 08:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbeEWIAq (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 04:00:46 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:42318 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754185AbeEWIAq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6OzabgZJaMyarBp3UmqLy3sBmkx4N1c/vLpT+26ttdQ=; b=dFmC/HASmwUZbgQIwYGpQst0h
        UYUA+ZgsLaNWa056/cRRXM5CrR/77yg7vUy5sXqJcg8XzOLCq8vm93S9un1Kf9OK76lZVkooAn0Db
        XOWaJ/53QzSKbuLHi7RrRJZmZlUpAGZB8QEUOjtZoO9L3h/Q2GaS/xGzB19ZTzqVwwAEdHc96OajH
        g7QSZNUxyQ/F1H6ZTbp5qQAACVIpPyGydro+g+NRdVUN5VgerbLkCUpSCXNcj1h+o02LoRNX2TbF9
        kVO5rUAFvcI0LQYTE49zk0eLPWhPeuE2/62ONYa0ZER4wJUFsx+ZltXZhkXQ2esu8O8vdQ+VODTcw
        klkceyrKQ==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:44326 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fLOhK-0097C2-Ej; Wed, 23 May 2018 04:00:44 -0400
Date:   Wed, 23 May 2018 03:59:01 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: should config options be treated as case-sensitive?
In-Reply-To: <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1805230354270.16358@localhost.localdomain>
References: <alpine.LFD.2.21.1805220353370.989@localhost.localdomain> <87h8mz99d2.fsf@evledraar.gmail.com> <xmqqo9h7w2y2.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2007282615-1527062344=:16358"
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2007282615-1527062344=:16358
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 23 May 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> > The issues you note about the docs using foo.barbaz instead of
> > foo.barBaz should be fixed, but as noted in the "Syntax" section
> > of "git-config" we already document that the config keys are all
> > case-insensitive. We just like talking about them as foo.barBaz
> > because it makes for easier reading.
>
> The first and the last level of configuration variable names are
> case insensitive.
>
> I said "first and last", as there are variables with 2-level and
> 3-level names.  "foo.barBaz" is two-level and it is the same
> variable as "Foo.barbaz".  "remote.origin.url" is three-level, and
> it is the same variable as "Remote.origin.URL", but it is not the
> same variable as "remote.ORIGIN.url".
>
> If the documention does not make it clear, then we have
> documentation bug ...

  personally, i would add a short, really emphatic note at the top of
"man git-config" pointing this out -- i wouldn't require people to
read all the way down to "Syntax" to learn this. an example just like
the one you provide above would be perfect, with an extra line
pointing out that the documentation uses "camel case" for nothing more
than readability.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-2007282615-1527062344=:16358--
