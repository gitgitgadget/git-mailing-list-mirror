Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEB62070D
	for <e@80x24.org>; Thu,  7 Jul 2016 17:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcGGR2e (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 13:28:34 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:36739 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbcGGR2d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2016 13:28:33 -0400
Received: by mail-io0-f171.google.com with SMTP id l202so25734878ioe.3
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 10:28:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Va4HlII2YgfpSUrNJb4EFeD6UCNEKcewAmb5MDjXdJ8=;
        b=Qy0YDMg9jKbtVxMv8tidwa0snQxyAg31JZcXzSOpsdRVQXibPPutxTZ3padQ9Ajd8p
         msGwuHjVcuVoVsu6YQSI7LTGR20B4Kps/yA25v77qS+yHF4i4zrfR8X0aPZ+PBpp+Lep
         BYwg3Ely2xJLxW2Bp/xcbMpNfAyXlOGAYebxe4BTzYk5NdbMZO1xV7vPeHZHL8sVe3Ma
         sGwHqBVPmFILJiSngFdh1NcQJcLZvg0m+OCOi1SzvmP4qGh5LVt5LLFtNYChjjynVbNj
         WpFswutomJZLL1r6+d7iNSg2MttRLvLYHRCfMLo65c/S5ibV9Fi4j14oEtiCD7pRG4VR
         2spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Va4HlII2YgfpSUrNJb4EFeD6UCNEKcewAmb5MDjXdJ8=;
        b=Qo1Ssd+hLsX7l6YvA4loZDV2iSLoZz4Rm9WP+X4wrkHTZBZz66dAXKdeaghM3GoqlV
         Px+PCtXR7acWEtWxGvT+gw2k6pTeEPiVBHiJbXPwwVfVPZyv9BWoNFzZE75ZgxqadCLH
         B/2hELc7BdnzMRV9zK82H0uWpiQZo9OLAHzuiG5GCSOLh3PEN/w43FhvCzvZgxI2U4OP
         gA43M9FN4FlanwjJZZv4oCiz2xQWxhUc0kBhnZNrro0Z64K8V0H6lBngERRoRd3UALok
         EZT3cYvjsPu4MiEyUG+ybdifO+2bx4GCmGhZATvebNHIpjaKj0z+m+uyxY8wzpcaUvxN
         fpsg==
X-Gm-Message-State: ALyK8tIjSiTMGP1gE9eUE7LBS1t+J6p1NWsnJA3wLz9E/PSDwZFCSSaB9WwLJd6NJh4dVVJ+kLwxlChvUyQ/OzjY
X-Received: by 10.107.186.196 with SMTP id k187mr4266660iof.173.1467912512893;
 Thu, 07 Jul 2016 10:28:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 10:28:32 -0700 (PDT)
In-Reply-To: <577E6F32.7020007@gmail.com>
References: <577E6F32.7020007@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 10:28:32 -0700
Message-ID: <CAGZ79kZCbu4djv0j6WvgPO1Lr=FwFkNnECyBjweP-SsssY1J3w@mail.gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2016"
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Doug Rathbone <doug@dougrathbone.com>,
	David Bainbridge <david.bainbridge@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 8:03 AM, Jakub Narębski <jnareb@gmail.com> wrote:
> I am thinking about returning to doing the Git User's Survey, and
> I'd like to ask for feedback.

Thanks for doing the survey!

>
> What I'd like to see is how people use Git, which features do they
> use and which tools (maybe there is some great unknown tool there?),
> where they go to find help about Git.
>
> What types of questions should there be in this year survey?
>

Additionally to the categories you listed, I'd like to propose

4. TEMPORAL. We may get feedback if and how much
some pain points were addressed since the last survey.
This can be done by using the very same question we used in
the last questionnaire, and see how much the answers shifted
or by doing more suggestive questions ("Last survey showed,
feature X is not easy to use, how easy is it now? Think of X
in v1.7.5")

AFAICT the last survey was 2012?

As for the content, I think submodules improved a lot
since then, however I do think they could be improved even more.
e.g. one question could be:

What would you think would improve submodules most
if you could only pick one?

* inclusion of submodules into more commands, e.g.
  "git checkout --recurse-submodules"
* support for direct clones of submodules from a host
  (i.e. not going through the .gitmodules file, but trying
  to obtain the submodule from that superprojects
  .git/modules/<name>. This would only work for non
  bare repos)
* more fault tolerance for miss-configured submodules
* more descriptive error messages for miss-configured
  submodules
* ...

This would help to gauge how to best spend developer time
when trying to improve a feature (like submodules)

Thanks,
Stefan
