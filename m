From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git remote set-head not working?
Date: Fri, 18 Dec 2009 18:55:32 -0500
Message-ID: <76c5b8580912181555i39484811t3aa641254c07dcce@mail.gmail.com>
References: <76c5b8580912180825t17bfc90eq20dfc05cafa8c02e@mail.gmail.com>
	 <20091218165302.GA1746@sigill.intra.peff.net>
	 <76c5b8580912180938s2b885efax33be860f963ba92f@mail.gmail.com>
	 <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 00:55:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLmfa-0006rK-CJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 00:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbZLRXze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2009 18:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbZLRXzd
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 18:55:33 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:46173 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbZLRXzd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2009 18:55:33 -0500
Received: by iwn1 with SMTP id 1so2529198iwn.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D07wJ/mMnXwGC3byCAjhIDdsxYEAMt16/yYC6A25hSs=;
        b=wmV22VLer4RjkhZs8krioT/lqVdZ/sEJTbY4fujjr+v9C7RnPUAnFILvsPdzHpvHx8
         04pmtuahGLspAp1dm0mNzGGbrv2G3gTQa3BGbroM02qIlGEVxlpnaPHu51pZ9xw/GrEx
         CjxbhvsYXWzbM3Rbclv5dmUliMtsWweD8/fWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cfdfL7BmzK4y3KeI76iixlxR1TkbFGOIV2waCX6ENUpYFlHOk9K6nF2zYpDwjFiXz+
         Z0ryHi6pks1sxV6G5aQ75XiBQg2ksbkfMjsvb/1Q+6LyLwAnqXtdGdCukfS9LyK9vjCx
         ndv/Km5Y1tO8A139nMYc1/dajufunb3rSTAbM=
Received: by 10.231.123.41 with SMTP id n41mr2445341ibr.46.1261180532564; Fri, 
	18 Dec 2009 15:55:32 -0800 (PST)
In-Reply-To: <76718490912181328k5f87d82u499b7a1eba471126@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135450>

> The remote command is about updating things under .git/refs/remotes,
> not about updating a remote server. For updating a remote server,
> there is really only push. Clear as mud?
>
> It is expected that the person setting up the bare repo is the person
> who knows best which is the "default" branch. Which is why clone uses
> the remote HEAD as the default branch to checkout.
>
> But, if you don't like that, you can always use:
>
> % git clone -b master ...

didn't know that, thanks!

>> Secondly, I don't really understand what is the purpose of "git remo=
te
>> set-head" if the change cannot be transferred to the actual origin
>> repo, so it will start serving another branch as default?
>
> Hmm, the man page says:
>
> =C2=A0 =C2=A0 =C2=A0 set-head
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Sets or deletes the default branch=
 ($GIT_DIR/remotes/<name>/HEAD)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for the named remote. Having a def=
ault branch for a remote is not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required, but allows the name of t=
he remote to be specified in lieu
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of a specific branch. For example,=
 if the default branch for origin
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 is set to master, then origin may =
be specified wherever you would
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 normally specify origin/master.
>
> This seems clear to me, but I guess if you expect that "git remote"..=
=2E

terms i'll use here:
remote - instance created using git remote add or by cloning
origin - actual remote repo I cloned from

If it would be exactly as you said then it would probably not be so con=
fusing.
The problem here is that if set-head is only about the remote, then
why after i change it from master to qa and "git show remote origin"
doesn't show this change? Bug? Probably, because "git show remote
origin" actually queries origin for this info and always shows origin
HEAD branch, as Jeff pointed out. If this is the case then there is an
inconsistency between those two commands which caused this confusion.
Please, correct me If i'm wrong but i really think that there should
be a way to not only set it up for remote but also for origin , where
the remote points to if you have push rights of course.

Of course all of this could be avoided if I knew that i have to be
explicit during cloning from my colleagues, because their HEAD may be
pointing to some BUTT, which I don't even want to know about;)

Thanks,
Eugene
