Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B921F403
	for <e@80x24.org>; Sun,  3 Jun 2018 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750996AbeFCRe0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 13:34:26 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:36880 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbeFCRe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 13:34:26 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id PWtSfuvxRpXFjPWtbfzJRg; Sun, 03 Jun 2018 18:34:24 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=anyJmfQTAAAA:8 a=ZZAyCCvrgUPzNPYAjKEA:9 a=wPNLvfGTeEIA:10
 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <CE0F075DBC5A41FE87088A8E6B754D32@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Yubin Ruan" <ablacktshirt@gmail.com>,
        "Git List" <git@vger.kernel.org>
Cc:     "Geekaholic" <geekaholiclin@gmail.com>
References: <20180603005834.rwl5mx7llrv767xn@HP>
Subject: Re: git glob pattern in .gitignore and git command
Date:   Sun, 3 Jun 2018 18:34:09 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180603-4, 03/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfGpOCQCWWpEFdzItXk7QkdaJ1/GRD9VKp+PICgQ5vAoDihKRqq7EQZSEqgHBykJi5lB8+uWLn25vucExkYM20k+UHpKhpI0NWWAJE4Mx2JpS7PnW91rR
 ImL/13/qqJooFzXp0A2QXsiRssnttb3xJU33ZYdwJtxwwuO4V4NDu2WJ/ybacb/IgmO1L0bc34WbB2ASthpTdUPO3AixnZRD3aqgW/27Al7n2g5WJjh+jPvp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yubun,

From: "Yubin Ruan" <ablacktshirt@gmail.com>
> To ignore all .js file under a directory `lib', I can use "lib/**/js" to
> match
> them. But when using git command such as "git add", using "git add
> lib/\*.js"
> is sufficient. Why is this difference in glob mode?
>
> I have heard that there are many different glob mode out there (e.g., bash
> has
> many different glob mode). So, which classes of glob mode does these two
> belong to? Do they have a name?
>

Is this a question about `git add` being able to add a file that is marked
as being ignored in the .gitignore file? [Yes it can.]

Or, is this simply about the many different globbing capabilities of one's
shell, and of Git?

The double asterix (star) is specific/local to Git. It is described in the
various commands that use it, especially the gitignore man page `git help
ignore` or  https://git-scm.com/docs/gitignore.
"Two consecutive asterisks ("**") in patterns matched against full pathname
may have special meaning: ... "

The single asterix does have two modes depending on how you quote it. It is
described in the command line interface (cli) man page ` git help cli` or
https://git-scm.com/docs/gitcli.
"Many commands allow wildcards in paths, but you need to protect them from
getting globbed by the shell. These two mean different things: ... "

A common proper name for these asterix style characters is a "wildcards".
Try 'bash wildcards' or linux wildcards' in your favourite search engine.

--
Philip

