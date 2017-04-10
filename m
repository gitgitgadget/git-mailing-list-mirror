Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34FB20970
	for <e@80x24.org>; Mon, 10 Apr 2017 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbdDJK7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 06:59:48 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33590 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbdDJK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 06:59:47 -0400
Received: by mail-io0-f178.google.com with SMTP id t68so56693592iof.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tx3EF+mpctamvq8xqT3tsby9Vr66NN6OwrKWOFPhhxw=;
        b=ImUn/BCMMZVYzTv9rYR7OsaShBni6x+XafM34d5upOhUf6eVvMzjIBHVWoH5yTROFa
         cIEHML6LtPeaQIvpwakSPrkXaYSWtrA2Q0In+0Ji1GuVCnoshmuRxCAR8TdR0KrWpkzJ
         gPT3JZIbKAXi/mlFCN5UcIkOGxs7SatCNgurc8yRLnM2v6exec2G+Tb8j5TL8CjyIiBq
         Wv+SE6yl7eSdiyVBovPrNeG5Eay3vEbiLVuCN/q1CYJwIXVJDOJYDHGxhKHbPlE0Oeqb
         4Pqe+MJQ53cxCLRbFw2u8Vk/wiUhV9ThTIkVcw1nBlRH1DcqV0VlvAzxBWMy3FPJH7ng
         v3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tx3EF+mpctamvq8xqT3tsby9Vr66NN6OwrKWOFPhhxw=;
        b=QFLWbFlA16ab100HI3qTKfHTSQVzVA/XBXTaSL5Py/4YZsmX2aRDg5nksFnkcts9Cn
         T26dxkIJDBwR3rvLujJMuSQy2SNslm9iy8bsG9xSXEHegKU3ukjFopxx2urU6WzcdQpb
         oEGQCbFdF5w8fb42rMWD/Xe5xw5dEi1yAynMWh0KOOPSDTjB2MdYdbFdcOYm6KJZQUPA
         L6V8aqfVRBoLbfNGgU8CP/DXUse02fLdWp8TfUpP91lQOBQkRIy8uXQN7I7aPi4n5N/u
         hEqemwvN8qLRX4sk8cfdHmvicxYF1BzVl7HynMbfbNtJXY1XXria4TqLvZoDQ9S8zLnb
         EL2g==
X-Gm-Message-State: AN3rC/4RUPiZMIUXllZAzrcnRy3S3wW6Y80/flA0jm5AVi3URIUgq4Xl
        7z6HdHJqozQBggVrl1anM0I3lzqbvA==
X-Received: by 10.36.82.144 with SMTP id d138mr11522496itb.24.1491821986865;
 Mon, 10 Apr 2017 03:59:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 10 Apr 2017 03:59:26 -0700 (PDT)
In-Reply-To: <3b793b18-7911-1859-e54d-8817f9c97a78@update.uu.se>
References: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
 <CACBZZX5jD0AhqZ8ucdicW=6s3=HPfpPeyne6jSVbZKnQ+sRZkQ@mail.gmail.com> <3b793b18-7911-1859-e54d-8817f9c97a78@update.uu.se>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 10 Apr 2017 12:59:26 +0200
Message-ID: <CACBZZX6bup33aBErxaAc6v=2zTEWGfXB8WtD4qt9boFOH=XWAA@mail.gmail.com>
Subject: Re: Git documentation on branching.
To:     =?UTF-8?Q?Samuel_=C3=85slund?= <samuel@update.uu.se>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 12:45 PM, Samuel =C3=85slund <samuel@update.uu.se> =
wrote:
> On 17/4/10 12:21, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Mon, Apr 10, 2017 at 8:56 AM, Samuel =C3=85slund <samuel@update.uu.se=
>
>> wrote:
>>>
>>> Hi all.
>>>
>>> I just started playing around with branching in git.
>>> I have been using it more or less as Subversion until now.
>>>
>>> One feature with "git branch xyz" and "git checkout xyz" that is rather
>>> obvious if you know them but bit me a little since I did not, is that
>>> uncommitted work in progress is not affected or saved when switching
>>> between
>>> branches. Thus I cleaned up the directory when working with the branch
>>> and
>>> now I'm trying to find a stash where I hopefully have a copy of those
>>> files.
>>>
>>> Would it be possible to add something in the documentation to warn othe=
rs
>>> that uncommitted work is not saved or affected by branching?
>>
>>
>> The main UI in git for switching branches is "git checkout", and it's
>> mentioned in the second paragraph of the documentation:
>>
>> "[when switching branches] local modifications to the files in the
>> working tree are kept, so that they can be committed to the
>> <branch>.".
>>
>> Did you read this and find it unclear, and if so can you elaborate on
>> what the confusion was, maybe we can fix the docs with that in mind?
>>
>> Or did you read some entirely different docs (what docs?) where we're
>> perhaps not mentioning this as prominently?
>
>
> No, I did not read the git checkout manpage.
> When I googled "git branch" I got the two pages mentioned below and this
> one:
> Git - Basic Branching and Merging
> https://git-scm.com/.../Git-Branching-Basic-Branching-and-Mer...

This list doesn't maintain that book, it looks like the right place to
file bugs & improvement suggestions in it is
https://github.com/progit/progit2

It might be an issue with the git-scm site though that issues in the
book aren't funneled there instead of here. How did you go from
noticing an issue in the book to contacting this mailing list? Maybe
we need to update some page involved in that.

> I find that mostly manpages require some context before they are useful s=
o I
> go for the more wordy pages when trying to get my head around something n=
ew.
> Neither of the three top-hits on google included the local modifications
> comment where I noticed it. An actual search for that string right now do=
es
> not find anything either.

Yeah but unfortunately we can do little about that stuff, we just
maintain the man pages.

> The comment you refer to in the git checkout man-page is probably enough
> heads-up for someone who knows git reasonably well, I do not know if it
> would have made me realize exactly how the feature works.
> I'm not even sure I know how "local modifications" is defined in Git
> terminology, does it include "(un)staged changes", and or untracked files=
?

Maybe we should say "uncommitted modifications" there. I think
starting to talk about staged & unstaged might just invite similar
confusion.

It's hard to say anything in these docs without being inaccurate or
losing the audience :(

> Thanks for the attention.
>
>
>>> The first two hits on my google search was very informative about
>>> branching
>>> but I did not see that specific nugget of information (I might have bee=
n
>>> careless reading, but if I did not see it others will probably also mis=
s
>>> it).
>>>
>>> Git - git-branch Documentation
>>> https://git-scm.com/docs/git-branch
>>>
>>> Git - Branches in a Nutshell
>>> https://git-scm.com/book/.../Git-Branching-Branches-in-a-Nutsh...
>>>
>>> This is my first try to contribute to the Git community, I hope it will
>>> be
>>> useful to somebody.
>>>
>>> Regards,
>>> //Samuel
>
>
