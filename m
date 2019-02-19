Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E389F1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 11:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfBSLi4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 06:38:56 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:55904 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfBSLi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 06:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RAJ028+08AMTwfCB1cR8TFoPzFZodWC7SiCMEtlx2DA=; b=Jyk3nZL1LGppuo3sP92mySNM4
        h4ZOV5tUoSHYnRa2b0iQkVLn8z210fB+sq+LKWZ5RePke4b6y25+bNbqjpu5wjK8HNyIECzS1RyDC
        HO+JDcFHEMN4NeYkY42EP+ZyLvj1jBV0beC2DTryXtQiPwwkv7dTpey/4NpNIIojX6SpY42UA6T2+
        kgeXNekgeJ8QQZ1xLLk/DHJF2/+WpNNUaPYDGwOCsNGhfH24ppNSSkWQD5eFP4pbtkWm8zwCtwAVn
        2i3Js6atl4uvSpY/h5/k5CiykADs+Dshg9i6ZEFOz6t/k8DawO3IBiRgiSP4W9uhNWdYKd8+SaJDH
        JTUB++7LA==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:47466 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gw3jh-00DwC4-Qs; Tue, 19 Feb 2019 06:38:54 -0500
Date:   Tue, 19 Feb 2019 06:38:52 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: why no mention of "hooks.allownonascii" in any man page?
In-Reply-To: <87mums58f2.fsf@evledraar.gmail.com>
Message-ID: <alpine.LFD.2.21.1902190629490.25090@localhost.localdomain>
References: <alpine.LFD.2.21.1902190544470.23739@localhost.localdomain> <87mums58f2.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1521906173-1550576334=:25090"
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

--8323328-1521906173-1550576334=:25090
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 19 Feb 2019, Ævar Arnfjörð Bjarmason wrote:

>
> On Tue, Feb 19 2019, Robert P. J. Day wrote:
>
> >   was just perusing the sample hook scripts, and the sample pre-commit
> > script provided with git does the following check:
> >
> > # If you want to allow non-ASCII filenames set this variable to true.
> > allownonascii=$(git config --bool hooks.allownonascii)
> >
> >   but that config variable (hooks.allownonascii) is not mentioned in
> > any man page. its entire existence in the git code base consists of:
> >
> > $ grep -r allownonascii *
> > templates/hooks--pre-commit.sample:allownonascii=$(git config --bool hooks.allownonascii)
> > templates/hooks--pre-commit.sample:if [ "$allownonascii" != "true" ] &&
> > templates/hooks--pre-commit.sample:  git config hooks.allownonascii true
> >
> >   technically, there's nothing wrong with that, i just thought it was
> > a bit weird that a sample hook script refers to a config variable that
> > is not referred to in any way elsewhere.
>
> The hook itself spontaneously introduces it and uses it. There's
> nothing magical about config variable, e.g. it could also be
> "xyz.abc" instead of "hooks.allownonascii".
>
> But perhaps it should be documented as the functionality of the
> default hook in githooks(5), similarly to how we document
> hooks.allowunannotated. Patches welcome :)

  sure, i'll take care of that.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1521906173-1550576334=:25090--
