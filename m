From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sun, 8 Sep 2013 04:27:50 -0500
Message-ID: <CAMP44s2ANuLL_gPrn8Od3nwQimd+JQASW4wF-xVJRF0eA+WkRA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
	<CAMP44s1j+ayX=cy7QJ7WXdiD9P1M6n7NgNk=oGuv1XC=dqMXVA@mail.gmail.com>
	<B771340AAC04409CB0EF716FE6FC1C88@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Drew Northup <n1xim.email@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 11:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIbHi-0002uL-Vf
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 11:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab3IHJ1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 05:27:53 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58391 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3IHJ1w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 05:27:52 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4139945lbi.11
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QJa+t1EYTl1vpnDQHfkwELlSRcjxCALZ0J3TP+KJ1CM=;
        b=jI6JWaRduQAGEVlRYD/s/wJa9H4fUSVKx/AOdv72RpPKuay+kFeeWDmeXwx8Km1hvd
         88bB5AjXDR2kX8t5R/LIrpYLOPanpmmHmf62ApRB4Qd0siil5PSNH+Y8qF7c59N/ssK4
         qmNiWDoDmkMQxUeqe/8b1q2kG2b9jNzgfCFqaYwDyOO7p2Fa8aM2dD5ox5+ttwJea3U6
         B6uEyWNAB/1jNJoinxoiivFE3mtAjp7iARRdgxp0wT5cWdHOfphp+29mg08FRv7pZmFm
         QkhQn0eewzOL5zevslo0ai95HyjDF3mdXo55Ng+4h2/ZIt37Zi47rPhnR+19ly3Yh6UJ
         ocjQ==
X-Received: by 10.112.155.39 with SMTP id vt7mr647926lbb.29.1378632470409;
 Sun, 08 Sep 2013 02:27:50 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 02:27:50 -0700 (PDT)
In-Reply-To: <B771340AAC04409CB0EF716FE6FC1C88@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234231>

On Sun, Sep 8, 2013 at 2:49 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Sunday, September 08, 2013 2:33 AM
> [snip...]
>
>> The snapshot concept is totally orthogonal from the staging area
>> concept. Git works in snapshots, which are frozen images of how the
>> content tree was at a certain point in time; IOW; a commit.
>
>
> (I feel that) In most peoples minds the need for a staging area, and the use
> of snapshots, are related. Part of that relationship, often not noticed by
> those folks, is that they are 'orthogonal' to *each other*. Thus
> orthogonality means both un-related, and related at the same time (aren't we
> humans peculiar!). They are cleaved to each other.

Not really. You can argue that a movie is a sequence of snapshots, 24
of them per second, but most people don't think of it that way. You
can also argue that every change you do on a file is a snapshot, but
again, people don't think of it that way. Yes, you can argue that the
index is a snapshot, but it doesn't help to think of it that way. And
if you try to argue that way, then every waking moment is a snapshot,
what is NOT a snapshot?

The useful concept of snapshot is a moment in time stored for
posterity, in that sense a photo is a snapshot, a backup is a
snapshot, and a commit is a snapshot, but the staging area is not,
because it will be gone.

In fact, I just thought of another concept; a draft.

> When trying to explain staging/index I tend to use the analogy of an old
> style office (I am almost that old) where one has an In tray and an Out tray
> on one's desk (and one parked WIP for lunch time desk tidy), and the staging
> area is the basket at the end marked 'For Filing'. When the 'For Filing'
> basket is ready, one called the filing clerk to dictate the cover note and
> away it went, commited to some remote filing repository. Oh how things have
> changed ;-)

But that doesn't work well. You didn't add and remove things for the
'For Filing' as you worked, did you? Even if it did work, I don't
think it would be particularly useful to most people today.

I think a much more fitting analogy is a mail draft; you add and
remove things, change them, review, you can take as much time as you
want, and at the end of the day you can discard the whole thing.
Nothing gets done until you press 'send', which is analogous to
'commit'.

>> _How_ that snapshot is created is an entirely different topic, and the
>> staging area is a tool to create the desired snapshots. The user might
>> decide to never use that tool (i.e. always run git commit -a), but the
>> concept of snapshots remain. So, clearly, one concept has absolutely
>> nothing to do with the other.
>>
>
> The point would be that we allow a particular snapshot to be selected, and
> that the git commit -a is but one (common) method. Commit -a is like jumping
> in the car for a quick trip to the shops, while the selective staging of
> content is like packing for a holiday.

I still don't see it. When you do 'git commit' you don't have an array
of snapshots to choose from, you just have one, and it's not
particularly static, as you can add and remove things from it, so it's
not really a snapshot of your working directory even, because you can
add things that where never there.

And then if the staging area is a snapshot, then what is a commit?
Another snapshot? Then what is the difference between the two? One is
permanent and the other temporary? Well, then saying "snapshot"
wouldn't be enough to describe the staging area, you would need to say
"preliminary snapshot", which doesn't really make sense, as those are
called previews, not snapshots. But why bother with "snapshot", we can
use "preliminary commit". But again, it sounds weird using the word
commit to something that can and is meant to change, unlike git
commits, and incidentally, unlike snapshots.

-- 
Felipe Contreras
