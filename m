Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D2C49EA3
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5998461990
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbhF1PWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:22:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:26330 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237846AbhF1PUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 11:20:33 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lxt1R-0003eI-6x; Mon, 28 Jun 2021 16:18:05 +0100
Subject: Re: Definition of "the Git repository"
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <070e36dc-f126-661a-3af7-b44d47ef7861@iee.email>
Date:   Mon, 28 Jun 2021 16:18:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2021 03:24, Kevin Buckley wrote:
> On 2021/06/26 04:48, Philip Oakley wrote:
>>
>> ... One can also include in the generic 'repository' the
>> various special .git* files that are [user] added to the main source
>> directory.
>>
>> But it gets worse. In the .git directory there is the 'objects' ...
>
> I don't believe it does get worse, indeed, I am not convinced that it
> is as bad as your observation on the semantics might suggest.
>
> Everything within the .git directory "belongs", in my way of thinking,
> to the "repository", that is, the directory that gets created when git
> is (init)ialised.

Part of my view (of the multiplicity of descriptives within Git)
regarding what is in a repository is from comparing the git created
content from a clone, that of a `git init`, and a users overall project
and .git trees after multiple interactions. Each has different features.

>
> For me, the 'objects", the 'ref/heads', the "staging area' and the like,
> also lie within the repository.
>
> As for any anciliary files, that control how the git commands actually
> process any data in the "working directory" beyond the defaults, some
> of them, eg the global commands, will typically exist outside of the
> working directory: below one's home directory, and, of course, there
> are the system-wide files, typically below /etc.
>
> Given then, that we can have Git-related files, for any given working
> directory, below /etc, below the user's home directory, and within the
> working directory itself, perhaps it is the whole "computer" which
> should be referred to as "the repository"?
>
> Furthermore, even in the case of anciliary files typically found within
> the working directory, and I'm thinking of .gitignore as the obvious
> example, even the directives in that can be overriden on the command
> line, as well as complemented by files outside of the working directory.
>
>
> I am tempted to say that even if the definition of a "repository" can't
> be agreed on, or rather, easily determined by inspection, then at least
> the corresponding working directory can be, however, the fact that one
> has  access to EnvVars and corresponding command line arguments such as
> --git-dir=<path>, --work-tree=<path>, would suggest that it could be
> harder for the novice to get their head around things, however, as it is
> typicaly clear what the working directory is (the top level directory
> containing the files you are working on, under the control of Git),
> calling that same directory the "repository" seems, to me anyway, to add
> to any confusion, that a Git novice may have.
>
> Given the can of worms that this question has opened up, although I'm
> getting the feeling that it has long since been opened, I still maintain
> that it would be less confusing, at least for a novice, for the working
> directory to be identified and for a previously non-existent directory,
> that gets created by the 'git init', to be referred to as the repository,
> so as to make a distinction.

My main point was that there is this creative tension between the
different contexts and that beginners should be aware that it's not all
cut and dried in the same way that language definitions tend to be.

--

Philip

