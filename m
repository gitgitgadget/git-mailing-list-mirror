From: David Aguilar <davvid@gmail.com>
Subject: Re: New git-subtree almost ready
Date: Sat, 24 Mar 2012 01:00:42 -0700
Message-ID: <CAJDDKr6VSgZksGkXg2oW4nwWCggW1M5TapiyeH-rAkfo+FjnmQ@mail.gmail.com>
References: <87limu7hhi.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Sat Mar 24 09:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBLu5-0007e9-3x
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 09:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab2CXIAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 04:00:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42688 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab2CXIAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 04:00:43 -0400
Received: by yhmm54 with SMTP id m54so3228830yhm.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=t8M6BBVpDVZQVgVzbFj4I86U544e/m71nTwCrYW8/oo=;
        b=Pqf+/Y8PlR5KR1V//2KJi+DS/KdPF8rCCPlyIfeSRGzQpRaxPx3MqSQadd5dlH5BeB
         g51t1+pHVVjymFpo3sfzWIq4PSqJy7DSK9w05EHIE0vCcvsUGUnf2SqtJRBEWQiKUbzI
         WvLTDwnI8SALzmoNlJMu0IF9EtWkJupnZFsPBMgNkhWDU8wfJWt7ATOkoXboKVqWuuj1
         t4AhWXRRCyxNleG3HIAe2xPF4iQ/PfixYfHasxWUka4YSLdRywIAH9RaA8OHaL6DamR/
         4I5fHtIAsY4fAyHQo65giOtgvzpc8SM7HxZdOUdJIIK8VG+zQHpnj+3ncGrIrV73k5QO
         bLZg==
Received: by 10.236.134.211 with SMTP id s59mr15000857yhi.131.1332576042802;
 Sat, 24 Mar 2012 01:00:42 -0700 (PDT)
Received: by 10.147.143.4 with HTTP; Sat, 24 Mar 2012 01:00:42 -0700 (PDT)
In-Reply-To: <87limu7hhi.fsf@smith.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193820>

On Tue, Mar 20, 2012 at 8:36 PM,  <greened@obbligato.org> wrote:
> I've got the git-subtree merge in pretty good shape now. =C2=A0After =
being
> taught about TEST_DIRECTORY, I've been able to get rid of all of the
> test system changes and can run the git-subtree tests using the stock
> test infrastructure.
>
> Before I can put the new tree up I need a little help. =C2=A0Since it=
's been
> a while since I posted the last version of the tree, I tried to updat=
e
> from upstream master. =C2=A0git-subtree is in a separate branch (it w=
qas
> applied as a subtree merge) so I did the usual switch-to-master-and-p=
ull
> thing.
>
> However, now I don't know how to rebase from master to the subtree
> branch. =C2=A0If I do a "git rebase master" then the subtree merge ge=
ts
> re-applied as if the files were placed in the root directory rather t=
han
> in the target directory of the original subtree merge.
>
> The problem is described pretty well here and the issue has been cove=
red
> on the mailing list before:
>
> http://groups.google.com/group/git-users/browse_thread/thread/d54bacd=
234d95639
> http://comments.gmane.org/gmane.comp.version-control.git/191934
>
> I can think of a few strategies to move forward.
>
> 1. Keep the git-subtree branch where it is. =C2=A0Don't rebase and ju=
st push
> =C2=A0 the branch to a public repository. =C2=A0Make Junio do the har=
d work. =C2=A0:)

Hehe, I'm pretty sure the option that involves Junio doing the least
amount of work is the option to take ;-)



> 2. Split the subtree merge, remove it from the git repository, rebase
> =C2=A0 from master and then re-subtree-merge it.

I don't know if git-gui or gitk maintainers have advice for you, but
it sounds like this may be the best option, IMO.  git-subtree is not
yet part of the git history.

git is in a RC cycle right now, which is likely why you have not heard
much on this topic (new feature).  Folks will be busy testing the RC
and ensuring we have no regressions.

Looking forward to git-subtree,
--=20
David
