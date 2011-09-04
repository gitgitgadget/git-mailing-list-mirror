From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 13:40:19 +0000
Message-ID: <CAMOZ1Bv+Lm34Q76FebEe5-VZaLim9j4rrRtke1iCqtP19fjY1Q@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <CAJsNXTmJo6UXYS4AXygSLq2+T8MV0Sp0KhUt_mvgMqxC_k27ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Sun Sep 04 15:40:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0CwR-0003Bj-Kk
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 15:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab1IDNkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Sep 2011 09:40:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57203 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab1IDNkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Sep 2011 09:40:49 -0400
Received: by iabu26 with SMTP id u26so5190536iab.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=W0f1l+sqgFH7LsMNR2aWymcr/bW/I16wTPW+oSp0ClE=;
        b=Qnbuf51g1zDUmtbpTwT/ZtehF8OnP1cI3HDeMEhANLivaH4+vhPNcJDSJuym8iL/Y5
         orlUXPXSuXa42gaUK17L2hHCKLl8ZIJ8lHOkD3sDxFopODJK3zEeeBF1DcbrpV+H78w2
         QHtAsLTEk+qOUNmN/WMpnKFiumJbp77GK/vWU=
Received: by 10.43.44.195 with SMTP id uh3mr2769005icb.196.1315143649149; Sun,
 04 Sep 2011 06:40:49 -0700 (PDT)
Received: by 10.42.178.198 with HTTP; Sun, 4 Sep 2011 06:40:19 -0700 (PDT)
In-Reply-To: <CAJsNXTmJo6UXYS4AXygSLq2+T8MV0Sp0KhUt_mvgMqxC_k27ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180681>

On Sun, Sep 4, 2011 at 10:02, PJ Weisberg <pj@irregularexpressions.net>=
 wrote:
> On Sat, Sep 3, 2011 at 6:32 PM, John S. Urban <urbanjost@comcast.net>=
 wrote:
>> With my first use of git(1) I =C2=A0created a small project with abo=
ut 200
>> "commits". =C2=A0When this was complete, I needed to label each comm=
it with
>> information pointing it to a section of a document. I used tags for =
this. So
>> far, everything was fine. I was then asked to merge two commits
>> into one. I then did a "rebase" (for the first time). I then appear =
to have
>> lost all association between the tags and the effected commits; as a=
ll
>> commits after
>> the ones I modified no longer see "their" tags. Was there a way to h=
ave kept
>> the tags associated with the original commits as they were "rebased"=
?
>
> ...
>
> My point is that the tags are still there, and they still point to th=
e
> same commits they always pointed to. =C2=A0It's just that those commi=
ts are
> part of the original history, not the alternate history created by th=
e
> rebase. =C2=A0People say that Git can "rewrite" history, but really i=
t
> creates a new history for the branch. =C2=A0The old history is still =
around
> as long as there are references to it, until the garbage collector
> picks it up.
>
> Once a tag points to a commit, it isn't meant to be easy to make it
> point to a different commit. =C2=A0For the same reason that you would=
n't
> release version 1.8.3 of some software, and then later make a new
> release also called 1.8.3.

Perhaps `git rebase' should accept a `--tags' flag to tell it to
rewrite tags (or should I say `recreate' in the case of tag objects).

Git should not get in the way of people who know what they are doing.
