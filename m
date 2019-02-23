Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D602220248
	for <e@80x24.org>; Sat, 23 Feb 2019 18:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfBWScW (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 13:32:22 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:49400 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfBWScW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 13:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uydfzEArZ4Uj48OEK4N6LcFjFf1qHHloxGSuxyWB7dc=; b=v7oCohPtNY/LI0/VQp0Vk0o16
        zEiJxZMFMu0I68fedAZveUQPi47mJo67/STQE+3G5hiIoyW2U9RibehUgog55ST7SMTUb2qOvAtbl
        kprBLh6uBqTE9tESa8CiivdFwbeCWTtV9BhOc4ZTryYMPwiD/ofCDCuxFQVNleTFrWIFLWn1Ymtv+
        vjqgu1By9XYUzT6KWDjRmiBUjkChRO2olxAYgL0Y0bQ7YE9gMcO9NR6kcy9xT+eC+wSOjdSeHPDEp
        Z4YM/xRqyHhlr+MuwOCbzCrCvfJOPEk4j/zwAeOtPF2a6X5as5d0Y3/iFmXxR0VZ33RYA6Yd76NtL
        VnoiSDz4g==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:37996 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1gxc5x-00GqPu-SN; Sat, 23 Feb 2019 13:32:19 -0500
Date:   Sat, 23 Feb 2019 13:32:16 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
In-Reply-To: <nycvar.QRO.7.76.6.1902231912370.45@tvgsbejvaqbjf.bet>
Message-ID: <alpine.LFD.2.21.1902231328560.2222@localhost.localdomain>
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain> <xmqqimxao76b.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902231905180.45@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1902231912370.45@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1955465509-1550946738=:2222"
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

--8323328-1955465509-1550946738=:2222
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

On Sat, 23 Feb 2019, Johannes Schindelin wrote:

> Hi,
>
> On Sat, 23 Feb 2019, Johannes Schindelin wrote:
>
> > On Sat, 23 Feb 2019, Junio C Hamano wrote:
> >
> > > "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
> > >
> > > >   am i misreading something? and if not, is there a reason git clean
> > > > does not consult core.excludesFile?
> > >
> > > Can you ask "git log" and "git blame" whch of  core.excludesFile and
> > > "clean -x" features came earlier and by how big a difference?
> >
> > Or maybe we can have a look why the `core.excludesfile` regression test
> > case in t7300 does not catch this?
> >
> > https://github.com/git/git/blob/v2.21.0-rc2/t/t7300-clean.sh#L408-L417
>
> I actually doubt that `git clean` ignores `core.excludesFile`: in
> https://github.com/git/git/blob/v2.21.0-rc2/config.c#L1297-L1298,
> `git_default_core_config()` (which is called via the `git_clean_config()`
> -> `git_color_default_config()` -> `git_default_config()` chain from
> `cmd_clean()`) does interpret `core.excludesFile`:
>
> 	if (!strcmp(var, "core.excludesfile"))
> 		return git_config_pathname(&excludes_file, var, value);
>
> Then, `cmd_clean()` goes on to parse the options, setting the `ignored`
> variable upon `-x` and then doing
> [this](https://github.com/git/git/blob/v2.21.0-rc2/builtin/clean.c#L957-L958):
>
> 	if (!ignored)
> 		setup_standard_excludes(&dir);
>
> This function specifically looks at `excludes_file` in
> https://github.com/git/git/blob/v2.21.0-rc2/dir.c#L2481-L2483:
>
> 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
> 		add_excludes_from_file_1(dir, excludes_file,
> 					 dir->untracked ? &dir->ss_excludes_file : NULL);
>
> So I am quite puzzled by the claim that `git clean` might not consult
> `core.excludesFile`.
>
> Robert, care to come up with an example demonstrating where it does not?

  sorry i wasn't clear, all i was pointing out was that "man
git-clean" *explicitly* mentioned two locations related to cleaning:

  -x
        Don¢t use the standard ignore rules read from .gitignore
        (per directory) and $GIT_DIR/info/exclude, ...

without additionally *explicitly* mentioning core.excludesFile. if the
man page simply said something like, "using the standard ignore
processing" and left it at that, it would be fine, but to list two of
the locations without the third is potentially confusing.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
--8323328-1955465509-1550946738=:2222--
