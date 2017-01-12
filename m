Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88F1320756
	for <e@80x24.org>; Thu, 12 Jan 2017 11:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbdALLP2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 06:15:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:49181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751209AbdALLP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 06:15:27 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lrek1-1cbIQc38zV-013QqQ; Thu, 12
 Jan 2017 12:15:11 +0100
Date:   Thu, 12 Jan 2017 12:15:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
In-Reply-To: <xmqqinpmpld0.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701121130190.3469@virtualbox>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>        <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
        <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net> <xmqqinpmpld0.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TAqnROssC16Gq5e2GZ2bIlq3lBBufzEL3pXBFFvzuec7BJuC0dP
 nGwIyBhHIW7o7iX3+o0Zc6kB3McguxXkb5BvKYVlyAe144IhyJJ94N6QNKrqAC6fvbrM6wX
 fi0InM0DbSZEw12rm6Vu/oq7MsCOEg6QrRDe4hEfXE1h3vYzwgvycCBJ+8yvxfls+lqkQdd
 am801seQtOeV6+ETVMYjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jpUaaOjJxW8=:FTTI8j7BZW6flt502EAs/P
 ygiCI2q5QkOmJyQxFIwRaGFSVVO1rms3/ZJhOtcOVFWEQsrMmBQo3zB80/SRrRv9TIDh5lQ/a
 Q6VmcjswyfzYudWTwqPEkSpi00d0oKLjUqhcHZfYHDHoVRpPJ9edRaXY1VHj7L3hl0lEHSCV1
 t8F+gkNO+W2ZjpGegFkqo79D9U2qrLc0YR/pAxCXD1SwrTistOzSGJJ718cL2yiNBvPzOBCTd
 bqafYxCfApF5obPfbAB/lOSS+TPi0N3gPgNuIHvFwdzIRE3dQmIJAC+YbZcyWbHWx8/MAfvDd
 TV1AZCf6MjI1YikmEg/snIfJzOw8xBWpo3NMo9HiytA5H/4h0xR/rZGqZFDuFqz5pKoVHweiF
 8PPpDgcbiDlMEI8d00gU9uKwGAPyr6BbXs83sTuY1Kzi47bVqGi4HNsHHnU92pnrqU9q8Ugcf
 FprP6hEnuoYF9pmZUuN22DiwExH0wxLsuqKza6dJqlbjKnjhax+YD346QlzmrWniLD457fVBi
 62U4khSt/XABJniOmCiYbTPPZr+aW9iABFTbGW24ZdzReejGnryg00TLJyF6XJqS2lSRHcOhW
 Y4g4O8AwGUDwqkCHVYYf1MQ2plMqp9ZP74rZ4vgza7geWuwqwmRi5ZtoeitsvrFthwM6pxHiM
 JyIgoZVczcuf3zJCrNuIp8zMLV3gQsJQnhxQziu84OC/u92JOZXlMvkg+fFeZV1p4Iwvmc+0I
 hosGVpwvN9jy1/W2XoXfiKXC7clUXM1TCHO5J4oKDfx109XvrwnLTcUBEqDwK0UpGDvIGQS6S
 /LL2aU6rb1uz2yj1Emx8Re1uC3ZIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 10 Jan 2017, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Jan 07, 2017 at 02:03:30PM -0800, Junio C Hamano wrote:
> >
> >> Is that a longer way to say that the claim "... is designed as a
> >> book" is false?
> >> 
> >> > So I dunno. I really do think "article" is conceptually the most
> >> > appropriate style, but I agree that there are some book-like things
> >> > (like appendices).
> >> 
> >> ... Yeah, I should have read forward first before starting to insert
> >> my comments.
> >
> > To be honest, I'm not sure whether "book" versus "article" was really
> > considered in the original writing. I think we can call it whichever
> > produces the output we find most pleasing. I was mostly just pointing at
> > there are some tradeoffs in the end result in flipping the type.
> 
> I understand.  
> 
> And I tend to agree that the silliness you observed (like a t-o-c
> for a one-section "chapter") is not quite welcome.
> 
> For now I queued only 2/2 which looked good.  I won't object if
> somebody else rerolls 1/2 to appease AsciiDoctor, but let's take an
> obviously good bit first.

For fun, I just reverted the article->book patch and I was greeted with
this:

-- snip --
    ASCIIDOC user-manual.xml
asciidoctor: ERROR: user-manual.txt: line 44: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 477: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 477: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 477: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1003: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1003: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1003: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1003: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1720: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1720: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1720: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1720: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 1720: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2462: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2462: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2462: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2462: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2814: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2814: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2814: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2958: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2958: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 2958: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3514: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3514: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3514: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3771: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3771: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 3771: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4147: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4147: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4147: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4395: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4395: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4395: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4401: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4401: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4636: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4636: only book doctypes can
contain level 0 sections
asciidoctor: ERROR: user-manual.txt: line 4636: only book doctypes can
contain level 0 sections
-- snap --

It still builds, funnily enough, but the result is definitely worse on the
eyes. The page is *really* long, and structuring it into individual parts
does help the readability.

Compare for yourself: https://dscho.github.io/git/index.html (this will go
away at some point in the future, but I do not think there is a way for me
to send two 200+kB HTML files to the Git mailing list).

Ciao,
Dscho

P.S.: I also tried to use [glossary] and [appendix] as appropriate, but it
seems that AsciiDoc *insists* on level-2 sections in an appendix, while
AsciiDoctor *insists* on level-3 sections. In other words, the following
diff on top of my patch series yields the warning "asciidoc: WARNING:
user-manual.txt: line 4411: section title out of sequence: expect
ed level 2, got level 3" with AsciiDoc, while AsciiDoctor is totally
happy:

commit 900e193f15d5d2ef32285b1db9eb24c10710b7c1
Author: Johannes Schindelin <johannes.schindelin@gmx.de>
Date:   Thu Jan 12 12:06:16 2017 +0100

    fixup! asciidoctor: fix user-manual to be built by `asciidoctor`

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bc29298678..c1ab6ce453 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4392,25 +4392,23 @@ You see, Git is actually the best tool to find out
about the source of Git
 itself!
 
 [[glossary]]
+[glossary]
 Git Glossary
 ============
 
-[[git-explained]]
-Git explained
--------------
-
 include::glossary-content.txt[]
 
 [[git-quick-start]]
-Appendix A: Git Quick Reference
-===============================
+[appendix]
+Git Quick Reference
+===================
 
 This is a quick summary of the major commands; the previous chapters
 explain how these work in more detail.
 
 [[quick-creating-a-new-repository]]
 Creating a new repository
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 From a tarball:
 
@@ -4432,7 +4430,7 @@ $ cd project
 
 [[managing-branches]]
 Managing branches
------------------
+~~~~~~~~~~~~~~~~~
 
 -----------------------------------------------
 $ git branch	     # list all local branches in this repo
@@ -4497,7 +4495,7 @@ $ git branch -r			# list all remote
branches
 
 [[exploring-history]]
 Exploring history
------------------
+~~~~~~~~~~~~~~~~~
 
 -----------------------------------------------
 $ gitk			    # visualize and browse history
@@ -4533,7 +4531,7 @@ $ git bisect bad		# if this revision is bad.
 
 [[making-changes]]
 Making changes
---------------
+~~~~~~~~~~~~~~
 
 Make sure Git knows who to blame:
 
@@ -4564,7 +4562,7 @@ $ git commit -a	   # use latest content of all
tracked files
 
 [[merging]]
 Merging
--------
+~~~~~~~
 
 -----------------------------------------------
 $ git merge test   # merge branch "test" into the current branch
@@ -4575,7 +4573,7 @@ $ git pull . test  # equivalent to git merge test
 
 [[sharing-your-changes]]
 Sharing your changes
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 Importing or exporting patches:
 
@@ -4621,7 +4619,7 @@ $ git push example test
 
 [[repository-maintenance]]
 Repository maintenance
-----------------------
+~~~~~~~~~~~~~~~~~~~~~~
 
 Check for corruption:
 
@@ -4637,12 +4635,9 @@ $ git gc
 
 
 [[todo]]
-Appendix B: Notes and todo list for this manual
-===============================================
-
-[[todo-list]]
-Todo list
----------
+[appendix]
+Notes and todo list for this manual
+===================================
 
 This is a work in progress.
 

