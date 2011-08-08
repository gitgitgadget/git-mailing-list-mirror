From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: repository of handy git aliases?
Date: Mon, 8 Aug 2011 20:43:01 +1000
Message-ID: <CAH3AnrrNPBNNNr7Lm2-vnqOisxWorF4FS32H+LBaybWF3KdnGg@mail.gmail.com>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com>
	<CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
	<CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 12:43:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqNIb-0005LR-CD
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 12:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab1HHKnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 06:43:05 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39908 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1HHKnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 06:43:02 -0400
Received: by vxi9 with SMTP id 9so2340544vxi.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FoL83oJ12tLUb9KZpFBQtFelJEWtVNSlIrhxTQaWSM0=;
        b=YTS9e+l1+RX58JcdkuVltTHsvumMZ/hX2pN7ERQ1x5+gu4me852houE6uG43+WebOV
         Rr+LWfA+9/6FVPzb9Vf0G/C8Ms272azcYaPXhqovqLNsjnPc9Fd+YaFB1GztXrLTiIzl
         l2wlIPHDRnapp8Oh5rtwP+FgY27850uVj5Pu4=
Received: by 10.52.27.171 with SMTP id u11mr5608440vdg.131.1312800181659; Mon,
 08 Aug 2011 03:43:01 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Mon, 8 Aug 2011 03:43:01 -0700 (PDT)
In-Reply-To: <CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178952>

On Mon, Aug 8, 2011 at 8:22 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.com=
> wrote:
>> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:

I've also added this...

Listing the tips of branches in pu that are not in master
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Suppose you have two aliases defined like so:

[alias]
        oneline =3D !/usr/bin/xargs -L1 git log --decorate --max-count=3D=
1 --oneline
        tips =3D "!_() { t=3D$(git rev-list --no-merges --max-count=3D1
\"$@\"); if test -n \"$t\"; then echo $t; _ \"$@\" ^$t; fi; }; _"

Then:

git tips origin/pu ^origin/next | git oneline

might show something like this:

9dcca58 filter-branch.sh: de-dent usage string
704c335 On Cygwin support both UNIX and DOS style path-names
1c460f9 t3030: fix accidental success in symlink rename
9e81372 test-path-utils: Add subcommand "prefix_path"
ad733bd revert: Propagate errors upwards from do_pick_commit
76cf946 fixup! xdiff/xhistogram: rework handling of recursed results
df6a9c7 fixup! describe: Refresh the index when run with --dirty
c9f57a0 squash! ls-files: fix pathspec display on error
a1288bc add--interactive: add option to autosplit hunks
365b78a t5800: point out that deleting branches does not work
c997182 limit "contains" traversals based on commit generation
914b6fb doc/fast-import: document feature import-marks-if-exists
b792c06 branch -v: honor core.abbrev
b166408 mergetool: Don't assume paths are unmerged
b29d76f merge: mark the final "Merge made by..." message for l10n
942cf39 receive-pack: Allow server to refuse pushes with too many objec=
ts

which is a list of the tips of branches that are in pu, but not in next=
=2E
