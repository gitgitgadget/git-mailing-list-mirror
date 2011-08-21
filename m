From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 23:06:16 +0000
Message-ID: <CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
 <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
 <CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
 <CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com> <CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:06:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvH6R-0003ad-ID
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 01:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab1HUXGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 19:06:47 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:44402 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab1HUXGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 19:06:46 -0400
Received: by iye16 with SMTP id 16so9273769iye.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wTSunJWsIQxloMIKxzK1N6F+7p2Ipj/flBRwDS+BXaY=;
        b=cYLfXObem39p8NiEeVfqjVxpvyYc2eQ/9qOEQiZsIQkEXHAavJucRj4DArYwCWc+hi
         jmBLh9SV1SCAMpztFiDU2PL0/mUc+10Y/WHP6RzXRt43FmhbX6vlZUbb8v67KlQKaIjk
         sNSTGJ9PL90xvCj1oNkUfvRCvqlW+84BT0L+0=
Received: by 10.42.130.68 with SMTP id u4mr2041624ics.464.1313968006057; Sun,
 21 Aug 2011 16:06:46 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 16:06:16 -0700 (PDT)
In-Reply-To: <CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179822>

On Sun, Aug 21, 2011 at 21:37, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On 21 August 2011 13:53, Michael Witten <mfwitten@gmail.com> wrote:
>> On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
>> <hilco.wijbenga@gmail.com> wrote:
>>> Isn't a branch simply a way to track changes separately?
>>
>> Well, what does that mean, really? You can certainly use branches to
>> help you achieve that goal.
>
> It means my commits are chained together separate from, say, master.

Well, that's not what a git branch provides in general.

>> In git usage, a `branch' is just a human-readable name for any given
>> commit object; it points to a commit object, and you can change to
>> which commit it points. Furthermore, to help you work with commit
>> lineages, some of the git machinery updates these branches (or
>> `pointers', if you like) automatically (for instance, when you make a
>> new commit object with `git commit', then the `current branch' is
>> updated to point to the newly created commit object).
>>
>> Of course, 2 different branches may be used to point to the same commit object.
>>
>> You should really think of your repository as a giant web of commit
>> objects (or, more technically, as a directed acyclic graph where each
>> node is a commit object); a commit object can point 'backwards'
>> towards its parent commit objects. A branch (like `master') just
>> points to one of these commit objects at any given time (that is, a
>> branch just gives a nice human-readable label by which to reference
>> one of these commit objects at any given time).
>
> Yes, I agree with all of that (especially the last sentence). I don't
> see how it changes the concept of a branch is, though. You are, I
> think, simply listing the technical implementation.

No, I'm simply listing the reality of what a branch is.

> ...
>
> I feel like we're talking in circles. I get (and even agree with) what
> you're saying but I don't see how it changes the concept of a branch.
>
> In any case, what I'm more interested in is knowing whether we can
> (optionally) add state (i.e. untracked/ignored files and unstaged
> changes) to a branch.

No, because a branch doesn't IN ANY WAY provide the structure for that
kind of thing. Of course, you could use what git calls a 'branch' in
order to implement what you imply is a 'branch', but git's concept of
a branch and your concept of a branch are not at all the same concept
(which is why the term 'branch' is so unfortunate).
