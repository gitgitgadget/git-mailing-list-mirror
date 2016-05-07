From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v16 0/7] config commit verbose
Date: Sat, 7 May 2016 21:28:53 +0200
Message-ID: <CACBZZX5FHBG8xXc4wKUyW90FianJB1PT2FyByqYVqccb2ef2eg@mail.gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
 <1462441802-4768-1-git-send-email-pranit.bauva@gmail.com> <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <CAPig+cQO3W4WthHstrVFWziU2RAuNyEzeQwBEyDXG8dghRjECQ@mail.gmail.com>
 <20160506162058.Horde.toAFyoD2uVNcv2x2Ssx_9zt@webmail.informatik.kit.edu>
 <xmqqshxv5hhg.fsf@gitster.mtv.corp.google.com> <20160507053209.GA1704@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 21:29:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az7uh-0000yL-Q8
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 21:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbcEGT3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 15:29:14 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36304 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbcEGT3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 15:29:13 -0400
Received: by mail-qg0-f68.google.com with SMTP id f74so8980745qge.3
        for <git@vger.kernel.org>; Sat, 07 May 2016 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ffrsnCcaM1N4nfIjF0salAi4YXl8jest4VmibG8YN2I=;
        b=f0iY22dS3SRYBIV1AutkFreLjvsMBwSOYatfmmqZDZhc+9oeGdWSsa2P609dxlUqgt
         u5FtD5jlLACw1a+nhK1V7zAe1F+Qltk295STgKUXr/N5yrGXK9MMiF/j9ROb0DP0ooe0
         U2RqL5YzImy1SmnShYBGLKpAgFIboXC8ieg3LUD5NlFR8cC0HQBpid8MWzLocwUJlPZ5
         fDcO+CoGxeSV69hL/PNvqFCnyS97k9mTK7YTCxggBTPnDE/kIKVXye0hii+DwHsXVQbN
         9a7Mpz2AAQ1mrdgSzGvRoUJlhOo9t9firTBoJ/6bXLyVOW5qKUuwZ5oezW76wdbJ7SOm
         AmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ffrsnCcaM1N4nfIjF0salAi4YXl8jest4VmibG8YN2I=;
        b=TnwcyLL2NuPVQB6Ja3XjEJUvvZEdCqUjIv40mn/T94bS9y0UWbv0AgD+D5MVgCYOXa
         /PiTRkZxvy0E6csNabZIZXYL7zB5ycdh0bmflzm/Hawjg3ynvT1hXPkyU+cVudVPi9va
         nhCqWxknh6y0+Zjjcuwqk3r9gqVWRlpe/6ZfX/zyH46UpU/SpwE3CZ7EZ18D6WSjVvys
         HezjMHggmXsuxZcRnjRZRcAJjWOUoAEVx5R/J7Ur5elyYLARMtAI1DEb1QK4hOrIpt3v
         JsBh4h+xDRwIQEVtlKSKIvzxRqScOw1iRiLHSjMa5GnBx/S2r9yZIFcBAyOsK6yGJWw7
         b8fA==
X-Gm-Message-State: AOPr4FVgnEztLOAGGFrcFDddmrg4MktCxODTveraXcnHB6Ps1FvQfxf9H1xpQmhyzPDRkWmXcdIYaxM4q3+nPQ==
X-Received: by 10.140.87.116 with SMTP id q107mr26625044qgd.61.1462649352793;
 Sat, 07 May 2016 12:29:12 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Sat, 7 May 2016 12:28:53 -0700 (PDT)
In-Reply-To: <20160507053209.GA1704@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293905>

On Sat, May 7, 2016 at 7:32 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 06, 2016 at 08:33:15AM -0700, Junio C Hamano wrote:
>
>> > Then I replied:
>> >
>> >    However, that doesn't mean that we have to spread this badly chosen
>> >    name from options to config variables, does it?  I think that if we
>> >    are going to define a new config variable today, then it should be
>> >    named properly, and it's better not to call it 'commit.verbose', but
>> >    'commit.showDiff' or something.
>> >
>> > http://thread.gmane.org/gmane.comp.version-control.git/289027/focus=289303
>> >
>> > Any thoughts on this?  Before a poorly named config variable enters to
>> > the codebase and we'll have to maintain it "forever"...
>>
>> My thoughts are --show-diff would probably be a UI mistake of a
>> different sort, if you are anticipating that the different kinds of
>> information to be shown in verbose modes would proliferate and that
>> you would want to give the user flexibility to pick and choose to
>> use some while not using some other among them.  You would end up
>> having --show-xyzzy --show-frotz --show-nitfol ... options.
>>
>> I am not convinced that we would want such a degree of flexibility
>> in the first place, but even if we did, we'd be better off giving
>> that as "--verbose=diff,xyzzy,frotz...", I would think.
>>
>> And commit.verbose that begins its life as a simple boolean, which
>> can be extended to become bool-or-string if needed, is better than
>> having commit.showDiff, commit.showXyzzy, commit.showFrotz, etc.
>
> I don't think anyone is anticipating more "--show-" options. It is just
> that "--verbose" is the opposite of "--quiet" in most other commands,
> and pertains to chattiness on the terminal about what is going on.
>
> Whereas in git-commit, is about sticking some data in the commit message
> template. Naively I'd expect it to cause commit to spew more data to
> stderr about what's being committed, ident info, etc.
>
> If you are thinking that there could be something like "--show-ident" to
> replace that, I do not mind that too much. But IMHO that does not
> address the root problem that commit's "--verbose" is not very much like
> the same option in other commands. And something like
> "--verbose=diff,ident" just seems to make that worse by coupling options
> that otherwise don't have anything to do with each other.

I can see how it looks out of place looked at like that, but for me as
a long-time user (aren't we all?) it never felt out of place because
it's a more verbose version of the output that's brought up when I'm
modifying it.

I.e. I'm modifying the commit message, so the message is brought up,
optionally and more verbosely I can ask for the whole commit
(including diff) to amend the commit message.

I.e. I really expect --verbose to be a more verbose version of the
primary thing a command is doing, which in the case of "commit
--amend" is giving me info I need to modify the commit.

It also fits nicely with "status --verbose" showing a diff of staged
changes, similar to how --verbose for commit shows the diff for a
commit being amended.
