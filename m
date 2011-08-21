From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 21 Aug 2011 16:35:44 -0700
Message-ID: <CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
	<CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
	<CAMOZ1BsZvXsnnWAPXR7UGKdqOMwuGB-ffaAPk55U_1dcjZUcDw@mail.gmail.com>
	<CAE1pOi2r9DT3Y-GxivTZRaNVi=qLOy5=QpQ-_YysOkgqy3iGRQ@mail.gmail.com>
	<CAMOZ1BvpnP_729YOHrrPW3B8wa5c4cLyD_qAQ5rTuy0JqNiiXg@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 01:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvHYU-0001Xj-Ji
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 01:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab1HUXfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 19:35:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34178 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598Ab1HUXfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 19:35:45 -0400
Received: by yxj19 with SMTP id 19so3180572yxj.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=on5g2ct5fgRhiVcRnwAQ2Cc8uu8UoV9+v/gglpUxbzg=;
        b=nwe/y86h1gAzp3dOISniQMXJSdOdk67dMD9kvDSsGu5rmngWtFSVjQdJ2CjknRzYDI
         RH4UvjZ6uCit9TCe92KdIdO3wd45fzgs0Mpg+7YcxLlVXvIbdWqwi7rg8wSeHafioXJr
         vFulbrMG+AA6Gjzf/rQ/IwXpbSVuyz6nSQ3wQ=
Received: by 10.236.136.167 with SMTP id w27mr10075158yhi.102.1313969745111;
 Sun, 21 Aug 2011 16:35:45 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Sun, 21 Aug 2011 16:35:44 -0700 (PDT)
In-Reply-To: <CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179823>

On 21 August 2011 16:06, Michael Witten <mfwitten@gmail.com> wrote:
> On Sun, Aug 21, 2011 at 21:37, Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
>> On 21 August 2011 13:53, Michael Witten <mfwitten@gmail.com> wrote:
>>> On Sun, Aug 21, 2011 at 13:42 -0700, Hilco Wijbenga
>>> <hilco.wijbenga@gmail.com> wrote:
>>>> Isn't a branch simply a way to track changes separately?
>>>
>>> Well, what does that mean, really? You can certainly use branches to
>>> help you achieve that goal.
>>
>> It means my commits are chained together separate from, say, master.
>
> Well, that's not what a git branch provides in general.

Er, so what *does* a Git branch provide then?

>> I feel like we're talking in circles. I get (and even agree with) what
>> you're saying but I don't see how it changes the concept of a branch.
>>
>> In any case, what I'm more interested in is knowing whether we can
>> (optionally) add state (i.e. untracked/ignored files and unstaged
>> changes) to a branch.
>
> No, because a branch doesn't IN ANY WAY provide the structure for that
> kind of thing.

Obviously, we'd need to expand that structure.

I tried (ab)using git stash to get what I want but it ignores
untracked/ignored files (not a big surprise, of course). It seems the
functionality is almost there. If I could just combine git checkout
with git stash (and have it work with untracked/ignored files) in a
script or alias, I'd be a happy camper. I'll have to give it some more
thought.

> Of course, you could use what git calls a 'branch' in
> order to implement what you imply is a 'branch', but git's concept of
> a branch and your concept of a branch are not at all the same concept
> (which is why the term 'branch' is so unfortunate).

You've completely lost me. You may very well be right but all I see is
that you're pointing out how branches are implemented in Git.
