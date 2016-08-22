Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D451F859
	for <e@80x24.org>; Mon, 22 Aug 2016 18:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755868AbcHVSjm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 14:39:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32836 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755476AbcHVSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 14:39:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so14742965wme.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=M6MCWjl4IWnebbbs2EcTwDSXTjvXvM+Qf3yqE65ofqQ=;
        b=GN939Qk8kv28A0vfTo54F56UnmA2FNB+mk1Hs8iPblqXfbkD78DS57fXo44f+j2pn/
         qZYWjSolw54/qa8KBsOQy7aoWVd2jXCK5tCtAH8U5Nn9zFBc2/S2n2DpzEnP5U5AMOM7
         2G2cssQQnuXwzb2ClJZ76B9/kGg4QcHD9D9h8hzk1WHGDDOa+qNR6m+Ga2bQ1x3KrW6Y
         2aCOukW9RGDaDJNukWXf74Q4DC346TpORvLKXzn78a5rLfnpp+GyRkjWw9RrEnJY0uB+
         1ScS2doib5/tzLuGPwdk16gVPfkHPDUZ4asq2arPKG/UhwaeF2htOF9lwlgUIi2fEp9Z
         t/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=M6MCWjl4IWnebbbs2EcTwDSXTjvXvM+Qf3yqE65ofqQ=;
        b=H3cDQMise+JFVayMGGF61NWGstHl3e/BEuVFm5uPDRdixYuMjOF1bp7YqZmw7BpIes
         ygCrNNGyPuGfDnb4ed3S8Wjl8op4jWQSTgUHj459TtmkcpLjFxJTT2iDJi506PmBy/pH
         KFEcBd2p/bwqeLFQ1jNa6K3GdoShnbGk6AnZWi19gax4OaB+ULKk/omYA6eMFHYpVKTC
         TPjz+R6rHQ73NRxSJY0eJ7HWOMk16MwVGWDCo8C0G7godpQsAn6e2JYwMTMql8UmjAGB
         KMXfQ5+Uo4zHSal5MxD23UscTKHQKe+fnzTEP0G97yySxb2nGv9RyPjARYCvT3YOmq1V
         63Ag==
X-Gm-Message-State: AEkoouu8fJKdvWK1sPmA1pUf6CEIgzPIabGycwXt7R5p/3SxDiClXMGWDZuiSBfIiatioA==
X-Received: by 10.194.77.174 with SMTP id t14mr20716235wjw.146.1471891178724;
        Mon, 22 Aug 2016 11:39:38 -0700 (PDT)
Received: from [192.168.1.26] (abri28.neoplus.adsl.tpnet.pl. [83.8.102.28])
        by smtp.googlemail.com with ESMTPSA id p83sm22973525wma.18.2016.08.22.11.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 11:39:37 -0700 (PDT)
Subject: Re: Extending "extended SHA1" syntax to traverse through gitlinks?
To:     Josh Triplett <josh@joshtriplett.org>
References: <9bad3d13-3257-2077-a734-f985c375b8d3@gmail.com>
 <20160821142634.dorgzldjvc3qiaby@x>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ab6e29c1-ea6d-c1c5-e69f-867c16cc736a@gmail.com>
Date:   Mon, 22 Aug 2016 20:39:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160821142634.dorgzldjvc3qiaby@x>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.08.2016 o 16:26, Josh Triplett pisze:
> On Sun, Aug 21, 2016 at 03:46:36PM +0200, Jakub Narębski wrote:
>> W dniu 21.08.2016 o 00:50, Josh Triplett pisze:
>>> Currently, if you have a branch "somebranch" that contains a gitlink
>>> "somecommit", you can write "somebranch:somecommit" to refer to the
>>> commit, just like a tree or blob.  ("man git-rev-parse" defines this
>>> syntax in the "SPECIFYING REVISIONS" section.)  You can use this
>>> anywhere you can use a committish, including "git show
>>> somebranch:somecommit", "git log somebranch:somecommit..anotherbranch",
>>> or even "git format-patch -1 somebranch:somecommit".
>>>
>>> However, you cannot traverse *through* the gitlink to look at files
>>> inside its own tree, or to look at other commits relative to that
>>> commit.  For instance, "somebranch:somecommit:somefile" and
>>> "somebranch:somecommit~3" do not work.
>>
>> Note that there is the same problem traversing through trees:
>> while 'git cat-file -p HEAD:subdir/file' works, the 'HEAD:subdir:file'
>> doesn't:
>>
>>   $ git cat-file -p HEAD:subdir:file
>>   fatal: Not a valid object name HEAD:subdir:file
> 
> Interesting point; if extending this syntax anyway, any treeish ought to
> work, not just a committish.

Actually, because you can use simply "HEAD:subdir/file" I'd rather
it didn't work (no two ways of access), unless we can get it for free.

>> Though you can do resolve step manually
>>
>>   $ git cat-file -p $(git rev-parse HEAD:subdir):file
>>
>> This works.
> 
> True, but that seems quite inconvenient.

Especially that for submodules you need:

$ git --git-dir=subdir/.git cat-file -p $(git rev-parse HEAD:subdir):file

(or something like that), assuming that you start in supermodule.
 
>>> I'd love to have a syntax that allows traversing through the gitlink to
>>> other files or commits.  Ideally, I'd suggest the syntax above, as a
>>> natural extension of the existing extended syntax.
>>
>> And with the above manual resolving, you can see the problem with
>> implementing it: the git-cat-file (in submodule) and git-rev-parse
>> (in supermodule) are across repository boundary.
> 
> Only if the gitlink points to a commit that doesn't exist in the same
> repository.  A gitlink can point to a commit you already have.

The idea of submodules is that tree object in superproject includes
link to commit of subproject (so called gitlink).  Tree object is
in superproject repository, while gitlinked commit is in submodule
repository.

True, with modern Git the submodule repository is embedded in .git
area of superproject, with '.git' in submodule being gitling file,
but by design those objects are in different repositories, in different
object databases.

>> Also the problem with proposed syntax is that is not very visible.
>> But perhaps it is all right.  Maybe :/ as separator would be better,
>> or using parentheses or braces?
> 
> It seems as visible as the standard commit:path syntax; the second colon
> seems just as visible as the first.  :/ already has a different meaning
> (text search), so that would introduce inconsistency.

Actually ":/" has a special meaning only if it is at beginning:
 - :/<text> for first matching commit from any ref
 - :/       is 'top directory' pathspec (equivalent to ':(top)')

But perhaps '//' would be better.

>>> (That syntax would potentially introduce ambiguity if you had a file
>>> named "somecommit:somefile" or "somecommit~3".  That doesn't seem like a
>>> problem, though; the existing syntax already doesn't support accessing a
>>> file named "x..y" or "x...y", so scripts already can't expect to access
>>> arbitrary filenames with that syntax without some kind of quoting, which
>>> we also don't have.)
>>
>> Errr... what?
>>
>>   $ echo A..B >A..B
>>   $ git add A..B
>>   $ git commit -m 'A..B added'
>>   [master 2d69af9] A..B added
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>    create mode 100644 A..B
>>   $ git show HEAD:A..B
>>   A..B
> 
> I stand corrected; I didn't find that.  I thought rev parsing worked
> independently from the repository, and didn't have any automagic
> detection based on the contents of the repository?

It probably depends on whether command expects range (like git-log),
supports range-like notation (like git-diff), or expects single or
multiple things (like git-show).

> This seems ambiguous, and (AFAICT) not documented.  If HEAD:A and B both
> refer to a commit, in addition to the blob A..B, which will HEAD:A..B
> refer to?  I did test the HEAD:gitlink..anotherbranch case, and it does
> parse as a range.

Well, it is ambiguous.

We would probably want to support some kind of quoting, for example
HEAD:"A..B" (where everything inside "..." is c-quoted, but can use utf-8).

-- 
Jakub Narębski 


 

