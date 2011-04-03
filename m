From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 01:30:45 +0530
Message-ID: <20110403200043.GA18704@kytes>
References: <20110403172054.GA10220@kytes>
 <1301857622.3448.134.camel@lambda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6TUj-0007X7-89
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 22:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab1DCUBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 16:01:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51125 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1DCUBv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 16:01:51 -0400
Received: by iwn34 with SMTP id 34so5152845iwn.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 13:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nDVnJYp3/E6W5b7N/PiTBu9i11RRjEK8tGb1PqvAdc8=;
        b=Fbtr4gXERt/a7b8Cz3gaPT5ZZrbiSJ0AlGeQy90/DpWASsqlAOgCVKK9nE8MD0aJgv
         G7GDOU/BX8Lr/reGr3yY6ILP7uartrtRl4jQ/USXLA8BloruLWjVqZrYOxlSWLNbmisd
         wDscujkSBkTBg/uF66k9X0utVdmCf2cHmewSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UCoR2kta6OhOLhF1ZROLqCULGrjTi0x/psvjudsrVjR65G/wdtt05kJzduiTUtAsRg
         n6Wqh7wJN50aihqkXMNPs6DYWPFsKNEnhqTuj03/0XKT3+Dtn+z60nZi6r3F2zpkBuXr
         ByOh8FVkGbSalpCxj5h0axIsvtFv/vqH4xBD4=
Received: by 10.43.61.197 with SMTP id wx5mr5444106icb.286.1301860910554;
        Sun, 03 Apr 2011 13:01:50 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g4sm2950708ick.11.2011.04.03.13.01.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 13:01:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1301857622.3448.134.camel@lambda>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170780>

Hi Stephen,

Stephan Beyer writes:
> first, some notes on my git-sequencer 2008 branches that can be found=
 at
> http://repo.or.cz/w/git/sbeyer.git ... (Not sure if I remember
> everything correctly)
>=20
> I've settled to develop within the "seq-builtin-dev" branch and I
> sometimes merged Junio's "master" into that branch to catch up.
> The "seq-builtin-dev" branch is the important one.

Thanks! Jonathan told me about it earlier, and I've already started
ripping out code from the seq-builtin-dev branch :) I found your
't3350-sequencer.sh' especially interesting.

> Using git rebase -i (using git-sequencer) I sometimes remanaged the
> branch to "seq-builtin-rfc" that should represent a snapshot of a
> potential patch queue. My last rebase processes of the seq-builtin-rf=
c
> branch were pretty unmotivated and hence messy.
>=20
> I have not touched the repo very often after GSOC'08 and I stopped
> touching it (as I stopped following recent Git development) "20 month=
s
> ago" apparently. Quite many things may have changed since then.

Okay, got it.  I saw a few patches in 'master' that were based on your
work though.  Some of the patches in Christian's series also refer to
your work.

> The file A_SEQUENCER_TODO_FILE (added 2009-08-03) in the repo describ=
es
> the missing and buggy pieces to fix so that _I_ (only me) would have
> been 100 per cent satisfied with that git-sequencer.
> http://repo.or.cz/w/git/sbeyer.git/blob/9e4b4d92f681a47e3d7ad2152d239=
1b2ab125a0c:/A_SEQUENCER_TODO_FILE
> [Some notes are also "strategy notes" to get things accepted, like th=
e
> changes on "rebase -i -p" which are "not loved by everyone". ;-)]

Okay.

> On 2011-04-03, 22:50 +0530, Ramkumar Ramachandra wrote:=20
> > * Is this a good change? Are there any forseeable issues?
>=20
> I want to mention an issue that I have not foreseen before: merges.
> (You need merges, for example, when doing rebase -i -p ... -p as in
> --preserve-merges.)

Ah, that's not something I thought about immediately.

> When I began, there was code in the "next" branch that added the TODO
> instructions "mark", "reset" and "merge" to do merges properly and I
> based my work on it. The original pieces by J=F6rg Sommer can still b=
e
> found here:
> http://repo.or.cz/w/git/sbeyer.git/shortlog/6fabd85e8a777c26f3ae8ce11=
cb7f4265502ea7f
>=20
> However, there have been strong opinions that the "mark"/"reset"/"mer=
ge"
> instructions are ugly and unpleasant to users and not even necessary =
(at
> least for rebase--interactive... and for sequencer, maybe, maybe not)=
=2E=20
> Hence, the code in "next" has been rejected later.

Interesting historical note.

> During GSOC 2008 I regrettably underestimated the importance to
> communicate with the Git folks about these things. That's one of the
> main reasons the sequencer pieces did not get into master. And after
> GSOC'08 I had too little time for this... :-/
>=20
> Well, the merging thing is the only *real* issue I remember.

Point noted.  Yes, I noticed that your sequencer was mostly
functionally complete.  I'll make sure that I spend a lot of
interacting with the community.

Thank you for your elaborate note! I really appreciate it :)
Hopefully, we will have that sequencer by next year.

-- Ram
