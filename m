Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 939171F404
	for <e@80x24.org>; Tue, 17 Apr 2018 22:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDQWrZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 18:47:25 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:63443 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeDQWrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 18:47:24 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id 8ZNbftV5S4Zqz8ZNcfjVnS; Tue, 17 Apr 2018 23:47:22 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=xtxXYLxNAAAA:8 a=4RBUngkUAAAA:8 a=E7KYChPCCtzxrfhf7OcA:9 a=wPNLvfGTeEIA:10
 a=xts0dhWdiJbonKbuqhAr:22 a=_sbA2Q-Kp09kWB8D3iXc:22
Message-ID: <8F15D4F40F164250987F5DD3896AD825@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Git List" <git@vger.kernel.org>,
        =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com> <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley> <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com> <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley> <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com> <20180417164831.GA18563@duynguyen.home>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
Date:   Tue, 17 Apr 2018 23:47:15 +0100
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
X-Antivirus: AVG (VPS 180417-4, 17/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPn7CA8/UMlRyU+jJvsFIpc4ALbPCfMVMBNwMBLpvjBc0Ti6cygDS0vp3KmBLirZgX0nyGqXUMCDGyEre+dQ4S7VTykoi5I/6n4HoBHMsxlVCnsS0V25
 U6GqC6D4Ai5wF14KRbVYXYS8oAbqjgfkrQ9af5AXpXMmb5YceBfraJKsjaNjsoW/y37qC0vXFC8r0FlaFpWowvlT1dpq4qkjyu7ELr5iWV5mMilpNzFOcygK
 QCSQp/biXnlmxdSvZ1VvmVBRIpaktutEkvYHldrRFi0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com> : Tuesday, April 17, 2018 5:48 PM
> On Tue, Apr 17, 2018 at 06:24:41PM +0200, Duy Nguyen wrote:
>> On Sun, Apr 15, 2018 at 11:21 PM, Philip Oakley <philipoakley@iee.org> 
>> wrote:
>> > From: "Duy Nguyen" <pclouds@gmail.com> : Saturday, April 14, 2018 4:44 
>> > PM
>> >
>> >> On Thu, Apr 12, 2018 at 12:06 AM, Philip Oakley <philipoakley@iee.org>
>> >> wrote:
>> >>>
>> >>> I'm only just catching up, but does/can this series also capture the
>> >>> non-command guides that are available in git so that the 'git 
>> >>> help -g'
>> >>> can
>> >>> begin to list them all?
>> >>
>> >>
>> >> It currently does not. But I don't see why it should not. This should
>> >> allow git.txt to list all the guides too, for people who skip "git
>> >> help" and go hard core mode with "man git". Thanks for bringing this
>> >> up.
>> >> --
>> >> Duy
>> >>
>> > Is that something I should add to my todo to add a 'guide' category 
>> > etc.?
>>
>> I added it too [1]. Not sure if you want anything more on top though.

What I've seen is looking good - I've not had as much time as I'd like..

I'm not sure of the status of the git/generate-cmdlist.sh though. Should 
that also be updated, or did I miss that?
--
Philip

>
> The "anything more" that at least I had in mind was something like
> this. Though I'm not sure if it's a good thing to replace a hand
> crafted section with an automatedly generated one. This patch on top
> combines the "SEE ALSO" and "FURTHER DOCUMENT" into one with most of
> documents/guides are extracted from command-list.txt
>
> -- 8< --
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6232143cb9..3e0ecd2e11 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -292,6 +292,7 @@ doc.dep : $(docdep_prereqs) $(wildcard *.txt) 
> build-docdep.perl
>
> cmds_txt = cmds-ancillaryinterrogators.txt \
>  cmds-ancillarymanipulators.txt \
> + cmds-guide.txt \
>  cmds-mainporcelain.txt \
>  cmds-plumbinginterrogators.txt \
>  cmds-plumbingmanipulators.txt \
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> index 5aa73cfe45..e158bd9b96 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -54,6 +54,7 @@ for (sort <>) {
>
> for my $cat (qw(ancillaryinterrogators
>  ancillarymanipulators
> + guide
>  mainporcelain
>  plumbinginterrogators
>  plumbingmanipulators
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 4767860e72..d60d2ae0c7 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -808,29 +808,6 @@ The index is also capable of storing multiple entries 
> (called "stages")
> for a given pathname.  These stages are used to hold the various
> unmerged version of a file when a merge is in progress.
>
> -FURTHER DOCUMENTATION
> ----------------------
> -
> -See the references in the "description" section to get started
> -using Git.  The following is probably more detail than necessary
> -for a first-time user.
> -
> -The link:user-manual.html#git-concepts[Git concepts chapter of the
> -user-manual] and linkgit:gitcore-tutorial[7] both provide
> -introductions to the underlying Git architecture.
> -
> -See linkgit:gitworkflows[7] for an overview of recommended workflows.
> -
> -See also the link:howto-index.html[howto] documents for some useful
> -examples.
> -
> -The internals are documented in the
> -link:technical/api-index.html[Git API documentation].
> -
> -Users migrating from CVS may also want to
> -read linkgit:gitcvs-migration[7].
> -
> -
> Authors
> -------
> Git was started by Linus Torvalds, and is currently maintained by Junio
> @@ -854,11 +831,16 @@ the Git Security mailing list 
> <git-security@googlegroups.com>.
>
> SEE ALSO
> --------
> -linkgit:gittutorial[7], linkgit:gittutorial-2[7],
> -linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
> -linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
> -linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
> -linkgit:gitworkflows[7]
> +
> +See the references in the "description" section to get started
> +using Git.  The following is probably more detail than necessary
> +for a first-time user.
> +
> +include::cmds-guide.txt[]
> +
> +See also the link:howto-index.html[howto] documents for some useful
> +examples. The internals are documented in the
> +link:technical/api-index.html[Git API documentation].
>
> GIT
> ---
> diff --git a/command-list.txt b/command-list.txt
> index 1835f1a928..f26b8acd52 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -150,10 +150,14 @@ git-whatchanged 
> ancillaryinterrogators
> git-worktree                            mainporcelain
> git-write-tree                          plumbingmanipulators
> gitattributes                           guide
> +gitcvs-migration                        guide
> +gitcli                                  guide
> +gitcore-tutorial                        guide
> giteveryday                             guide
> gitglossary                             guide
> gitignore                               guide
> gitmodules                              guide
> gitrevisions                            guide
> gittutorial                             guide
> +gittutorial-2                           guide
> gitworkflows                            guide
> -- 8< --
> 

