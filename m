From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Revisiting metadata storage
Date: Thu, 15 Dec 2011 13:40:36 -0800
Message-ID: <CAE1pOi2TGWmFErcKhQu-a37JjLh22O1zFYoBaVRyfBDFjOTE9Q@mail.gmail.com>
References: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
	<87sjkx8gll.fsf@an-dro.info.enstb.org>
	<CAD77+gR=SjU0Ne9jort91pdHDA=RjkTJUJmnqKBipqoGUmoL_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:40:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJ2h-0006Kw-Lo
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759530Ab1LOVkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:40:37 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54867 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756549Ab1LOVkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:40:36 -0500
Received: by ghbz12 with SMTP id z12so1881680ghb.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 13:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9b7b2DaJlBEWpsl2IeKSN9VLm3ys4+NuyYDp3TvW6sc=;
        b=hlXpJPaHyNBjWzTkNNurdn55SxFWUxKWYkPLdzfgiVKmD1wkbUDWBJPd/PiG41d/7q
         zqiXyYFWCMpPKr4pTvQUJdP+nMsqBx8EoP7CN6XkFoiZz65hF8moSYEZUGx3oLfHbZxL
         G62IsFtbf3QvKlI7dHtXP78xLPtYsmJsyWw20=
Received: by 10.236.178.71 with SMTP id e47mr7355323yhm.66.1323985236316; Thu,
 15 Dec 2011 13:40:36 -0800 (PST)
Received: by 10.236.27.200 with HTTP; Thu, 15 Dec 2011 13:40:36 -0800 (PST)
In-Reply-To: <CAD77+gR=SjU0Ne9jort91pdHDA=RjkTJUJmnqKBipqoGUmoL_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187240>

On 14 December 2011 09:59, Richard Hartmann
<richih.mailinglist@gmail.com> wrote:
> On Tue, Dec 6, 2011 at 23:45, Ronan Keryell
> <Ronan.Keryell@hpc-project.com> wrote:
>
>> At least I'm interested and began to dig into it but I do not have a lot
>> of time to work on it...
>
> If we can agree on Perl, I can try to help. I don't think I speak
> enough Python to be of use with that.
>
> Other people who have an interest in this: Please pipe up so we can
> hammer out a rough consensus & roadmap.

I'd love to have better support for metadata (specifically
timestamps). I don't care whether it's Perl, Python, Bash, or C. I
don't think I'll be much help coding but I'd like to try.

In all honesty though, I plan to rewrite our build to use file digests
instead of timestamps. Right now every rebase means a full (and almost
completely unnecessary) rebuild. Luckily I'm using the wonderful
git-new-workdir so there is no pain when switching branches.

Once the rewrite is complete (in one or two months) Git's relentless
timestamp changes should no longer affect us as much anymore. I would
still like to get a better grip on metadata though. Git should be able
to not touch files that have not changed. But whether that's feasible
or even in scope of what you have in mind... :-)

Cheers,
Hilco
