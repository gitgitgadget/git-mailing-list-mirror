From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 22 Aug 2011 00:07:44 +0000
Message-ID: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
 <CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
 <7vvctvdf5r.fsf@alter.siamese.dyndns.org> <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
 <CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
 <CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
 <CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
 <CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
 <CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com> <CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 02:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvI3w-0000Ic-FX
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 02:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756122Ab1HVAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 20:08:15 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44143 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367Ab1HVAIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 20:08:14 -0400
Received: by yie30 with SMTP id 30so3242774yie.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KxJlLpkWm0N6huycKwyeuSZMrRnCmAPPuf5dAoHTyeo=;
        b=CjBvFvwMOFSjKQM3cd/7TmjL8uAiN2bWbX2D6/fwSyKmQSm6EATTv+rxNeKmS+svpH
         spSKKfhRipfl4hOsED8UGj6qJp4tJgOcALVZ+M2CVn2JsgXRTQIyRWmLlFtgvi++pkyG
         ViFt9gNiUG6mOfmT396LRDC7dDgzFGgd3U8xw=
Received: by 10.42.108.194 with SMTP id i2mr1865777icp.263.1313971694092; Sun,
 21 Aug 2011 17:08:14 -0700 (PDT)
Received: by 10.42.174.129 with HTTP; Sun, 21 Aug 2011 17:07:44 -0700 (PDT)
In-Reply-To: <CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179826>

On Sun, Aug 21, 2011 at 23:35, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> On 21 August 2011 16:06, Michael Witten <mfwitten@gmail.com> wrote:
>> On Sun, Aug 21, 2011 at 21:37, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>>> On 21 August 2011 13:53, Michael Witten <mfwitten@gmail.com> wrote:
>>>> On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
>>>> <hilco.wijbenga@gmail.com> wrote:
>>>>> Isn't a branch simply a way to track changes separately?
>>>>
>>>> Well, what does that mean, really? You can certainly use branches to
>>>> help you achieve that goal.
>>>
>>> It means my commits are chained together separate from, say, master.
>>
>> Well, that's not what a git branch provides in general.
>
> Er, so what *does* a Git branch provide then?

I think my other replies (including the link) repeat myself quite enough.

A branch is just a pointer. That's it.

Quit saying `branch' to yourself. Start saying `pointer' or
`reference' or `commit label' or even `special tag'.

>>> I feel like we're talking in circles. I get (and even agree with) what
>>> you're saying but I don't see how it changes the concept of a branch.
>>>
>>> In any case, what I'm more interested in is knowing whether we can
>>> (optionally) add state (i.e. untracked/ignored files and unstaged
>>> changes) to a branch.
>>
>> No, because a branch doesn't IN ANY WAY provide the structure for that
>> kind of thing.
>
> Obviously, we'd need to expand that structure.
>
> I tried (ab)using git stash to get what I want but it ignores
> untracked/ignored files (not a big surprise, of course). It seems the
> functionality is almost there. If I could just combine git checkout
> with git stash (and have it work with untracked/ignored files) in a
> script or alias, I'd be a happy camper. I'll have to give it some more
> thought.

This cobbling together of git's components for this purpose is
actually a fairly frequent story on this list. Either git does indeed
need something more substantial as a `branch', or people (meaning you)
need to change the way they think (and I'm not sure which solution
would be best, honestly).

If there is a change, then what is currently called a `branch' should
be renamed explicitly to `pointer' or a `reference' or something like
that.

>> Of course, you could use what git calls a 'branch' in
>> order to implement what you imply is a 'branch', but git's concept of
>> a branch and your concept of a branch are not at all the same concept
>> (which is why the term 'branch' is so unfortunate).
>
> You've completely lost me. You may very well be right but all I see is
> that you're pointing out how branches are implemented in Git.

That last sentence and your earlier sentence:

> Obviously, we'd need to expand that structure.

vindicate everything I've said about the choice of nomenclature. The
term `branch' is a TERRIBLE choice.
