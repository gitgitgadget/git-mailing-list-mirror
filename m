Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBB4820970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbdDJKph (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:45:37 -0400
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:58571 "EHLO
        Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752126AbdDJKph (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:45:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by Psilocybe.Update.UU.SE (Postfix) with ESMTP id A966580364;
        Mon, 10 Apr 2017 12:45:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at Update.UU.SE
Received: from Psilocybe.Update.UU.SE ([127.0.0.1])
        by localhost (Psilocybe.Update.UU.SE [127.0.0.1]) (amavisd-new, port 10040)
        with ESMTP id opEuma8PBpAd; Mon, 10 Apr 2017 12:45:33 +0200 (CEST)
Received: from Samuel-Aslunds-MacBook-Air.local (static-92-33-13-234.sme.bredbandsbolaget.se [92.33.13.234])
        by Psilocybe.Update.UU.SE (Postfix) with ESMTPSA;
        Mon, 10 Apr 2017 12:45:33 +0200 (CEST)
Subject: Re: Git documentation on branching.
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
 <CACBZZX5jD0AhqZ8ucdicW=6s3=HPfpPeyne6jSVbZKnQ+sRZkQ@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
From:   =?UTF-8?Q?Samuel_=c3=85slund?= <samuel@update.uu.se>
Message-ID: <3b793b18-7911-1859-e54d-8817f9c97a78@update.uu.se>
Date:   Mon, 10 Apr 2017 12:45:33 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5jD0AhqZ8ucdicW=6s3=HPfpPeyne6jSVbZKnQ+sRZkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/4/10 12:21, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Apr 10, 2017 at 8:56 AM, Samuel Åslund <samuel@update.uu.se> wrote:
>> Hi all.
>>
>> I just started playing around with branching in git.
>> I have been using it more or less as Subversion until now.
>>
>> One feature with "git branch xyz" and "git checkout xyz" that is rather
>> obvious if you know them but bit me a little since I did not, is that
>> uncommitted work in progress is not affected or saved when switching between
>> branches. Thus I cleaned up the directory when working with the branch and
>> now I'm trying to find a stash where I hopefully have a copy of those files.
>>
>> Would it be possible to add something in the documentation to warn others
>> that uncommitted work is not saved or affected by branching?
>
> The main UI in git for switching branches is "git checkout", and it's
> mentioned in the second paragraph of the documentation:
>
> "[when switching branches] local modifications to the files in the
> working tree are kept, so that they can be committed to the
> <branch>.".
>
> Did you read this and find it unclear, and if so can you elaborate on
> what the confusion was, maybe we can fix the docs with that in mind?
>
> Or did you read some entirely different docs (what docs?) where we're
> perhaps not mentioning this as prominently?

No, I did not read the git checkout manpage.
When I googled "git branch" I got the two pages mentioned below and this 
one:
Git - Basic Branching and Merging
https://git-scm.com/.../Git-Branching-Basic-Branching-and-Mer...

I find that mostly manpages require some context before they are useful 
so I go for the more wordy pages when trying to get my head around 
something new. Neither of the three top-hits on google included the 
local modifications comment where I noticed it. An actual search for 
that string right now does not find anything either.

The comment you refer to in the git checkout man-page is probably enough 
heads-up for someone who knows git reasonably well, I do not know if it 
would have made me realize exactly how the feature works.
I'm not even sure I know how "local modifications" is defined in Git 
terminology, does it include "(un)staged changes", and or untracked files?

Thanks for the attention.

>> The first two hits on my google search was very informative about branching
>> but I did not see that specific nugget of information (I might have been
>> careless reading, but if I did not see it others will probably also miss
>> it).
>>
>> Git - git-branch Documentation
>> https://git-scm.com/docs/git-branch
>>
>> Git - Branches in a Nutshell
>> https://git-scm.com/book/.../Git-Branching-Branches-in-a-Nutsh...
>>
>> This is my first try to contribute to the Git community, I hope it will be
>> useful to somebody.
>>
>> Regards,
>> //Samuel

