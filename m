From: Michael Witten <mfwitten@gmail.com>
Subject: =?UTF-8?Q?Re=3A_Groups_of_commits_=28=C3=9Cbercommits=29?=
Date: Wed, 28 Apr 2010 03:35:07 -0500
Message-ID: <l2nb4087cc51004280135hdb8d3c7cjd53aca912840b6bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 10:35:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O72k9-0004EX-Q7
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 10:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab0D1Ifb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Apr 2010 04:35:31 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38678 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0D1If3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Apr 2010 04:35:29 -0400
Received: by bwz19 with SMTP id 19so293936bwz.21
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=nNfI6xDZjRgSRWV9hltE0R0EbVBwX7OVO8nfZIAWRac=;
        b=FumBDkSNHjSeT4qrpMKXCFIIodMrbhAotMJjumXsnbb4W31AkKqf80+hnvCPx+0P1G
         kCm4EYljHBVhktxWwqwT2JTlU6r+spoFy6rum9aVP2LZd5LgRXLhwwMqk2+0zVxPVQK5
         5dM1KgbOCFgOPlMn3Ej7v0Cj5fEJbxHMFSSjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Sjh0ThdlBNSR/yXQT7tIarehgy+sNO8RYSN7GupibdaPY3gosDDBK1OvzYooqNl+Uv
         xDEhKjN6g0ig/dPaNAC7f6+eTeFSqYCQhjMGaWXHqQmkhsEAInXEbYjNFMRrmmylJeSK
         SfqxS7QeG6UxYKTFdgH1t1B1fCw9q8F2RGzI8=
Received: by 10.239.193.6 with SMTP id g6mr662027hbi.212.1272443727193; Wed, 
	28 Apr 2010 01:35:27 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Wed, 28 Apr 2010 01:35:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145975>

On Tue, Apr 27, 2010 at 20:59, John Tapsell <johnflux@gmail.com> wrote:
> =C2=A0It would be nice to have a commit in the repository, treated as=
 a
> single commit for all purposes, but then be able to split it into
> multiple commits if necessary.
>
> =C2=A0Any ideas?

Just for the record, I brought up such an idea in another thread; I
called them =C3=BCbercommits:

    http://marc.info/?l=3Dgit&m=3D126470903523316&w=3D2
    http://marc.info/?l=3Dgit&m=3D126471007125357&w=3D2
    http://marc.info/?l=3Dgit&m=3D126471096827004&w=3D2

Specifically:

On Thu, Jan 28, 2010 at 15:03, Michael Witten <mfwitten@gmail.com> wrot=
e:
> I've been thinking for a while that it would be useful to
> have =C3=BCbercommits (they don't exist) that are treated like single
> commits but that actually encapsulate multiple continguous commits.
>
> ...
>
> These =C3=BCbercommits would also allow developers to make a string o=
f
> commits that by themselves break things but together formulate a
> complete solution; because the =C3=BCbercommits encapsulate the break=
age,
> bisection would still be simple (no fear of dealing with broken
> commits), but the small manageable commits would still be available
> for references and manipulation.
>
> Perhaps trees could be reappropriated for the implementation of =C3=BC=
bercommits.

On Thu, Jan 28, 2010 at 15:20, Michael Witten <mfwitten@gmail.com> wrot=
e:

> In fact, the commit message body is already being used to create
> unofficial =C3=BCbercommits. Consider a common merge commit from a
> clone of Linus's Linux repo:
>
>    commit e80b1359858df17b0034bdf7d1b6f3e0d5b97257
>    Merge: 341031c b27d515
>    Author: Linus Torvalds <torvalds@linux-foundation.org>
>    Date:   Thu Jan 21 08:50:04 2010 -0800
>
>        Merge branch 'perf-fixes-for-linus' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/tip/linux-2.6-tip
>
>        * 'perf-fixes-for-linus' of git://git.kernel.org/pub/scm/linux=
/kernel/git/tip/linux-2.6-tip:
>          perf: x86: Add support for the ANY bit
>          perf: Change the is_software_event() definition
>          perf: Honour event state for aux stream data
>          perf: Fix perf_event_do_pending() fallback callsite
>          perf kmem: Print usage help for unknown commands
>          perf kmem: Increase "Hit" column length
>          hw-breakpoints, perf: Fix broken mmiotrace due to dr6 by ref=
erence change
>          perf timechart: Use tid not pid for COMM change
>
> It seems like this kind of useful information should be a more
> integral part of the metadata.
>
> Indeed, it seems like commit messages are often used for metadata
> that git perhaps *should* handle natively, like sign-offs and
> multiple Authors, etc.
>
> Of course, I'm betting that git doesn't handle such things
> officially because it would require more general data structures
> (especially for variable numbers of Authors) and thus slower
> algorithms.

On Thu, Jan 28, 2010 at 15:35, Michael Witten <mfwitten@gmail.com> wrot=
e:

> On Thu, Jan 28, 2010 at 2:03 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> These =C3=BCbercommits would also allow developers to make a string =
of
>> commits that by themselves break things but together formulate a
>> complete solution; because the =C3=BCbercommits encapsulate the brea=
kage,
>> bisection would still be simple (no fear of dealing with broken
>> commits), but the small manageable commits would still be available
>
> As a corollary to this, developers can maintain patch integrity.
>
> Quite often, I've sent a patch off to some project only to have
> the maintainer `tweak' the result before making a commit. However,
> I frankly don't want my name attached to someone else's work,
> because I may disagree with what has been done.
>
> Were =C3=BCbercommits available, the maintainer could commit my origi=
nal
> work and then make a new `tweak' commit and then bundle the 2 togethe=
r
> as an =C3=BCbercommit in order to encapsulate this series of events.

Sincerely,
Michael Witten
