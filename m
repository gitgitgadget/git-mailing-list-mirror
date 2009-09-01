From: David Chanters <david.chanters@googlemail.com>
Subject: Re: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Tue, 1 Sep 2009 17:58:36 +0100
Message-ID: <ac3d41850909010958l890bf2fyda6e61e3cb082c2a@mail.gmail.com>
References: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
	 <7v8wgzla02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiWh2-0001UB-VJ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 18:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbZIAQ6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 12:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755171AbZIAQ6f
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 12:58:35 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47365 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170AbZIAQ6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 12:58:34 -0400
Received: by bwz19 with SMTP id 19so130481bwz.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cHus7vnJCNtLM0Ff8G0YWqoLW2LtlRv1Ohw+vteJ010=;
        b=lUAecriow+//e42ezBtXoT/CLerrCmf0rObu1RTnQiXFJm9HsnpuCQoQnH6gYbSQvS
         XmaN+RrUXeilEASaLtv4kZctVeiERKvx7TR2vd0iFa/tMjFBG3b+No64Dm3ZMgmLXOjp
         oykwjI+vKIu0g/BAt8f9TWv1TQGTNUpeIL/Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UvH4TiGVa7fDjdBqnR5zacrxmPnPZFPZmx/AT/6PZkCTp8G5iMAlcfGHxgnrjy8p5u
         zxOak0U2Yx9aqO/9+JDqQrQrJbJo8m4IHtRzy9ql2kxgzeBfEx7e5o8CHGKBEPTQahfM
         wMf9EkN+rAqb+tLf227PXSmnn9N1BxKNPmGzA=
Received: by 10.223.1.18 with SMTP id 18mr2866212fad.90.1251824316216; Tue, 01 
	Sep 2009 09:58:36 -0700 (PDT)
In-Reply-To: <7v8wgzla02.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127546>

2009/9/1 Junio C Hamano <gitster@pobox.com>:
> =A0 =A0$ git log --oneline --first-parent origin/master..origin/pu
>
> would be a handy way to view where the tip of each branch is.

Yes it is - thanks for that!  I presume that (in other workflows --
not necessarily git,git's) that using git-resurrect.sh would be
preferable to the git-log suggestion above if the topic branch wanting
to be "resurrected" had several merge points?

> So if you for example happen to be interested in jc/log-tz topic,
> you would do something like:
>
> =A0 =A0$ git checkout -b jc/log-tz 2178d02^2
> =A0 =A0$ git log -p master..
>
> to check out, and view what changes the topic introduces.

This is really useful - thank you - it's solving a missing piece of a
puzzle for me.  :)

> where "ai" is typically the author's initial, and topic-name names th=
e
> topic just like you would name a function. =A0A topic typically forks=
 from
> the tip of master if it is a new feature, or a much older commit in m=
aint
> if it is a fix (and in such a case, topic-name typically begins with
> a string "maint-").

Makes sense - and on that note - in our current workflow of using Git,
we have a feature branch, call it "featureA" which is forked from
"master" (where our stable code lives) -- but obviously over time, if
bugfixes happen and get released, what do we do about then ensuring
that featureA also benefits from these bug-fixes?  Since invariably
people will want to develop using the bug-fixes, but "featureA" long
since branched from "master" at a point in the past, before the
bug-fixes?

What do you do, about this when handling topic branches merged into
next, or doesn't it really matter by that point?

[...snip really useful explanation...]

I can't thank you enough, Junio for this -- you've effectively ironed
out a workflow here I think I can now go away and start using -
thanks.  :)

David
