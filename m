From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Tue, 30 Oct 2012 19:10:14 +0100
Message-ID: <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 30 19:10:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGGl-0005xU-TQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196Ab2J3SKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:10:17 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53204 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964822Ab2J3SKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:10:15 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so553170oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jLdxETYrEH2jeNrxrO3AxKgjF6t9tk5zfNhmK1zRH68=;
        b=qdYgHVA+VzuavyVUqvDyxeVKDK4fm3DOT/FJo5SQhve4NfS2sIMFLQscLk12uAqJUv
         +GRaXS5eQ7lOjm7cvIzvABNTaSTbh6QYSU3yZP+4Ln/mOD/RAOW3rfKYJmTRBbbbyS2g
         eDXpNCklu7Rpj7KEyR5kYU6ktXJcp+sdqcqLhcLNJ8Wm19iYSXO2ewYTULSF/CZfDVDv
         ggZ421gdwheGfUateF4JZ4ygo8rhQkRI0130ZxdStRxCrJ2aA8plpFMqvBd/6wUrvpNY
         Dk2C8Lo8Vpmnh7LAgimxlcB5I+udbDKiXx/cb2aogX96G3CJDhPm2FwtFgD2Wel2Ir/Y
         Y+jw==
Received: by 10.182.52.105 with SMTP id s9mr28477641obo.25.1351620614411; Tue,
 30 Oct 2012 11:10:14 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 11:10:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208715>

On Tue, Oct 30, 2012 at 6:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> P.S.: I would still recommend to have a detailed look at the 'devel'
> branch, in particular the commits starting with "fast-export: do not refer
> to non-existing marks" and ending with "t5801: skip without hg". My
> understanding is that it was completely ignored after a brief and maybe
> too-cursory look. In the least, it has a couple of lessons we learnt the
> hard way, and if git.git is dead set on duplicating the work, making these
> mistakes again could be avoided by learning from our lessons.

% g l --grep="t5801: skip without hg" devel
1e000d4 t5801: skip without hg
bee410c t5801: skip without hg
5cdc7d0 t5801: skip without hg
05b703f t5801: skip without hg
6bb8d90 t5801: skip without hg
c70b4d0 t5801: skip without hg
2f46371 t5801: skip without hg
39bc40f t5801: skip without hg
d0a618b t5801: skip without hg

% g l --grep="fast-export: do not refer" devel
d3ac32c fast-export: do not refer to non-existing marks
bdbb22f fast-export: do not refer to non-existing marks
5d99930 fast-export: do not refer to non-existing marks
381f276 fast-export: do not refer to non-existing marks
b4686c7 fast-export: do not refer to non-existing marks
e3dfe01 fast-export: do not refer to non-existing marks
c00fe59 fast-export: do not refer to non-existing marks
ce357ce fast-export: do not refer to non-existing marks
5c1c7a4 fast-export: do not refer to non-existing marks
9c827d1 fast-export: do not refer to non-existing marks

I'll assume you are referring the latest ones:

% g log --oneline --reverse d3ac32c^..1e000d4
* d3ac32c fast-export: do not refer to non-existing marks

Not needed at all.

* b013fe0 setup_revisions: remember whether a ref was positive or not
* fb89a2c fast-export: do not export negative refs
* 7655869 setup_revisions: remember whether a ref was positive or not

I've fixed this problem already.

The solution proposed in these patches is to convoluted:
1) Requires multiple unrelated changes
2) Proposes change in committish semantics

It's hard to test, because the test to check for this is not in this
patch series, and it's testing for something completely unrelated:

---
cat > expected << EOF
reset refs/heads/master
from $(git rev-parse master)

EOF

test_expect_success 'refs are updated even if no commits need to be exported' '
        git fast-export master..master > actual &&
        test_cmp expected actual
'
---

This is most certainly not what we want.

Notice that in my patch (a single patch) I added the tests at the same
time so it's clear what it's fixing, and I also added a test to the
relevant remote-helper behavior we want:

https://github.com/felipec/git/commit/76e75315bd1bd8d9d8365bb09261a745a10ceae0

* 512cb13 t5800: test pushing a new branch with old content

If this is what the patches above were trying to fix, then yes, my
patch fixes that. Also, it's tainted by changes from another patch.

* a85de2c t5800: point out that deleting branches does not work

Correct, but hardly _necessary_.

* 2412a45 transport-helper: add trailing --

No description what's the problem, or what it's trying to fix, or
tests, so it's not possible to know if this is _needed_ or not. But
probably correct.

* 026d07c remote-helper: check helper status after import/export

Again, no explanation, but the issue was already addressed:

http://article.gmane.org/gmane.comp.version-control.git/208202

The problem is minuscule, not _needed_.

* 5165e26 remote-testgit: factor out RemoteHelper class
* 049f093 git-remote-testgit: make local a function
* f835bb2 git_remote_helpers: add fastimport library
* 088ad33 git-remote-hg: add hgimport, an hg-fast-import equivalent
* 7de6ca0 git-remote-hg: add GitHg, a helper class for converting hg
commits to git
* e3cc5ed git-remote-hg: add hgexport, an hg-fast-export equivalent
* 0edc8e9 git-remote-hg: add GitExporter/GitImporter/NonLocalGit
* 5c73277 remote-hg: adjust to hg 1.9
* 1b47007 git-remote-hg: add the helper
* 4dcc671 git-remote-hg: add tests
* 48b2769 remote-hg: Postel's law dictates we should handle Author<author@mail>
* 2587cc6 remote-hg: another case of Postel's law
* 9f934c9 remote-hg: handle another funny author line from
http://scelenic.com/hg
* a799904 remote-hg: do not interfer with hg's revs() method

All these are specific to this remote-hg version.

* ac77256 Always auto-gc after calling a fast-import transport

This might be a good idea, but not _needed_.

* 1e000d4 t5801: skip without hg

Specific to this remote-hg.


So, yeah, nothing really needed there. Some patches might be nice, but
that's it.

Now, if this is really the latest and greatest remote-hg patch series,
I can try to port them to git's master and see how it fares.

But you mentioned something about cooperation, and I've yet to see how
is it that you are planning to cooperate. If you say you don't have
time to spend on this, I don't see why I should worry about testing
this series of patches.

Also, you seem to be clearly against my implementation, is there any
evidence that will convince you that my version is "good"? Maybe my
version passing more tests than msysgit's? Or is there truly nothing I
can do to change your perception?

Cheers.

-- 
Felipe Contreras
