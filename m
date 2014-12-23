From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: Saving space/network on common repos
Date: Mon, 22 Dec 2014 21:36:53 -0800
Message-ID: <CAGXKyzFXVODvbqzO3CAQRr2S4dDbe95TGc=8iYgcBkKpAPiXSg@mail.gmail.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
	<20141217223215.GO29365@google.com>
	<CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
	<20141218000723.GP29365@google.com>
	<CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
	<20141223031233.GX29365@google.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 06:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3I9s-0003Kh-BB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 06:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbaLWFhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 00:37:06 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37618 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbaLWFgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 00:36:54 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so5014809igj.10
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 21:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YYbWTGQup9IGO1nRS0KLHdaHEUeVoXzO/ZITH8vrPTY=;
        b=cm8Wu8S3TUTMrmdztHkkb9UGWyij3wT+gVTsPqQbcCTiyt36cl6d7i/dsuyRSYANqE
         DEUPwK1owqqRaXTn6nKX3s0uLxRXWmjLRh3kpjAtutT600IJCNVFCmEoSEB3/N1C3pwY
         kpRF9kF465tzZUZ/j0pSbJUEmRkJCfC1DI4d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YYbWTGQup9IGO1nRS0KLHdaHEUeVoXzO/ZITH8vrPTY=;
        b=jn40UoN06B24vsq7SjjQpWb4D2AVsT7Zok/O49fC/MZxdWmH3tQFU4lse7XgnY/eax
         1r9jZENobSywRr8KO/XemMGgWNd9o24+RScJuAo5da/5b3d4OBhjXS7IZjhQTGnXVHFw
         p1vT1VLyqwEFe2zbxvkn/vNzAEgQ0L8kEHOxMAiUPRmfZy3uZHxph+EhCakn8BNWVURy
         UZThHlHzMP7FxixcIm5YLs1d+/Rn2Oz4pyM/fLZgUdtU4qjLW6aAXEb/TeMW0Fp9AG7s
         XSsxSe8hRwe2ARFcWq6wdu99m8KfNtDexLwQfSuggOLsACD328gyChPOS+nJ1CIk0Tza
         tyaw==
X-Gm-Message-State: ALoCoQmGOd2psi0FnC8NgZMP8QaCZhN+6il6/M2hUNSAjUO0zXd+HPDPSl3wJnZeahz+gIu0h5Uq
X-Received: by 10.107.13.205 with SMTP id 196mr23887192ion.15.1419313013746;
 Mon, 22 Dec 2014 21:36:53 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Mon, 22 Dec 2014 21:36:53 -0800 (PST)
In-Reply-To: <20141223031233.GX29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261714>

} This seems like good motivation to try to get that series in good
shape and release it soon.

I was going to spend some time tomorrow (if I can find any :-) )
trying to fix up the contrib script to work with submodules, or at
least the kind that we use.  Is that something that's worth the time
to do, or would we be better off just waiting for the work-tree stuff
to get released?  If I do end up doing it, would you be interested in
a pull request (or however patches are submitted in the git world)?

craig

On Mon, Dec 22, 2014 at 7:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Craig Silverstein wrote:
>
>> btw, just FYI, the scheme you lay out here doesn't actually work
>> as-is.  The problem is the config file, which has an entry like:
>>            worktree = ../../../mysubmodule
>> This depends on the config file living in
>> ./git/modules/mysubmodule/config.  But the proposed scheme moves the
>> config file to mysubmodule/.git/config, and the relative path is
>> broken.
>
> As was pointed out to me privately, the behavior is exactly as you
> described and I had confused myself by looking at directory that
> wasn't even made with git-new-workdir.  Sorry for the nonsense.
>
> Workdirs share a single config file because information associated to
> branches set by "git branch --set-upstream-to", "git branch
> --edit-description", "git remote", and so on are stored in the config
> file.
>
> The 'git checkout --to' series in "pu" avoids this problem by ignoring
> core.bare and core.worktree in worktrees created with 'git checkout --to'.
> To try it:
>
>         git clone https://kernel.googlesource.com/pub/scm/git/git
>         cd git
>         git merge 'origin/pu^{/nd/multiple-work-trees}^2'
>         make
>         PATH=$(pwd)/bin-wrappers:$PATH
>
>         git checkout --to=../experiment next
>
> This seems like good motivation to try to get that series in good
> shape and release it soon.
>
> Thanks again,
> Jonathan
