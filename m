From: Elliott Cable <me@ell.io>
Subject: Re: [PATCH/RFC] rev-list: add --authorship-order alternative ordering
Date: Thu, 6 Jun 2013 15:03:13 -0400
Message-ID: <CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:03:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkfSx-0007r6-NN
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412Ab3FFTDP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 15:03:15 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:37841 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab3FFTDO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 15:03:14 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so2571131oag.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FZhRrpnFmgpZ6nnuvDSvrex66QfruJVNT0am3/C1xjg=;
        b=ihF+VtFk22cXWDJuh3rTAZy/rCdoTxrN3XF09KbfAYoWSHXG6WaWwt6mNNbnaci/Rp
         c6PQQyY5FojK4lxDqMJqGV0AgilQdCNcnlYzZrRUFz6yUy4pG/eelR/kIzaUcCRUnB3B
         WfDZsIEjCRGtys0J9RBOaBMKfmZ/8M96K5kak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=FZhRrpnFmgpZ6nnuvDSvrex66QfruJVNT0am3/C1xjg=;
        b=ipImQpQfi2/Jh1Euv4/J3AQnuZbIpWqIH9zpRgtvnjoemRyFIkEIWXrSixLBvFOBiR
         gWhuERVbR3JghGIUcFEcCZ2268YfUtH1M4TPgR70TW7tDYa3agRGwBXvIoeFIi0USVTk
         xWrZBmpZpUTNpTiyEdY5emBhvY9GTU7KHxXgu74ezT4A/LXtcEZ/5pL7ih86jqet+OJU
         JdCWwDmjbfOrRESA5pOQqJwIpWLepet5JofddnNZa8iA/J9YxoZGdQ0zIzWkzMBYqJGL
         fm6oGpjNYY5XXqyrHzVjPwiGgejPrNgya4YsUgORL/vx0RYUsIARcBVU8aBPPhd2uR8R
         o+hg==
X-Received: by 10.60.55.97 with SMTP id r1mr19044127oep.85.1370545393558; Thu,
 06 Jun 2013 12:03:13 -0700 (PDT)
Received: by 10.60.28.194 with HTTP; Thu, 6 Jun 2013 12:03:13 -0700 (PDT)
X-Originating-IP: [70.197.160.229]
In-Reply-To: <7vobbl60aj.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmpj/PdyhpGY+a0hbXVTTx1QT18ntXDcHV1vTW08hXmqes4akD/jBrscF7LrmAMoDH8hIuk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226528>

On Tue, Jun 4, 2013 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> elliottcable <me@ell.io> writes:
>> Thus, I've added an --authorship-order version of --date-order, whic=
h relies
>> upon the AUTHOR_DATE instead of the COMMITTER_DATE; this means that =
old commits
>> will continue to show up chronologically in-order despite rebasing.
>> ---
>
> Missing sign-off.  Please see Documentation/SubmittingPatches.

Will-do.

I read that part, and was rather confused. At no point did I get the
idea that I should sign-off *my own initial commit*. Perhaps that part
of the documentation needs to be slightly re-written? Would that be a
welcome change?

On Tue, Jun 4, 2013 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> elliottcable <me@ell.io> writes:
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 9e21232..54d4d7f 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -237,7 +237,7 @@ static void log_show_early(struct rev_info *revs=
, struct commit_list *list)
>>       int i =3D revs->early_output;
>>       int show_header =3D 1;
>>
>> -     sort_in_topological_order(&list, revs->lifo);
>> +     sort_in_topological_order(&list, revs->lifo, revs->use_author)=
;
>
> The name "use-author" is a clear sign that the person who added this
> code were too narrowly focused to think "author" automatically would
> mean "author date" ;-).
>
> It probably makes sense to revamp sort_in_topological_order(), so
> that its second parameter is not a boolean 'lifo' that tells too
> much about its implementation without telling what it actually
> means.  Instead, we can make it an enum sort_order, that tells it to
> emit the commits in committer-date order, author-date order, or
> graph-traversal order.
>
> And update revs->lifo to use that same enum, without adding
> use_author_date bit to rev_info.

I'll look into replacing lifo with an enum as soon as I can sit back
down to update this patch. For the moment, nothing more than
committer_date_sort and author_date_sort, I suppose?

Overview being, I suppose, that `lifo` will no longer exist (since it
effectively determines, when truthy, that we operate in a
*non*-date-ordered topological method); then have commiter_date_order
and author_date_order bits in an enum, with zero being
lifo/straightforward-topological-order. Sound about right?

I'll try and make this a separate patch. First commit, to replace lifo
with an enum; second commit, to *actually implement* the code obeying
that enum when it is set to author_date_order.

On Tue, Jun 4, 2013 at 5:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 04, 2013 at 12:14:21PM -0700, Junio C Hamano wrote:
>
>> > diff --git a/commit.h b/commit.h
>> > index 67bd509..de07525 100644
>> > --- a/commit.h
>> > +++ b/commit.h
>> > @@ -17,6 +17,7 @@ struct commit {
>> >     void *util;
>> >     unsigned int indegree;
>> >     unsigned long date;
>> > +   unsigned long author_date;
>>
>> While walking we keep many of them in-core, and 8-byte each for each
>> commit objects add up.  We do not want to make "struct commit" any
>> larger than it already is.
>>
>> Having said that, I do not see a reasonable alternative
>> implementation than adding an author-date field to struct commit
>> without major restructuring if we were to add this feature.
>>
>> So please do not take this part of the response as a "patch rejected
>> because we do not want to add anything to this structure".  We'll
>> think of something down the road, but as an independent topic after
>> this gets in (or doesn't).
>
> Yeah, I had the same thought. Maybe this is a good candidate to build=
 on
> top of the jk/commit-info slab experiment. The topo-sort could alloca=
te
> an extra slab for author-date (or even expand the indegree slab to ho=
ld
> both indegree and author date), use it during the sort, and then free=
 it
> afterwards.
>
> Elliott: you can see the relevant changes to the topo-sort in commit
> 96c4f4a (commit: allow associating auxiliary info on-demand,
> 2013-04-09).
>
> -Peff

Again, might be a little over my head. If you really think it's best
that I look into that branch, I will try. :)

Meantime, is there any other, more-immediate approach you can think
of? I thought, for a moment, of only storing *either* the committer
*or* the author date in the commit-struct at a given time, and
flagging with a single bit ... but I'm not sure how widely-spread the
nead for committer-date currently is. Maybe I can go back and
parse-out the author date *when I need it*, instead, though that
sounds slow =E2=80=A6

Epilogue: I'll make the *obvious* changes mentioned above sometime
within the next week (I'm more than a little swamped; in the middle of
a big breakup, and a big move, simultaneously! :( ), especially the
enum instead of the use_author bit =E2=80=A6 and submit another patch R=
=46C. It
won't be finalized until we can decide what to do about the extra
8bytes in the commit struct, though. More input welcome.
