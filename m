From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 11:05:08 +0530
Message-ID: <CALkWK0mpPoZJWviBesWgy2dZ4xJrNyhED2znFid8iGbSTirPhQ@mail.gmail.com>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXngm-00017m-U5
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 06:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308Ab1LFFfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 00:35:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56839 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab1LFFfb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 00:35:31 -0500
Received: by bkbzv3 with SMTP id zv3so2947862bkb.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 21:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zCBaeLvl7InUA3icQDC/o/U0ng0CV8nF1+E0YxTqP/A=;
        b=mP1hc9DEzbCNzIMO0ikVWitFOPyMprg2bE/Fd7doUT6Dh4DyIUVEJUiLZ6Vzs/ehaG
         16UgRD0S85kN0jZP+qnalLby2hYA1okZjWi/5v6/VFSmjUGC+VWkhkadpvx/UANxuZlX
         pLHuMScjiznu9wkXcIm1j+5nofYcOsRjnbGXg=
Received: by 10.180.90.6 with SMTP id bs6mr15541273wib.63.1323149730125; Mon,
 05 Dec 2011 21:35:30 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Mon, 5 Dec 2011 21:35:08 -0800 (PST)
In-Reply-To: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186315>

Hi Junio,

Junio C Hamano wrote:
> * rr/revert-cherry-pick (2011-10-23) 5 commits
> =C2=A0(merged to 'next' on 2011-10-26 at 27b7496)
> [...]
>
> The internals of "git revert/cherry-pick" has been further refactored=
 to
> serve as the basis for the sequencer.
>
> Is this ready for 'master', or should we eject it to 'pu', expecing a
> re-roll?

[Notation: `rr/sequencer` is a new series I'm working on based on
`rr/revert-cherry-pick`]

I'm confused and I need your advice.  I've stopped working on
`rr/sequencer` because this branch is out-of-date now.  We can do one
of the following the improve the situation:
0. You can merge this into `master` resolving the conflicts: it's a
fairly straightforward resolution.  As soon as you publish the new
`master`, I can continue working on `rr/sequencer`.
1. I can post the `rr/revert-cherry-pick` to the list, hoping that it
will make it to `master` without more disruptions.  I can rebase
`rr/sequencer` on this new series and continue working.  For your
reference, this [1] is what I'll be posting to the list if we pick
this option.
2. I can squash `rr/sequencer` into `rr/revert-cherry-pick` to post an
entirely new series.  I think this is a really bad option.

Thanks.

-- Ram

[1]: https://github.com/artagnon/git/commits/rr/revert-cherry-pick
