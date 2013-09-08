From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Sat, 7 Sep 2013 20:33:03 -0500
Message-ID: <CAMP44s1j+ayX=cy7QJ7WXdiD9P1M6n7NgNk=oGuv1XC=dqMXVA@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 03:33:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VITsG-0006qs-B6
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 03:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab3IHBdH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 21:33:07 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:39648 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab3IHBdG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Sep 2013 21:33:06 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so3964249lab.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=M7zqsYMeT9gqwzs1CYsfgpF1QqIkoUUbc3U+s6YxbRc=;
        b=zQ1LGygKoN0lAmJpIevGTbm3wkDSZPmWJrTnR9wIEDcGQGbwsc3X9DfnnDawguHEMY
         6MqEXSjvLKDWrS3VVt4OpDFBn2UUR9lxxo056grs+lQNS30zvI0HceeJGzlie3gU0arM
         dAItN630DonEOYZ57Xydpip2beaj5d7ioasAeYQZ3VjAkTUP7rhA+Uw3woK3ygqwpBAs
         qUB2802xGnJjEOH9ftp3QiKVs7oLOzgXIKYQ2d+7HmhLVcF3Cd95YJsZu4soXFQCzVd8
         E++MKaOh9M5WZ7bkIfBpTpQPHArU3R/QeHK69H2Wq1Xpnse0amSpPu6uDYgaFYt4SeiU
         WspQ==
X-Received: by 10.112.64.36 with SMTP id l4mr9544166lbs.15.1378603983954; Sat,
 07 Sep 2013 18:33:03 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 18:33:03 -0700 (PDT)
In-Reply-To: <CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234159>

On Tue, Sep 3, 2013 at 11:23 PM, Drew Northup <n1xim.email@gmail.com> w=
rote:
> On Fri, Aug 30, 2013 at 1:16 AM, Piotr Krukowiecki
> <piotr.krukowiecki@gmail.com> wrote:
>> Drew Northup <n1xim.email@gmail.com> napisa=C5=82:
>>>I agree with Junio. This effort is better spent making the
>>>documentation clearer and more succinct. The reality is that a user
>>>needs to build a model in their mind of what they are doing which ma=
ps
>>>enough (completely is not required) to what is actually going on to
>>>get work done. If the documentation or the instruction is getting in
>>>the way of that in the name of simplifying the presentation then the
>>>presentation is wrong.
>>
>> Why do you think the "stage"  model do not map enough?
>
> When I try to explain how to use git to complete VCS newbies in
> general they find the "snapshot" model more mentally sensible than th=
e
> "staging area" model. (In other words, the user doesn't care how, if,
> or where the program is maintaining state.)

The snapshot concept is totally orthogonal from the staging area
concept. Git works in snapshots, which are frozen images of how the
content tree was at a certain point in time; IOW; a commit.

_How_ that snapshot is created is an entirely different topic, and the
staging area is a tool to create the desired snapshots. The user might
decide to never use that tool (i.e. always run git commit -a), but the
concept of snapshots remain. So, clearly, one concept has absolutely
nothing to do with the other.

>>>We add content snapshots to the index of content (creating
>>>"temporary"--they will be garbage collected eventually if they becom=
e
>>>orphans--objects into the store at the same time). We build commits
>>>from those snapshots (in whole or in part, typically only using the
>>>most recent snapshots of new things added to the index) and save tho=
se
>>>in the object store with the content and tree objects. Sometimes we
>>>create tag objects to record something special about commits, trees,
>>>and content blobs.
>>
>> The above can be rewritten to use the 'staging area' concept just
>> fine. And I don't think you should say to inexperienced users things
>> like 'tree objects'.
>
> At what time did I say specifically what I tell newbies? I did not do
> so. Please refrain from making that sort of assumption. In any case,
> no, you cannot rewrite that to use "staging area" in place of "index"
> without introducing a different mental model and new concept into the
> text (a model which happens to be incomplete, but not incorrect). Tha=
t
> minimalist summary was written for the technically-minded people here
> on this list debating the issue of communications with the users--the
> bane of all programmers' lives.

You are mixing useful mental models for the majority of Git users, and
technical implementation details.

You say what you wrote is for technically-minded people, and those
people are not relevant for this discussion, because we are not
talking about the implementation details, we are talking about the
vast majority of Git users, so stop with the red herrings.

The "mental model" of staging area is an area that is used for
preparation for something, and that's *exactly* what the vast majority
of users think of the index as a high-level concept.

> Again, let us keep our argument focused on communications with users.
> Renaming core objects is just going to sow confusion without fixing
> the user communication issue. That's what I meant the first time I
> wrote what I quote directly above and I'm sticking to it.

The vast majority of Git users have absolutely no clue about what's
the index. That's why online documentation uses the term "staging
area", so in fact we would be reducing confusion, by a lot.

--=20
=46elipe Contreras
