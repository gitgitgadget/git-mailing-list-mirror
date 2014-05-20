From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 15:52:56 -0500
Message-ID: <537bc0a8eb91a_a6f166b308d@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <537693aee4fdd_3e4812032fcc@nysa.notmuch>
 <xmqq7g5i4r48.fsf@gitster.dls.corp.google.com>
 <53795c3e58f73_10da88d30829@nysa.notmuch>
 <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 20 23:04:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmrCs-00049q-9T
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaETVEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:04:12 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33405 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbaETVEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:04:09 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so1134455obc.7
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=yOyUwme9W/ltkkHLIpXN46BX8Dl4LamlQ9TnhPTF/nI=;
        b=USzCOo6Mhtw4bPMqGNgzjGzlz0miYYtxZMFaHaH63dah+NIfvkxNejtx3sbUabbTsO
         oc3eiSXfmQj8uGei8h+FqpiUDGhraQn+ijGDpzl/n7YPHYVbEkdKu96oshCSsoZLu7YU
         OZSAm9O4nRdhJJ5v5pdxsKii2NiezmQwEf3/ChH63awSDQlzT1KtQtb7g4l+qjncbdpi
         Wx2oiEZEEX2CMAMFBGhShK5RrrKSJenS2Aqrwk81DcngVJ4ND+k7Cpik22ABgHX6AgSU
         NhyTqFJM9607X6zEV2agAk+hIZFdcI8lwBYUgQQzadQQklynvEV/NSEyK6ymv3o/SzrI
         cqQg==
X-Received: by 10.60.145.144 with SMTP id su16mr19151624oeb.64.1400619849221;
        Tue, 20 May 2014 14:04:09 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ux1sm5297042obc.28.2014.05.20.14.04.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 14:04:08 -0700 (PDT)
In-Reply-To: <xmqqha4lwj57.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249743>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> 
> >> After looking at the reverse-depends list of packages, my faith is
> >> strengthened in that the Git ecosystem is truly maturing and useful
> >> third-party plug-ins will be picked up by distro packagers.
> >
> > Where is git-imerge packaged?
> 
> I didn't see it on the archive the said Ubuntu box slurps from, but
> I did not check all the other distros.

I will help you: it's not packaged anywhere.

> > Do you want to bet? Nah, you don't *ever* want to accept you were wrong,
> > even you clearly where.
> > ...
> > This is what's going to happen: there won't be an official git-hg
> > package for *years*, if there is ever one. That is my prediction based
> > on all the available evidence, I am willing to stand by it and accept I
> > was wrong if it proves otherwise.
> >
> > Are you willing to stand by your own decisions?
> 
> If I understand correctly, you have made and you do maintain some
> packages and as an insider, you do not have to wait for "an
> outsider" to step up to make remote-{hg,bzr} packages yourself.

No, you do not understand how packaging works. ArchLinux's AUR[1] is a
community-driven repository, anybody can package anything and put it
there. That doesn't mean people can simply do `pacman -S git-remote-hg`,
far from it.

It's a placeholder for *outsiders*, not official package maintainers.

I am an outsider in ArchLinux.

> You may already have done so for your own use and told other people
> about them, and others may have chosen to wait for you to push them to
> distros instead of championing these tools by packaging them
> themselves.

You clearly haven't tried to package anything for any distro. You can't
just champion packages for a distribution. You have to go through an
arduous process before becoming an official packager.

> When you have such an influence on the outcome either way of your
> choice, I do not see much value in such a bet.

If I champion these packages I would be making you win the bet. Why
would I do that?

> But I actually think that "we package what we want to use" is a good
> thing for programs whose primary audience is the software developer
> types.  The packagers are part of their audiences [*1*].  Because of
> that, even if remote-{hg,bzr} do not get packaged for a long time, I
> doubt that it tells us what you are stipulating.  The only thing we
> can infer would be that these programs did not interest the software
> developer types to motivate them enough, and we wouldn't know why
> they found the programs uninteresting.  It may be because those who
> have history in Hg prefer to interact with remote Git repositories
> by pushing into and fetching from them using Hg tools than using Git
> tools.  It would not indicate "useful tools fall through the cracks"
> if it were the case, would it?

Or it might mean that the people that would otherwise do that packaging
instead simply copy the single file needed manually.

> Indeed I saw bzr-git that came from the Bazaar land packaged on the
> box I mentioned, and its description sounded like it is meant to
> work in such a way that allows Bazaar commits to be pushed to Git
> repositories using a bzr tool.
> 
> By the way, I also saw git-mediawiki packaged from contrib/ in our
> tree.  I found it not very credible to say "contrib/ is treated as a
> single ball of wax without much value by packagers, and we need to
> move the helpers up to core in order for them to be used more
> widely" after seeing that.

You are misconstruing what I said. I said *most* distributions treat
contrib as a ball of wax. And I said there were a few *exceptions* on
this ball of wax, like completions. remote-helpers are not part of these
exceptions (with the exception of git-bzr).

> *1* I saw you called them "wolves" at least twice recently---where
>     does such a distrust come from?

It's a jungle out there, and it's every out-of-tree tool by itself. Most
of the tools on the contrib/ area would not survive if you throw them to
those "wolves", and you know it.

[1] https://wiki.archlinux.org/index.php/Arch_User_Repository

-- 
Felipe Contreras
