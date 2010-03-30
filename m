From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 30 Mar 2010 02:10:34 -0700 (PDT)
Message-ID: <m3vdcei3bb.fsf@localhost.localdomain>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	<201003282120.40536.trast@student.ethz.ch>
	<41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
	<201003292042.01549.trast@student.ethz.ch>
	<41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 11:10:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwXTF-0004CJ-7H
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 11:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0C3JKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 05:10:43 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:40801 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972Ab0C3JKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 05:10:42 -0400
Received: by fxm23 with SMTP id 23so74598fxm.21
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=jd0jlfugaohhcw4iNHv447BFOJKQmU5QTg5iPNQH/Fs=;
        b=P5mAmhDYsMUCp4LADRg4FHLkLDaATM7DySUfmGeYWSaWmNL1PpoudP+th9UElJ8ivc
         DNA4k2BuTDIicrG55GltNFTk1sHHlyeob8xVArnmtqAZRJfq4VOaGW1wJFFQBxmgoHzX
         0E3Mx9TYw9OzPa9ytdCrVJzrafcnS4jzWrdik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Tg4I3XIiRYvOs8JvyjkHVKbqvLkJ/bHpQIsARmVHB1wNJz+pEeJa0qrauAWWsGhhwM
         h1LlWpZv3ke8eIhbGnckEoL0IwJRl+myyPhuu3d0EWjdB5EJ36BwR2WkYMwwDW2obX0g
         AWw3bVb19SEgWydp2VFuWeGl4OMfo5+fjJ2x4=
Received: by 10.87.74.17 with SMTP id b17mr2740094fgl.59.1269940237751;
        Tue, 30 Mar 2010 02:10:37 -0700 (PDT)
Received: from localhost.localdomain (abvx12.neoplus.adsl.tpnet.pl [83.8.221.12])
        by mx.google.com with ESMTPS id 16sm3737976fxm.0.2010.03.30.02.10.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 02:10:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2U99gVE007133;
	Tue, 30 Mar 2010 11:09:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2U99D07007128;
	Tue, 30 Mar 2010 11:09:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143559>

Bo Yang <struggleyb.nku@gmail.com> writes:
> On Tue, Mar 30, 2010 at 2:42 AM, Thomas Rast <trast@student.ethz.ch> =
wrote:
> >
> > Is this really the right use-case? =A0AFAICT the answer to the impl=
ied
> > question is given by simply running 'git blame -M 93fc05e:pretty.c'=
=2E
> >
> > (Coming up with a better example should be easy; the way I currentl=
y
> > think of the feature means that it will mostly replace git-blame fo=
r
> > me...)
>=20
> I will cite the same example below in the scenario. :)

By the way, it would be good to find an example with "evil merge",
which means that the change to given line(s) is in the merge commit
itself.  Correctly simplifying history in such case might be
non-trivial.

Another example that it would be good to have is "history split"
example, which means the case where some lines were consolidated
(e.g. after refactoring), and some of lines in "preimage" come
from different lines of history.

This would help with writing tests for this feature (compare tests
for blame), although they are not in my opinion necessary for the
proposal itself.
=20
I hope that all this cases would fall naturally from the
implementation.

[...]
> > Push the code somewhere public as you go, even between feature
> > completions. =A0Post RFCs once you have workable features so people=
 can
> > comment. =A0Generally try to be visible.
> >
> > Bonus points if you can think of something visible to do during the
> > period where you look at code,
>=20
> Yeah, really is a good point. And I have tried to play around on
> github.com and try to set up a http://github.com/byang/my_git for thi=
s
> purpose. :)

my_git is not very descriptive... well, unless you would do your work
on GSoC2010/line-level-history-browser branch, or something like that.

It might be good idea to have repo.or.cz as an additional repository,
as a fork of git.git repo, and with SoC / GSoC labels.  See
http://repo.or.cz/w/git.git/forks?t=3Dsoc

--=20
Jakub Narebski
Poland
ShadeHawk on #git
