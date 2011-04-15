From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: git-p4 issue
Date: Fri, 15 Apr 2011 22:22:29 +0200
Message-ID: <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:22:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QApXH-0004IN-V5
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 22:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab1DOUWb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Apr 2011 16:22:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57969 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab1DOUWa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2011 16:22:30 -0400
Received: by gyd10 with SMTP id 10so964933gyd.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yxGRPxX7Ps4SK/0pFYlSMujrNZO6tkHUJeW+tCqbU4I=;
        b=QeiDpJjStbCdCddxRh1o/4HP1FuDna8iAUl9bamjpbrB0Va6UBqLTEL2zUhpbalg3P
         2HY86XOxolM40J9H2o2GSLNqgaqIGpRgAfqymiV7aBHuZnCDW5jHADag24AptKGz6YlK
         INgSRMOFkvRC7EDsDJ711u8L5sIjqETeHkLY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DP+MqBGJKwXC4YEGelPkuGg4u1UhUqOHPutmMeD62MRxwXZzzneYp44Ro8caRPsAsQ
         qM+kSTI5xkZPZA5Aw1fmpbSVW8fqRBzhwzjgy/sCMEnyBHLUiTjdfzarHNm0bZh1woYG
         Bqit2/F1TkEjSRBTDalxYqa4kItQbWU0N1Mso=
Received: by 10.42.75.196 with SMTP id b4mr3148514ick.372.1302898949507; Fri,
 15 Apr 2011 13:22:29 -0700 (PDT)
Received: by 10.42.170.10 with HTTP; Fri, 15 Apr 2011 13:22:29 -0700 (PDT)
In-Reply-To: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171638>

On Fri, Apr 15, 2011 at 5:00 AM, Michael Horowitz
<michael.horowitz@ieee.org> wrote:
> Pete,
>
> I was hoping you could help me out again.=C2=A0 After using git-p4 fo=
r a
> while without a problem, it has suddenly stopped working for me.=C2=A0=
 I am
> using the latest master.=C2=A0 I haven't seen any recent changes that=
 I
> think could have caused this, but maybe you'll have some insight.
>
> The issue is that when I do a git-p4 sync on my existing repository,
> it reports success, but seems to do nothing.=C2=A0 It does not downlo=
ad the
> latest changes from p4.=C2=A0 If I delete my repository and start ove=
r, it
> will download all the latest changes, even the ones it was not
> downloading previously, but if I try to sync again later, it does not
> do anything.=C2=A0 I tried running it with the "--verbose" mode, and =
I see
> it says it is loading each of the changes, but they are not ending up
> in the git repository, and it is not reporting any errors.

Hi, Michael.

Is it possible that you expect that 'git p4 sync' should update your
working branch and/or working tree? Assuming a simple clone with a
local master branch, running 'git-p4 sync' will update the branch
remotes/p4/master, but it won't do anything on my working master
branch...

Maybe you want to call 'git rebase p4/master' afterwards, or use the
shorthand 'git p4 rebase' to do a sync+rebase.

Regards,
Tor Arvid.

> Any ideas of what this could be?=C2=A0 Is there anything else I can r=
un to
> help debug this?
>
> Thanks,
>
> Mike
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
