From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: gitk pays too much attention to file timestamps
Date: Wed, 7 Apr 2010 03:47:15 +0400
Message-ID: <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
	 <20100406233601.GA27533@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 01:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzIUR-00020C-4x
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 01:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159Ab0DFXrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 19:47:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63593 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080Ab0DFXrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 19:47:18 -0400
Received: by vws13 with SMTP id 13so224560vws.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qNIxyi5hg/JvxEXaSh03Qe6E77ggdXvcBapeCrMai18=;
        b=BY7UdsFYODpJerISqCyXw08IQ/BQbdIK8PzBe8y6iENRyEBL8305lfjoKch2h8gp4x
         61UTkxc+DWrO2d75mJdIj2cbHpJ+0dMtady1UQtgI4S+cw4O1G+x4M9KQNwwzywdB5mN
         n5Af56Xp9aAhwz8RwBSUp1YVUrkUsYxz4rT3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v6coH72ZCgA7GpLQbtgrFICPl/uEXAgaWQgzz3Bsyqr2YubHjd1nuinmjof+X2TJlL
         yt6VOeEunorsalp6aO6x0yL5FO+nbmSiQ0VAgJKLQmreZOSCvb2CuZRJ/ZvKDI++j8zJ
         0AMHFPwZPMx6Aa7X0d/7YgRMpHGlDXl/YWyL8=
Received: by 10.220.93.2 with HTTP; Tue, 6 Apr 2010 16:47:15 -0700 (PDT)
In-Reply-To: <20100406233601.GA27533@progeny.tock>
Received: by 10.220.63.74 with SMTP id a10mr3966967vci.236.1270597635095; Tue, 
	06 Apr 2010 16:47:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144179>

Jonathan,

thank you for the explanation!

<...>

> gitk is something of a passive observer of the index, which is
> actually something I like about it. =A0This keeps it relatively fast
> and can be useful when trying to understand other commands.

I *think* that 1.6.x didn't have this issue. (Sorry, can't check now.)

> I am not sure how other people use gitk, though. =A0Maybe this would
> be worth changing. =A0For a reference point, another command in a
> very similar situation is =91git diff=92: people who want the speedup
> from avoiding refreshing the index with that command use

> =A0 =A0 =A0 =A0[diff]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0autoRefreshIndex =3D false

> in their configuration file, so the rest of us don=92t have to suffer
> from the confusing behavior.

> As some kind of evil compromise, it might be worth teaching gitk
> to check the same configuration and run update-index --refresh in
> getcommits{} if and only if it is unset or set to true.

> Thoughts?

That's fine as far as I'm concerned.

The current behaviour is really annoying.

If I want something fast, I do not use GUI tools. Gitk starts up
rather slowly on my box anyway.

Alexander.
