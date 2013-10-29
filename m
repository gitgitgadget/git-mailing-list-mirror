From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-contacts questions
Date: Tue, 29 Oct 2013 02:57:48 -0600
Message-ID: <CAMP44s1+npNnR8-exARL8kamQ81JwyLhhQnnkv6DvK8e3qOfHA@mail.gmail.com>
References: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 09:57:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb57b-0002Vg-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 09:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287Ab3J2I5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 04:57:52 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:61193 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510Ab3J2I5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 04:57:51 -0400
Received: by mail-la0-f51.google.com with SMTP id ea20so6252432lab.10
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MHakio5DLZpiCohxuqEBrv7TLVhHra25W+7uzRokWzU=;
        b=jeox5X2wk+fzEji29SsxYU7Ezi6e0Nh8oM82G558QjwVqnU3RMafoMuuC+IbJQDys6
         BewB3YtNBQh6u1fWE3tpTv5hcSYgFzog57jXibiSCFblQB5zzlUjI8/Eex2DVwtC+NRS
         Kmq5Q4VF46MYpGasxDRo2bpjXrKWbwy9BVXVYFuihUKjyMbEAL3Eb6RqKLc/6hJVqb/k
         4wP7SAsBunlXBEGCN+YF0qz4/Ldz/8QDmzX56rNNqxovWu6cXSKnGhG0/4cG2tBCnvkQ
         s83mJejLfo69ZKHBdt8GVoRjq53PWxRU8th6372cPYEsvpT0rhuAERm6z1qupnL/8HcB
         XiRg==
X-Received: by 10.152.120.73 with SMTP id la9mr17662671lab.3.1383037068267;
 Tue, 29 Oct 2013 01:57:48 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Tue, 29 Oct 2013 01:57:48 -0700 (PDT)
In-Reply-To: <CAHGBnuPW3dtiL-=6BgvaOB4VvOAPyZhrVS3WGreVH_Pt81=wyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236917>

On Tue, Oct 29, 2013 at 2:34 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:

> 1) Passing just "HEAD" as a committish like in "git contacts HEAD"
> does not output anything for me, but using the SHA1 for HEAD does
> neither. My HEAD commit does not add any files, but only modifies
> previously existing files, so I would have expected some output. In
> case it turns out to be correct to have no output in my case, could we
> probably say that in some message to the user?

It should be HEAD^, or -1, like with 'git format-patch'.

> 2) For some commits I get error messages from "git blame" in function
> get_blame because multiple -L options are specified:
>
> $ git contacts b0783baacd20be7007df40cf274985c4863d63fb
> fatal: More than one '-L n,m' option given
> fatal: More than one '-L n,m' option given
> fatal: More than one '-L n,m' option given
> fatal: More than one '-L n,m' option given
>
> From reading git-blame's man page it indeed seems to me as if only one
> -L option is allowed, so is this something that needs to be fixed in
> git-contacts?

You are probably using a newer version of the script on an older version of Git.

You can also try git-related instead[1].

[1] https://github.com/felipec/git-related

-- 
Felipe Contreras
