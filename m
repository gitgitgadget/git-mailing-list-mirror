From: Scott Chacon <schacon@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sat, 5 May 2012 15:38:31 -0700
Message-ID: <CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
 <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 06 00:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQnd2-0000dg-2K
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 00:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895Ab2EEWi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 18:38:58 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:62438 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab2EEWiw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 18:38:52 -0400
Received: by qabj40 with SMTP id j40so2718882qab.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9a/SKGJocLz1HYFyfteQ6pQHxkA3aGPmuXnBssyOjvs=;
        b=DJAoYyuBnXKtlNLVpU66wEkNiQRbXG7yVayNVW14R0TdfgpsWHvdvTiEQMFKv/xXy+
         YbRNTmaIQUBGXtCLBz3fdd0qkKEOetUUd+B5+n+Z0kq1smhZ/FvN54qN+LrOWewq0mJj
         pfmPYOKdOLd92HdwD7t10zojQ02iOlht5TZxAcsu2jfpH2CloyvaUDH/q6EuqWcHeg0N
         L+008Q37j2MZdwoR9IouSD37LWgTzgv9/qEuN3vVfogKsBpUBIwURBvGqUvzDg32CgKC
         /ktXZakIvTYwIHTYMzvtkTkdpM1y+gWGCNEIsFzGjTnIeYpdL4D8M5r5xASJXktV4NTV
         +/mg==
Received: by 10.224.117.6 with SMTP id o6mr11146624qaq.18.1336257531573; Sat,
 05 May 2012 15:38:51 -0700 (PDT)
Received: by 10.229.251.142 with HTTP; Sat, 5 May 2012 15:38:31 -0700 (PDT)
In-Reply-To: <7vd36j8lc3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197139>

Hey,

On Fri, May 4, 2012 at 6:31 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
> Thanks. =C2=A0The Reference Manual area lists "apply" in a very funny=
 place.
> It should go together with "diff", whichever section you decide to pu=
t
> "diff" in. =C2=A0As "diff" is listed in "Basic Snapshotting", and it =
will not
> be able to achieve that without being able to apply its output back t=
o the
> working tree or to the index, I would suggest moving "apply" to the
> section as well.

I have to disagree.  You are thinking of 'apply' from an internals
perspective I have to assume, because I use 'diff' every single day
for all sorts of stuff ("what is modified and unstaged?", "what is
modified and staged?", "what is different between these two branches?"
etc) where I can't think of a single time I've ever used 'apply'.  In
fact, even the times when I have needed to apply a patch generated
from 'diff' I used 'patch -p1' because I know it better.  I, and most
people I would guess, almost never use 'diff' to generate patch files,
we use it to see what has changed before committing or things like
that - in general usage, it's more like an advanced 'status' honestly.

> I am fairly happy about the look of the new site except for a few thi=
ngs
> ;-).
>
> It seems that you are trying to advocate "staging area" as some sort =
of
> official term. =C2=A0I think "it is like a staging area" is a good ph=
rase to
> use when answering "what is the index?", but I think repeating it mil=
lion
> times without telling the casual readers what its official name is is
> counterproductive. =C2=A0Don't do that. =C2=A0It will confuse these s=
ame people when
> they start reading manuals.

I'm not really trying to advocate it as much as using terminology that
is already quite popular.  It's true that it's not what is used in the
man pages, but neither is 'index' used consistently - there is 'cache'
too, in addition to 'index' having two meanings - packfile and cache.
I'm open to making things clearer, but I just don't think that
changing the terminology to something more technical and vague would
be overall less confusing to people.

That said, in most places I use phrases like 'Git has something called
the "staging area" or "index"' letting people know that there are
multiple phrases for it and what it's technical term tends to be.  So
your "without telling the casual readers what its official name is" is
generally not true - I do try to do that too.

Scott
