From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Tue, 29 Apr 2014 06:46:39 -0500
Message-ID: <535f911fac157_2719108f3083a@nysa.notmuch>
References: <535C47BF.2070805@game-point.net>
 <CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
 <535D4085.4040707@game-point.net>
 <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
 <535D6EB1.9080208@game-point.net>
 <535e18cdc7bce_338911e930c72@nysa.notmuch>
 <87bnvl6bdg.fsf@fencepost.gnu.org>
 <535e8e4253196_45651483310b3@nysa.notmuch>
 <152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
 <535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
 <CAHYYfeGBLXGgK-cTQLEreFXJakp1jBE829=LrhmKR3MttBiw+A@mail.gmail.com>
 <535f1d4d8cbbb_762310ef30c9c@nysa.notmuch>
 <220967ee-98a9-4731-88c0-43a9cba7220a@email.android.com>
 <535f62c1e740a_45e485b30887@nysa.notmuch>
 <87r44g33z4.fsf@fencepost.gnu.org>
 <535f702352d21_3aee3b2f0b9@nysa.notmuch>
 <87mwf431t3.fsf@fencepost.gnu.org>
 <535f76db38a34_6f23159b31099@nysa.notmuch>
 <87eh0g30it.fsf@fencepost.gnu.org>
 <535f7c35cb5b1_7c7c10e32f019@nysa.notmuch>
 <87a9b42zh8.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: James Denholm <nod.helm@gmail.com>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 13:57:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf6f2-0002Ii-ML
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 13:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933916AbaD2L5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 07:57:15 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:56156 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbaD2L5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 07:57:14 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so63224ykb.26
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=W/XKQE+mW6d3exeraYifDVsajqpInCoCvkz3ljj/XKs=;
        b=fJzTGcnPgRK67/o86mcblKTSzPxHIpJHWaLJMvGs/HHMtI8l1lJ06fjLpU33DqFeWd
         6qZMffQy3kAx3pLX72nVC5tby5YEw+pPRc+bHOCdJdp3auIBsp4GXy/dmUMfE874hcV1
         nVN1nl/xWHBSPWwUojrjYNVTwdTlP4wQr7pib7MV12xYzAZqJYJulYjTvdRurviGJF2Y
         gzky6Xzhy7Y/jYyV21iOnm5Qzszo7qOT9wlgqRy9G+RDS+TjnDaqyTJCrEiuXUAuaKDw
         W5iQ9y/cFbdgWt53gHKhtbqZC3MXrYkpOv59BSBRtGVCKarr8GwcehsEpbw/p7R88iio
         Kd2g==
X-Received: by 10.236.130.241 with SMTP id k77mr990850yhi.159.1398772634114;
        Tue, 29 Apr 2014 04:57:14 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g1sm28894558yho.37.2014.04.29.04.57.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2014 04:57:12 -0700 (PDT)
In-Reply-To: <87a9b42zh8.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247575>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > David Kastrup wrote:
> >
> >> The default behavior of "git push".
> >
> > This is a minor change that not many people would notice, and it has not
> > actually happend. But fine, let's count it as one.
> 
> Shrug.  Your diatribe is to a good part about the default behavior of
> "git pull".

> The "minor" change affects multiple branches in upstream,

This is what most people see by default since two years ago:

  warning: push.default is unset; its implicit value is changing in
  Git 2.0 from 'matching' to 'simple'. To squelch this message
  and maintain the current behavior after the default changes, use:

    git config --global push.default matching

  To squelch this message and adopt the new behavior now, use:

    git config --global push.default simple

  When push.default is set to 'matching', git will push local branches
  to the remote branches that already exist with the same name.

  In Git 2.0, Git will default to the more conservative 'simple'
  behavior, which only pushes the current branch to the corresponding
  remote branch that 'git pull' uses to update the current branch.

  See 'git help config' and search for 'push.default' for further information.
  (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
  'current' instead of 'simple' if you sometimes use older versions of Git)

Do you honestly believe that there's *anybody* out there is OK with seeing this
message _every_ _single_ _time_ he pushes? No. Everybody has already configured
push.default to one thing or the other. They won't see the change when 2.0 is
released.

And no, if by some miracle somebody hasn't configured that, it still won't
affect the branches upstream, if anything changes is that the `git pull` will
error out warning the user that the upstream branch doesn't have the same name.
It won't affect the branches you actually push.

> while your "important change" affects a single local branch.

My change does actually affect upstream branches, more than that, it affects
the upstream topology, because Git newcomers make merges by mistake when they
call `git pull` without knowing what the hell is going on. Everybody knows
that.

And this is a red herring. I never said my change was important, we are talking
about the changes that have actually happened in the last four years, which is
none.

> With that sort of bias, it's easy to convince yourself of anything.

I'm done discussing with you. I already demonstrated that your claim is wrong.
Change just doesn't happen.

-- 
Felipe Contreras
