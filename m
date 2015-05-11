From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Mon, 11 May 2015 11:28:24 -0700
Message-ID: <CAGZ79kZwjpxP0mDt8YRvvhsOsTfzjNbMFUPwUBfBr-uKaghQTw@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
	<20150511181719.GB18112@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Mon May 11 20:28:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrsRS-0003Bf-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbbEKS22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:28:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35779 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782AbbEKS2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:28:24 -0400
Received: by ieczm2 with SMTP id zm2so115437610iec.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9X34f1VMJEVTBu6e5uYQPhBLRbcDgnL8VjYySqR6ki4=;
        b=g89gK3TMS3QGVg6qw9KR9iqn47Vhu5qhx1qbk+5HLMhHfxSr4IuOYoUtzt1RWjVEOp
         JxNue3AvprtQ0aXt5q4yxK1eK28uKK8VKovZQa4UVq9Pjxsplk4eRwUqKvjmZfzdifjs
         6haO6chcd5/sn5VKc5mV/noNk9GmqLBuOxiiVIvHRyLrOlY5I6HnzyFyeh7LSgauT3q5
         lYXA2opQjUUdNXly8Q8ktz1gDW1kSGYuue4eOKIBwrlQS1jdc51teXW2wbSvnaROxUZc
         nakj30MhMMnZ40HfWWZ+lQFrSiu83t3+pCmDBMWiBw3CJKs+j+/22y+dpy1NXZVVg+A0
         LEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9X34f1VMJEVTBu6e5uYQPhBLRbcDgnL8VjYySqR6ki4=;
        b=PLf6NXxR3sPGlis3zi5WVa7hoqhZZnARY/yvJVW9E30V1onig0ID3X4qb1nE8Cgkf+
         mNUonwZKQIMq9S4O8NhSCKPuiCfEBAKwaYuZPBtVmxcC9kOsXjsxZXUWOcAXvWZuBphE
         O18rVMlftoqB0QP2ZNSy0pM3oZBkx6apHvFfaM+gbaeKJJJwH80DbPmiBTrT85Ruy3UV
         eKSjs5iK92FBBLl+vquGM7NcqYMe8V+XYM5MEYxGUEQ/HWvgPMRnHQq6ZQSZLYMtjGVH
         NzASFC/mRkhJ3t5Z4Ta70CtfICXAQyAc0vEyrv/vaL3baDCoA2lHKWY31qsS3jfLPcLs
         Dxxw==
X-Gm-Message-State: ALoCoQkgboodeyjb1342/TkNIyAqxFXpp/rtRZ2MDCT16owxIV9U2DksRmDfKeoqgDBsQ5+aZFeS
X-Received: by 10.50.143.97 with SMTP id sd1mr16009956igb.25.1431368904192;
 Mon, 11 May 2015 11:28:24 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 11:28:24 -0700 (PDT)
In-Reply-To: <20150511181719.GB18112@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268814>

On Mon, May 11, 2015 at 11:17 AM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> On Mon, May 11, 2015 at 09:54:15AM -0700, Junio C Hamano wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > On Mon, May 11, 2015 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Jeff King <peff@peff.net> writes:
>> >>
>> >>> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
>> >>> line from bisect.c:show_diff_tree), but that is mostly my personal
>> >>> opinion.
>> >>
>> >> Yeah, I think that is sensible. It may even be OK to just give a
>> >> "log --oneline".
>> >
>> > Or maybe we could let the user configure the diff options or even the
>> > command used when the first bad commit is found?
>>
>> That is a separate discussion.  I do not mind but I doubt many
>> people would use it (I was tempted to say "doubt anybody would", but
>> then was reminded how many people use Git, and toned it down), as
>> long as we have a good default.  And I thought that this discussion
>> was about coming up with a good-enough default.
>
> agreed
>
>> To be bluntly honest, I think the current one is sufficient as a
>> good-enough default.  The first thing I would do after seeing that
>> message is to either "git checkout <commit-object-name>" or "git
>> show <commit-object-name>", and the current full 40-hex output gives
>> me an easier mouse-double-click target than the proposed abbreviated
>> one, so in that sense the original proposal may even be a usability
>> regression.
>
> I think printing the full 40 chars once is reasonable, but twice in 2
> lines seems a bit excessive.  I was thinking of changing the format to
> be
>
> the first bad commit is
> $(git log -1 <bad sha1>)
>
>> It is tempting to say that the output can be eliminated by always
>> checking out the first-bad-commit (i.e. only when the last answer
>> that led to the first-bad decision was "good", do a "git checkout"
>> of that bad commit), but in a project where a branch switching is
>> not instantaneous, that might be problematic (unless the first step
>> the user would have done is to check it out anyway, of course).
>
> Well,  if you just finished bisecting you are probably on a commit close
> to the first bad one so it probably will be fast.  However I don't
> really like that idea because what I generally want to do is read the
> patch so having the hash printed so I can copy it and run git show -p
> $hash or something is nice.  Though I guess if the first bad commit is
> checked out you can just skip the copy paste and use HEAD.

Only if you are operating within your local repository only. If you want
to check a build bot or another database for continuous builds or anything
outside your local repository you need the hash and not HEAD.
So I'd think

    the first bad commit is
    $(git log -1 <bad sha1>)

is fine.

>
> Trev
>
