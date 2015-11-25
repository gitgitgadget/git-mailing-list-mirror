From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/5] Submodule Groups
Date: Wed, 25 Nov 2015 18:50:35 +0100
Message-ID: <5655F4EB.2010900@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, ericsunshine@gmail.com,
	j6t@kdbg.org, hvoigt@hvoigt.net
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 18:51:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1eDq-0001o6-Ci
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 18:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbbKYRvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 12:51:11 -0500
Received: from mout-xforward.web.de ([82.165.159.34]:59273 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbKYRvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 12:51:07 -0500
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 12:51:06 EST
Received: from [192.168.178.41] ([79.211.124.82]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lrruc-1aTSd22dp8-013et5; Wed, 25 Nov 2015 18:50:42
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1448415139-23675-1-git-send-email-sbeller@google.com>
X-Provags-ID: V03:K0:zvNd7mM8buCKnW/FG2hbQieKVZr6niU4jxp6dlxyxhIG2wO1i52
 TyBQ+NSzy7owEbp7Nn56rG5uEm5MO/Xz+rU9xXulkDTkymfM3NNncOjGGTQMM0HnyBfxsyP
 D13aM+BBYJUcuWGIapuCvU/UtvfH4AuCS6XyzLuI0Hfe5wxOw8eVkaJ22k34dthdpgmhH21
 BOonOKJlTAM/8B4+JqRbw==
X-UI-Out-Filterresults: junk:10;V01:K0:QC1RKQbpapA=:9DDghHJVhGRGD/b9V/ehvZ0D
 C4MC2EjeeQCjNfQJHq6F+4buZMzS7s4CnS9R5PqURj/uzO1hpeZKb4alRlrPxTIldkiq/zOen
 pvmJ0bpPHoHjwAEesHSJomeRFxT9f704ayXUPA+CHqo7jjNp/E2rvtW7vsGly2YalaC864AXi
 VYrsMe/WE39j9F2QGrMdLOXqbUU4UySY4xDevU7+Aot3SzSQATBWFyPLWZCLL/x/+lK5mqoF7
 GFiKe679iCaJ1/8wRP8In//2JPxPire9Fi5w1APzploXt2KFqyug4wp8dAHeEsNoPtJfMauKB
 KzDrOyrXwRliaKvu5anUkkgtDd6eecsv5pOOP1k2ZFOx+sN1xtWVURlxch98/1bC3VQGgEFX4
 DTGXnTalTHpN0T2BCxjf8/DkncUQRys2tpRXOeBEu8H7TB8JVBfQpsCrLzbDoFNj8kvUsQAF6
 yoiUQKPdelSwXg9J06zOF2lbdWpbeNG9AAzEAzjq4u+fcnk7aozjhyGDFAvTKyxQ97fb65BqB
 RnVsrGpMeEV0t+5fAmWgbL/cnJGNVM89Cqg0o5CHY1UWybnd/BhojnL1JinsLyOOYcANmyefr
 KaQFbf6b69ShelccPdPzYbc6CNgc2hmehr3432f3Xxre9Tzy2ICq/98jMhBtGiax1b3oY/mck
 wmP4ib5deEFxeeh8Gs3feTdjh1di7Ow9GKJDbfLVgASGFLaK3jZ3wrwixLesZs5CcskWhjC4Y
 t2BqQIDLHSxnhvhyJXblsB9buSdAY1tdOqgMNYsrHzYjiM5CBCla4ydYHSLy33OOE7wixDQG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281720>

Am 25.11.2015 um 02:32 schrieb Stefan Beller:
> This is also available at https://github.com/stefanbeller/git/tree/submodule-groups
> It applies on top of the submodule-parallel-patch series I sent a few minutes ago.
>
> Consider having a real large software project in Git with each component
> in a submodule (such as an operating system, Android, Debian, Fedora,
> no toy OS such as https://github.com/gittup/gittup as that doesn't quite
> demonstrate the scale of the problem).
>
> If you have lots of submodules, you probably don't need all of them at once,
> but you have functional units. Some submodules are absolutely required,
> some are optional and only for very specific purposes.
>
> This patch series adds meaning to a "groups" field in the .gitmodules file.
>
> So you could have a .gitmodules file such as:
>
> [submodule "gcc"]
>          path = gcc
>          url = git://...
>          groups = default,devel
> [submodule "linux"]
>          path = linux
>          url = git://...
>          groups = default
> [submodule "nethack"]
>          path = nethack
>          url = git://...
>          groups = optional,games

Yup. Do you want the user to select only a single group or do you
plan to support selecting multiple groups at the same time too?

> and by this series you can work on an arbitrary subgroup of these submodules such
> using these commands:
>
>      git clone --group default --group devel git://...
>      # will clone the superproject and recursively
>      # checkout any submodule being in at least one of the groups.

Does this automatically configure the given group in .git/config, so
that all future submodule related commands know about this choice?
Me thinks that would make sense ...

>      git submodule add --group default --group devel git://... ..
>      # will add a submodule, adding 2 submodule
>      # groups to its entry in .gitmodule

Maybe '--groups default,devel' is easier to grok? Dunno.

>      # as support for clone we want to have:
>      git config submodule.groups default
>      git submodule init --groups

Hmm, I doubt it makes much sense to add the --group option to "git
submodule init". I'd rather init all submodules and do the group
handling only in the "git submodule update" command. That way
upstream can change grouping later without having the user to
fiddle with her configuration to make that work.

>      # will init all submodules from the default group
>
>      # as support for clone we want to have:
>      git config submodule.groups default
>      git submodule update --groups
>
>      # will update all submodules from the default group
>
> Any feedback welcome, specially on the design level!
> (Do we want to have it stored in the .gitmodules file? Do we want to have
> the groups configured in .git/config as "submodule.groups", any other way
> to make it future proof and extend the groups syntax?)

Not sure what exactly you mean by "it" here ;-)

Talking about what groups a submodule belongs to, an entry in the
.gitmodules file makes the most sense to me. That way upstream can
change submodule grouping or add new submodules with group assignments
from commit to commit, and "git submodule update" will do the right
thing for the superproject commit checked out.

And I believe that the choice which group(s?) the user is interested
should be recorded in .git/config, as that is his personal setting
that shouldn't be influenced by upstream changes.
