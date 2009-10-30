From: Klaus Ethgen <Klaus@Ethgen.de>
Subject: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 19:23:31 +0100
Message-ID: <20091030182331.GC10671@ikki.ethgen.de>
References: <20091029233458.GA32764@ikki.ethgen.de> <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org> <20091030165903.GA10671@ikki.ethgen.de> <20091030173838.GB18583@coredump.intra.peff.net>
Reply-To: Klaus Ethgen <Klaus@Ethgen.de>, 553296@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; x-action=pgp-signed
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org Fri Oct 30 19:50:00 2009
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Envelope-to: glddb-debian-bugs-dist@m.gmane.org
Received: from liszt.debian.org ([82.195.75.100])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3wXt-0007cQ-Sv
	for glddb-debian-bugs-dist@m.gmane.org; Fri, 30 Oct 2009 19:49:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with QMQP
	id A3AD013A5D71; Fri, 30 Oct 2009 18:49:57 +0000 (UTC)
Old-Return-Path: <debbugs@rietz.debian.org>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on liszt.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=4.0 tests=FOURLA,FVGT_m_MULTI_ODD,
	IMPRONONCABLE_2,LDO_WHITELIST,MURPHY_DRUGS_REL8,MURPHY_WRONG_WORD1,
	MURPHY_WRONG_WORD2,PGPSIGNATURE,RCVD_IN_DNSWL_LOW autolearn=failed
	version=3.2.5
X-Original-To: lists-debian-bugs-dist@liszt.debian.org
Delivered-To: lists-debian-bugs-dist@liszt.debian.org
Received: from localhost (localhost [127.0.0.1])
	by liszt.debian.org (Postfix) with ESMTP id A67A613A5D50
	for <lists-debian-bugs-dist@liszt.debian.org>; Fri, 30 Oct 2009 18:49:47 +0000 (UTC)
X-Virus-Scanned: at lists.debian.org with policy bank bug
X-Amavis-Spam-Status: No, score=-3.599 tagged_above=-10000 required=5.3
	tests=[BAYES_00=-2.599, RCVD_IN_DNSWL_LOW=-1] autolearn=unavailable
Received: from liszt.debian.org ([127.0.0.1])
	by localhost (lists.debian.org [127.0.0.1]) (amavisd-new, port 2525)
	with ESMTP id tku8Xw9btZIs
	for <lists-debian-bugs-dist@liszt.debian.org>;
	Fri, 30 Oct 2009 18:49:41 +0000 (UTC)
Received: from rietz.debian.org (rietz.debian.org [140.211.166.43])
	by liszt.debian.org (Postfix) with ESMTP id 4B9C813A5CC6;
	Fri, 30 Oct 2009 18:49:41 +0000 (UTC)
Received: from debbugs by rietz.debian.org with local (Exim 4.63)
	(envelope-from <debbugs@rietz.debian.org>)
	id 1N3wTM-0004Iy-Ty; Fri, 30 Oct 2009 18:45:16 +0000
X-Loop: owner@bugs.debian.org
Resent-From: Klaus Ethgen <Klaus@Ethgen.de>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Gerrit Pape <pape@smarden.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Fri, 30 Oct 2009 18:45:15 +0000
Resent-Message-ID: <handler.553296.B553296.12569270251066@bugs.debian.org>
X-Debian-PR-Message: followup 553296
X-Debian-PR-Package: git-core
X-Debian-PR-Keywords: 
X-Debian-PR-Source: git-core
Received: via spool by 553296-submit@bugs.debian.org id=B553296.12569270251066
          (code B ref 553296); Fri, 30 Oct 2009 18:45:15 +0000
Received: (at 553296) by bugs.debian.org; 30 Oct 2009 18:23:45 +0000
Received: from toomai.ethgen.de ([85.10.201.50])
	by rietz.debian.org with esmtp (Exim 4.63)
	(envelope-from <Klaus@Ethgen.de>)
	id 1N3w8W-0000Eq-UR
	for 553296@bugs.debian.org; Fri, 30 Oct 2009 18:23:45 +0000
Received: from home.ethgen.de ([94.247.217.2] helo=ikki.ket)
	by toomai.ethgen.de with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <klaus@ethgen.de>)
	id 1N3w8J-0006BL-R0; Fri, 30 Oct 2009 19:23:32 +0100
Received: from klaus by ikki.ket with local (Exim 4.69)
	(envelope-from <klaus@ikki.ethgen.de>)
	id 1N3w8J-0003de-9x; Fri, 30 Oct 2009 19:23:31 +0100
Content-Disposition: inline
In-Reply-To: <20091030173838.GB18583@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Resent-Date: Fri, 30 Oct 2009 18:45:16 +0000
X-Debian-Message: from BTS
X-Rc-Virus: 2007-09-13_01
X-Rc-Spam: 2008-11-04_01
X-Mailing-List: <debian-bugs-dist@lists.debian.org> archive/latest/550627
X-Loop: debian-bugs-dist@lists.debian.org
List-Id: <debian-bugs-dist.lists.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Precedence: list
Resent-Sender: debian-bugs-dist-request@lists.debian.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131727>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Am Fr den 30. Okt 2009 um 18:38 schrieb Jeff King:
> It was not exactly on purpose. The point of that change was that "git
> ls-files" should also show things mentioned in the .gitignore, because
> .gitignore has nothing to do whatsoever with tracked files.

(Mostly) true. It has when sending such patches that adds a ignored
file, to some other.

> But I simply forgot about "git ls-files -i", so changing it was an
> unintended side effect (and sadly, we don't seem to have any regression
> tests for it).

Could happen. No Problem with that as such.

> > That makes the whole sense of -i ad absurdum (I do not know how to tell
> > "ad absurdum" in english). With that patch there is no way anymore to
> > see if some ignored files are accidentally committed.
> 
> Yes, with the current code "-i" serves no purpose unless you are using
> "-o".

But this is an other use case.

> > I have to use git often as frontend for that broken design (svn). So to
> > hold the ignores up2date I use "git svn show-ignore > .gitignore" But
> > many, many repositories have broken ignores so I have to check it with
> > "git ls-files -i --exclude-standard" to see if there is accidentally
> > ignored files. Well, that patch makes that impossible at all!
> 
> Just to be clear: nothing is actually broken about ignores that cover
> tracked files. Ignores are (and have been since long before this patch)
> purely about untracked files. So there is no problem at all with:

See my comment above.

> The _only_ thing that respected such ignores was "git ls-files", and the
> point of the patch in question was to fix that.

Well ls-files is used to see such broken files. (Another example is if
you accidentally add a file which you (later) decide to be ignored. You
will have no change to find that files at all anymore.) With the patch
that use case of ls-files has been gone without a replacement.

> > So I think, this patch is a bug at all!
> > 
> > I add Jeff (and Junio as he did the commit) to the Cc. @Jeff and or
> > Junio: could you please revoke that patch?
> 
> I am not sure simply reverting is the best choice; the patch does do
> something useful. And while it strictly breaks backwards compatibility
> on the output without "-i", the old behavior was considered a bug. But
> the "-i" behavior is useless now, so we need to figure out how to
> proceed. We can:
> 
>   1. Revert and accept that the behavior is historical. Callers need to
>      work around it by dropping --exclude* when invoking ls-files.
> 
>   2. Declare "-i" useless, deprecate and/or remove. Obviously this is
>      also breaking existing behavior, but again, I don't think that
>      using "-i" actually accomplishes anything.
> 
>   3. Revert for now, and then reinstate the patch during a major version
>      bump when we are declaring some compatibility breakages.
> 
>   4. Re-work "-i" to show tracked but ignored files, but still show all
>      files when "-i" is not given at all.

I have two more options:

   5. Revert the patch and rework it to have a option to ignore or
      respect the excluded files (Such as --use-excludes for example) or
      respect them anyway if a --exclude* option is given on command
      line.

   6. Revert the patch and rework it so that it will only have effect if
      there is no -i option on the command line. (That is similiar to a
      mix of 3 and 4.)

I have nothing against the patch as such. But in the current form it
breaks at least one frequent used use case of ls-files.

> I think (4) preserves the benefit of the patch in question, but still
> allows your usage ("git ls-files -i --exclude-standard"). I do question
> whether that usage is worth supporting. Certainly I wouldn't implement
> it if I were writing git-ls-files from scratch today,

Well I had to search explicit for this use case as I had several
problems with ignored files in combination with svn. So I would. (if I
know the code good enough. And this problem to list such files did made
enough pain to me that I would go into the code to get it implemented.)

Regards
   Klaus
- -- 
Klaus Ethgen                            http://www.ethgen.de/
pub  2048R/D1A4EDE5 2000-02-26 Klaus Ethgen <Klaus@Ethgen.de>
Fingerprint: D7 67 71 C4 99 A6 D4 FE  EA 40 30 57 3C 88 26 2B
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEVAwUBSusvI5+OKpjRpO3lAQqMhQgAnM7w+VqvUB+zFCJj8sCqO6QgcI+oup1z
dMwsv+5QU+S5UH7xdm/L6AhFJEsWsbpHzytVg7Rv3wCp8OzFiXmnjfUw+3JEvuLJ
+ggWHvFeKkTReDaRY00dafAQCP/8h0Yar6hVmXfdqGeiOnK0LeN5OXx0T3K51U/2
r8YOeNPZOzbaITcRaeIi5ghAEpyAgdqEw++f8h1xCRGo6DyncUIoexmFSG0pZS8q
tsyksW7q02LscTEp6PinQa7jhUN0xWJFTvpuCBWlfNgNTTffWt1xDjXTebwRKsYR
cT1ygEiI2+aZfrE47Fn91G9I+JjF5KYo7jt5UFNFlck9YsEKGPf22g==
=2ZcU
-----END PGP SIGNATURE-----
