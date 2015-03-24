From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Wed, 25 Mar 2015 01:22:08 +0800
Message-ID: <CACRoPnRBBVGt8PVHVEYct46abLMJvKf0+MNz7bX2nx2C7OHd3Q@mail.gmail.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:22:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSXM-00073V-UX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbbCXRW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 13:22:29 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34802 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbbCXRWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:22:10 -0400
Received: by lbbsy1 with SMTP id sy1so146111078lbb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pwjX/uCRfoTLUDYkWR5cdDMqC3WLrqoompNhORR79ww=;
        b=0Y1fNodn3tS/RjmxattdEj9DQcFP9cep1NU6ybzXTrotqOeZsQzfljajvgVkGhugv2
         y+pgYMFjblYdV0zOiEhiAAHPuTcXii/9RL4KjeY8F4q4yfREzMyvaM4AfcrQK1YtF+75
         nu/DFXJcP3QqhWLDrtHc+7PxYU12zu4PDENVux8Bw98lTAZ2PfVTbOYL+kjdR5pQ0bbK
         acRgR19oFZVMRcbBqG2QnhJSblGspO40OZ4pQhqKbmR8gdkF7ZmW6rnN7rNUVvOgzat6
         1qsZW1beU2IZQqWV31Wo/popSG1Exe4RpY96ppIPce4sKQplBpVkX6rS6bPqyaXGB+Mj
         fHIw==
X-Received: by 10.152.180.202 with SMTP id dq10mr4547796lac.74.1427217728688;
 Tue, 24 Mar 2015 10:22:08 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 24 Mar 2015 10:22:08 -0700 (PDT)
In-Reply-To: <20150324163730.GA8366@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266204>

On Tue, Mar 24, 2015 at 6:19 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> A few minor details:
>
> "on operating systems with poor file system performance (i.e. Windows)"
> => that's not only windows, I also commonly use a slow filesystem on
> Linux, just because it's NFS. Mentionning other cases of poor filesystem
> performance would show that the benefit is not limited to windows users,
> and would give less of a taste of "windows-bashing".

Ah right, I didn't think of network file systems. Thanks for the suggestion.

> About the timeline: I'd avoid too much parallelism. Usually, it's best
> to try to send a first patch to the mailing list as soon as possible,
> hence focus on one point first (I'd do that with pull, since that's the
> one which is already started). Then, you can parallelize coding on git
> am and the discussion on the pull patches. Whatever you plan, review and
> polishing takes more than that ;-). The risk is to end up with an almost
> good but not good enough to be mergeable code. That said, your timeline
> does plan patches and review early, so I'm not too worried.
>

Well, I was thinking that after the full rewrite (2nd stage, halfway
through the project), any optimizations made to the code will be done
iteratively (and in separate small patches) so as to keep the patch
series in an "always almost mergeable" state. This will hopefully make
it much easier and shorter to do any final polishing and review for
merging.

> A general advice: if time allows, try to contribute to discussions and
> review other than your own patches. It's nice to feel integrated in the
> community and not "the GSoC student working alone at home" ;-).

Yeah I apologize for not participating in the list so actively because
writing the git-pull prototype and the proposal took a fair chunk of
my time. Also, my expertise with the code base is not that great yet
so it takes quite a bit more effort for me to contribute
constructively, but I expect that will improve in the future. Now that
the proposal is more or less complete I can spend more time on
discussions.

Thanks,
Paul
