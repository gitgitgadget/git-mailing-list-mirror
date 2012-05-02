From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: Please pull git-po master branch
Date: Wed, 2 May 2012 11:13:04 +0200
Message-ID: <CAN0XMOJ0PBA2qptw2Lm9HOq4SAkeZNAyOwPdvcb-uAcsxKnzwg@mail.gmail.com>
References: <CANYiYbHtKKWw9LPnr+1khC5Oms-kOtA2WEucoNoE3Njzqiahzw@mail.gmail.com>
	<87d36n2f2r.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 02 11:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPVcX-0000dS-Dz
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 11:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab2EBJNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 05:13:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50688 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab2EBJNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 05:13:05 -0400
Received: by ghrr11 with SMTP id r11so421035ghr.19
        for <git@vger.kernel.org>; Wed, 02 May 2012 02:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=grjfmQcJYDGJrWhY2BCsWQNhipLqfDL0DXbAY1LBr4M=;
        b=NrlsXgzqviw4qIBmP0aP7Jf2RNv0oyLh8Qtcws4Sm8pdF46xn7mqyiyvYvCTq0SSw8
         Ii8pYV+6hsLnyKDnDbpCfWxEc72ZgJAxPfs45aeWNo/HiOqbUTe/BlK/cIgZmiVx/qow
         2UBS+Z5VdoC4ebDIBF4ekvYrMlLYfIElIr4k1xdDyHSelr7wIG9BFoiWbZ0qPsthl10T
         pGpiRLxrfaloqjIku3ar7DS3roW5YuaGQegoVMvzs6KzevYSRAii/sGBWuAC9vgr/wUv
         7RhWcsoehhwaNeucK8g+P+6RuXH4/qxyzQikNO1FBJ0yqnH4XCCREcHoVI3Zm89ClFXM
         9yuw==
Received: by 10.236.108.199 with SMTP id q47mr29824762yhg.76.1335949984631;
 Wed, 02 May 2012 02:13:04 -0700 (PDT)
Received: by 10.146.203.1 with HTTP; Wed, 2 May 2012 02:13:04 -0700 (PDT)
In-Reply-To: <87d36n2f2r.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196795>

Well, basically I've tried to unify the translation with the git-gui on=
e.
So i took over some of the translations from them (e.g. "commit").

> =C2=A0A related issue is when a single word splits into several in Ge=
rman.
>
> =C2=A0Examples:
>
> =C2=A0"commit" -> "Eintrag/Version/eintragen"

I think we have to make a difference between "commit" as a noun and
"commit" as a verb here.

>
> =C2=A0"commit" -> usually translated simply as "Commit", e.g. in the =
SVN Red
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Book
>

As I said I've tried to unify with the git-gui translation. Actually, I=
 was
wondered why they translate terms like "Tag" or "Commit" because
I think they should be known by a Git user.
I know German books about Git using many other terms like
"Staging" or "Index" as it is.

> * Make a glossary of the relevant terminology first. =C2=A0Sadly
> =C2=A0gitglossary(7) has gotten somewhat stale, and perhaps can also =
benefit
> =C2=A0from an overhaul. =C2=A0=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
recently made a list[4] of
> =C2=A0the most important terms, which is a good start.
>
> * If you are interested in collaboration, IRC may be a good choice fo=
r
> =C2=A0the many little questions that probably arise? =C2=A0We hang ou=
t in
> =C2=A0#git-devel on Freenode[3]. =C2=A0Email is of course also an opt=
ion, but
> =C2=A0more time-consuming.

I would be happy to work together with you on these things.
Tiny changes in the translation of basic terms can make
a big difference.

> Note that in the context of Git, a major problem is that the
> documentation and books are only available in English. =C2=A0There is=
n't even
> a glossary. =C2=A0For example, you translated "detached" as "losgel=C3=
=B6st".
> From our experience the detached HEAD is something that users stumble
> into, rather than learn about beforehand. =C2=A0They usually come cry=
ing for
> help when they've already lost their work in the "void" of unreachabl=
e
> commits. =C2=A0Now put yourself into the position of a user. =C2=A0Wh=
ere can he
> look up what the root of his problem is? =C2=A0At least for "detached=
 HEAD"
> there is a wealth of blog posts that rescue the poor user.

That's a basic problem when messages are translated.

> We think -- pardon the strong words -- that your current draft
> translation makes things harder, not easier, for German users. =C2=A0=
The
> issues mentioned above, especially when it comes to ambiguities, spli=
ts
> into several terms and mistakes, add up to considerable bad weather, =
and
> the lack of reference material leaves the user out in the rain.
>
> Of course now that it has been released, we'll also have to file patc=
hes
> in the true open source spirit. =C2=A0Sigh.

I don't think that it's sooo bad that it needs to get reverted.
In the end it's an initial version. I'll join the IRC channel to
work with you (and others) together to make the translation
better.

Thanks
