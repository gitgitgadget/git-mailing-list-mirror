From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: cherry picking and merge
Date: Wed, 06 Aug 2014 17:43:03 +0200
Message-ID: <53E24D07.9010105@gmail.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net> <20140801024329.GA28914@vauxhall.crustytoothpaste.net> <53DBBFE8.8060607@gmail.com> <5AF18A76-DD3B-4B9A-BF70-EFE4BB852C3D@comcast.net> <CANQwDwc4YPdK+a0Oc-jWPTRyM5GiP-CMuRY1inxJY41GwUGBvQ@mail.gmail.com> <CANQwDwdKbmqLSLGsiyHTfGNZGfbeNZM3TN6Zk0G5G-8twRc_JQ@mail.gmail.com> <13DDD21A-F683-4116-9E07-F0D8AEF06A66@comcast.net> <40F24BA38E03454A9BA152F6AFDE56C4@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>,
	Mike Stump <mikestump@comcast.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:43:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF3N2-0002dc-C1
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 17:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbaHFPnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 11:43:16 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:40135 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbaHFPnP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 11:43:15 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so2730794wgh.6
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=xNGDI5EVl8lwSdnz0yZ04iORA/XOv7iNDFx0UBO2PcM=;
        b=CASXhw+h7Zb4ZRr0QLTUpj/ah4npudsQmFV/CT3spuhCwniXD/O4gL2d91v5hMZHRh
         g2Mc2Ibo4MIDNYQi6PacwKDh6yQllbkvxQ487Gzl5yJ9txxlxjvcPdm7W2XIa6JYbOiF
         ghoWIO7TNUp1/DWAhnsAnKugIG0CKvzYDeXPR2jtgQllKVgbdx/gvVPCwniCTe1dzgQa
         8UPwhR9mYtoSWKFXrg715vF25hk0cCiXm3HTAURZvPM4kAcPVrvWE37IovPHViFWXh2H
         Rv7Xb/BQhx9RkJnLlSdqawS7u0QyJzQaTb7mODppM6BAAkPVQO3BK9s6uoBpS5SmsHeL
         VYZg==
X-Received: by 10.180.12.79 with SMTP id w15mr18166638wib.35.1407339793789;
        Wed, 06 Aug 2014 08:43:13 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id do6sm7236557wib.22.2014.08.06.08.43.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 08:43:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <40F24BA38E03454A9BA152F6AFDE56C4@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254869>

Philip Oakley wrote:
> From: "Mike Stump" <mikestump@comcast.net>
> Sent: Friday, August 01, 2014 11:24 PM
>> On Aug 1, 2014, at 12:01 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:

>>> It can work in Subversion because Subversion stores information abo=
ut
>>> what was merged in (and this includes cherry-picks, or whatever it =
is
>>> named in svn) in svn:mergeinfo property. Git does not track what wa=
s
>>> merged in, instead it represent the history as the graph of revisio=
ns,
>>> and tracks merges (by storing that it came from two or more commits=
)
>>> and not merged-in information.
>>
>> So, as a dumb user that just wants it to work, I am unsympathetic to
>> the `but software is hard=E2=80=99 excuse.  I am aware that some bug=
s are
>> harder to fix than others.  svn took a long time to fix this bug, bu=
t
>> they did.  I can wait, the only question is, will it be a week, a
>> month, a year, or a decade.

Here Git and Subversion went in different directions, and use
different mechanisms (merge tracking vs merged-on tracking).
Both have their advantages and disadvantages.

git-merge (in the most usual case) depends only on three revisions:
the revision you merge into (current branch, ours), the revision
you are merging (merged branch, theirs), and merge base (common
ancestor).  We could have another merge strategy that examines
contents of revisions to handle cherry-picks and reverts... but
it would be more complicated, and much slower.

>>> When merging Git uses only what is being merged and its common
>>> ancestor (3-point merge). It is simple, and simple works!!!
>>
>> I gave a solution for git using branches and it works just fine.  It
>> retains the simple 3-point merge as well.

It works for this simple case, but I think it has unfortunate potential
to go silently wrong.

Also, it prevents fully removing (commits, not only refs) the branch
you cherry-picked from.  The commit you cherry picked may no longer
be (or may no longer should be) in the repository.

> At the moment there is no formal way for Git to record within the com=
mit
> metadata the inclusion of the cherry-picked diff (the 'merge' of the =
fix).
>
> Thinking out of the box, the issue is that the commit parents list do=
es
> not have a formal mechanism to allow the recording that the 'merged'
> change was the patch change from a specific commit fom somewhere else
> (which may be missing from the local repo).
>
> Perhaps it needs a style of merging-rebase where a second (last) pare=
nt
> is added but it isn't the straight <sha1>, but says 'patch-<sha1>', s=
uch
> that readers with the capability could check if that <sha1> history i=
s
> present locally, and if so if it's correct, so that you can now 'trac=
k'
> your fixes between releases, and (hopefully) older Gits don't barf on
> that extra 'fake' parent. Somehow I suspect that older Git's would
> barf.. (not enough time to create and test such a fake commit).

Sometime ago there was long discussion about adding 'weak' references
to commit object header.

Beside the problem of backward compatibility, there was also the proble=
m
of semantics of said reference - what does it mean?  It should work as
well for cherry-picks, for interactive rebase (maybe?), and for reverts
(which are also a problem).

Also, this could be avoided by using feature branches and merging
instead of committing to one branch and cherry-picking to other
branches. Also, git-rerere is your friend... sometimes.

>>> Have you tried git-imerge?
>>
>> No, not yet.  I=E2=80=99m not as interested in using it, as I would =
like git
>> itself to just work.

Maybe this command would make it into git proper, though probably
not written in Python (there was once merge strategy written in Python,
but currently git does not depend on Python).

--=20
Jakub Nar=C4=99bski
