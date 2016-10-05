Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DD3207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbcJEKnD (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:43:03 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38123 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752319AbcJEKnC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:43:02 -0400
Received: by mail-it0-f51.google.com with SMTP id o19so165284719ito.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRo2DA8lTRPyDo60dHVnsF+1fx5a7etXjm9US1CYFRE=;
        b=Q5vfWILpAML82W+MUNHW+XmjtaKcmk6g1rc0iffOD01MP3fPQ5ZepPQQZg4Xwpc7lv
         T2GVfdz+kXychharaRUVlTPMfCqsh0OLvyW1iO6dcqol0iT2uav+i4c4PHG9mujzeyYw
         IV7FlwKaII9vRiCzwtjZ2VSh4bL95UxjjRjcrnieQPj5tfPLP8JJMhDEltnXR4pwpRmQ
         tmzK8/Md5jYM9YsHEmo/Ya1KyUySa0k+OpSSZGZt8AXcClyRhcLZjvS1trCyy5vqL79w
         jBtetyU+4FaUuEStRFmI7na//0PxNADQeSsNIzf3AO0sNkzXqAr2/DF0OfOxz5udc+dh
         xUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRo2DA8lTRPyDo60dHVnsF+1fx5a7etXjm9US1CYFRE=;
        b=V9acN8ZCivdmT7DewZtXb2Ik9mBlu1tfx3Ss9igHkne8/NZ4ifxsHrfDBXiSDX3CFk
         8QtTn5FSsbhKcW0dxSnCCMKEtZGCVPkEvIgrUKaSdnl7yiFMrtPnZt+Ag68EmJtW1hO5
         crzrIMhTdQmcKtOi42DwwPQvBYwIQQBLCXzR3ZD2b+fJJ+9MzdlT6sjgrjM9BCwc8S1O
         0zA99FzK7QU5tgRtJtZCRstVgdoyEXLDgs3saGZ8yVMNNzJi9twQI7Ujl3gUXEJqZtTd
         /3rIpNJYW3FexRNOxI9c7THtrltCZpiQ+jbTiuZuG9Uy9FQwB97jeal0MB9LexHbts79
         E68A==
X-Gm-Message-State: AA6/9Rns6tyfv559Mrz13CX8hE1nDniNLbaaBKZpyGHhSZHGwO3r4/tn+QcWX0su5dphLgRxw9RrYrIwsuj+Vg==
X-Received: by 10.107.59.6 with SMTP id i6mr5748019ioa.176.1475664181140; Wed,
 05 Oct 2016 03:43:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Wed, 5 Oct 2016 03:42:30 -0700 (PDT)
In-Reply-To: <CANQwDwcj15bk3uvjqnOwqqLFN_qOZCoWATssNBwD4kDTDfS6Hw@mail.gmail.com>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com> <CAKbZu+BUOAjixTmEC4octseyJbMnFuaCTtLT9hx3H10=AECeKw@mail.gmail.com>
 <CANQwDwcj15bk3uvjqnOwqqLFN_qOZCoWATssNBwD4kDTDfS6Hw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Oct 2016 17:42:30 +0700
Message-ID: <CACsJy8A8QGAtmv0BGOb2ZgXP=_iXz-oDZ82ebq+gmRe7TWoWBQ@mail.gmail.com>
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research paper)
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Santiago Perez De Rosso <sperezde@csail.mit.edu>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        git <git@vger.kernel.org>, Daniel Jackson <dnj@mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 5, 2016 at 5:14 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
> [git@vger.kernel.org does not accept HTML emails]
>
> I just hope that this email don't get mangled too much...
>
> On 5 October 2016 at 04:55, Santiago Perez De Rosso
> <sperezde@csail.mit.edu> wrote:
>> On Fri, Sep 30, 2016 at 6:25 PM Jakub Nar=C4=99bski <jnareb@gmail.com> w=
rote:
>>> W dniu 30.09.2016 o 18:14, Konstantin Khomoutov pisze:
>>>
>>>> The "It Will Never Work in Theory" blog has just posted a summary of a
>>>> study which tried to identify shortcomings in the design of Git.
>>>>
>>>> In the hope it might be interesting, I post this summary here.
>>>> URL: http://neverworkintheory.org/2016/09/30/rethinking-git.html
>>>
>>> I will comment on the article itself, not just on the summary.
>>>
>>> | 2.2 Git
>>> [...]
>>> | But tracked files cannot be ignored; to ignore a tracked file
>>> | one has to mark it as =E2=80=9Cassume unchanged.=E2=80=9D This =E2=80=
=9Cassume
>>> | unchanged=E2=80=9D file will not be recognized by add; to make it
>>> | tracked again this marking has to be removed.
>>>
>>> WRONG!  Git has tracked files, untracked unignored files, and
>>> untracked ignored files (mostly considered unimportant).
>>>
>>> The "assume unchanged" bit is _performance_ optimization. It is not,
>>> and cannot be a 'ignore tracked files' bit - here lies lost work!!!
>>> You can use (imperfectly) "prefer worktree" bit hack instead.
>>>
>>> You can say, if 'ignoring change to tracked files' is motivation,
>>> or purpose, it lacks direct concept.
>>
>>
>> I don't see what's wrong with the paragraph you mention. I am aware of t=
he
>> fact that assumed unchanged is intended to be used as a performance
>> optimization but that doesn't seem to be the way it is used in practice.
>> Users have appropriated the optimization and effectively turned into a
>> concept that serves the purpose of preventing the commit of a file. For
>> example:
>>
>> from http://gitready.com/intermediate/2009/02/18/temporarily-ignoring-fi=
les.html
>>
>>  So, to temporarily ignore changes in a certain file, run:
>>  git update-index --assume-unchanged <file>
>>  ...
>>
>> from http://stackoverflow.com/questions/17195861/undo-git-update-index-a=
ssume-unchanged-file
>>  The way you git ignore watching/tracking a particular dir/file.
>>  you just run this:
>>  git update-index --assume-unchanged <file>
>> ...
>>
>>
>> btw, this appropriation suggests that users want to be able to ignore
>> tracked files and they do what they can with what they are given (which
>> in this case means abusing the assumed unchanged bit).
>
> Yes, this is true that users may want to be able to ignore changes to
> tracked files (commit with dirty tree), but using `assume-unchanged` is
> wrong and dangerous solution.  Unfortunately the advice to use it is
> surprisingly pervasive.  I would thank you to not further this error.
> (Well, `skip-worktree` is newer, that's why it is lesser known, perhaps)
>
> To ignore tracked files you need to use `skip-worktree` bit.
>
> You can find the difference between `assume-unchanged` and
> `skip-worktree`, and when use which in:
> http://stackoverflow.com/questions/13630849/git-difference-between-assume=
-unchanged-and-skip-worktree
> http://fallengamer.livejournal.com/93321.html
> http://blog.stephan-partzsch.de/how-to-ignore-changes-in-tracked-files-wi=
th-git/
>
> The difference is that skip-worktree will not overwrite a file that is
> different from the version in the index, but assume-unchanged can.  This
> means that the latter can OVERWRITE YOUR PRECIOUS CHANGES!
>
> Some people started to recommend it
> http://stackoverflow.com/questions/32251037/ignore-changes-to-a-tracked-f=
ile
> http://www.virtuouscode.com/2011/05/20/keep-local-modifications-in-git-tr=
acked-files/

And since skip-worktree bits may be set/cleared freely when sparse
checkout mode is on, you should never manipulate these bits directly
if you also use sparse checkout.

>>> | *Detached Head* Suppose you are working on some branch
>>> | and realize that the last few commits you did are wrong, so
>>> | you decide to go back to an old commit to start over again.
>>> | You checkout that old commit and keep working creating
>>> | commits. You might be surprised to discover that these new
>>> | commits you=E2=80=99ve been working on belong to no branch at all.
>>> | To avoid losing them you need to create a new branch or reset
>>> | an existing one to point to the last commit.
>>>
>>> It would be hard to be surprised unless one is in habit of
>>> disregarding multi-line warning from Git... ;-)
>>
>> True if you are an expert user, but I can assure you novices will
>> find that situation baffling, even with the multi-line warnings.

Hmm...  when you switch away from a detached HEAD, you are advised to
do "git branch <new-name> blah blah". How is it baffling? Genuine
question, maybe I have been using git for too long I just fail to see
it.

> True, the "detached HEAD" case (aka "unnamed branch") can be puzzling
> for Git users, and it has few uses (e.g. checking out the state of
> tag temporarily, to test it).
>
> I wonder if `git status` should be enhanced to tell user how to get
> out of "detached HEAD" situation -- it has lots of advices in it.

Detached HEAD is also present in interactive rebase or any command
that has --abort/--continue options. I don't think we need to tell the
user to get out of detached HEAD in that case. Just two cents if
someone is going to add this advice to git-status.
--=20
Duy
