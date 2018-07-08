Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A2E1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932860AbeGHVw1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:52:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:45257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932545AbeGHVw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 17:52:26 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomN9-1gHgpI2BAJ-00grcp; Sun, 08
 Jul 2018 23:52:23 +0200
Date:   Sun, 8 Jul 2018 23:52:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul Smith <paul@mad-scientist.net>
cc:     Daniel Jacques <dnj@google.com>, git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
In-Reply-To: <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
Message-ID: <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>  <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>  <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>  <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
  <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com> <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JE2p7SGJa18YbRpkiySVPSnsjt7z62CqgUK7RWqWU71mBUC1Rg7
 P8Pwl2I8UCV2oAMdmKk5FHMrjRJ3QjPiQNiEXHwBxPMz2PP7/gOmfVCbE4hNewvc8dUIaED
 INhPjE+MEMMjoySubF4b39RrmA6GmkRkU4FdH+zXRr/NeeF50GUrUOqxiZpnUTXD38ZI9Vr
 Nvkv4HrcrO1njieqYAJWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:400YPSfxt14=:fOVy0708kUVqOekE52tHL3
 sGzVmYTGDBTD1ppEZ/xNqTvpYGtUcBNgurjhIrC/ZYzftjmmaFIZD67AIt0ghfPij+lhp1CEI
 jBBiHqgBQw0nt5LN6jte8PTWagnSfztgw2/9suK4fGQBGwzrUC/4v0BemTFFxu1K4X/YmLqWE
 9i5jcFO2LAvjKLs6gxwL5q1xMxbYR0dxnM+L8ory2uAR92+XhAzGDgol3Q6YMIkfMrlg0+UNM
 UY0qhr9rU91DcOvMfTpD6aE7SNnyCoTVt3w3Je6nuzAkgdqBkF+Wf7MXd7il101Pdu0oGavPW
 jPMZfMggm5YHUXXIhbv73gR2CLOZOCflw/gP78oisEYf/zzv0FA/3WA5SPHQ8BTeV0IQtO2mb
 cUGYUYWOnZIoqqdkn1HEvPVWbDNsMN7/FBeOtKSLd5i0wo58DePGSGuImQZ+zBA6sKJjUgYd1
 fIHp2lKKWKagaQz6bXJ2F09ojdeqpLzSnYyf3DyUxDZ0dArXmEVPglDtrHWFlfAZRHyWCnjM1
 ONKP6bdvm4LU5mCkpjoOSdYkNMZkSI45rmbDdwsIMApO0F5duhfzxE23RnwtyvxuXLoOpySk9
 MpbXI9hxw25phQbuXwfeO/MUO74kyNYlYWtm6eLKRd2rgOH8HDFk6uabMTEsxGt0tsaAn/H8t
 GUTcb3pT8bQ/P1ISm0vVHmgZbikJscd8ZK2aVsyPa4zR+EJ23GnmC4aDZfmzkQ0zu6mF6B5w6
 uX8ChDI1xeUat1/mUfrikq/oeWNqcrmc8iRkeK30M/3BgIFZcyYTVPMwxsmkqRJV/RA5UbqcY
 SAlV4cy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Sun, 8 Jul 2018, Paul Smith wrote:

> On Fri, 2018-07-06 at 09:18 -0400, Daniel Jacques wrote:
> > I forewent autoconf because I was concerned that the option was too
> > obscure and the configuration too nuanced to be worth adding via
> > flag, as RUNTIME_PREFIX requires some degree of path alignment and is
> > fairly special-case. If you prefer autoconf, though, it sounds like a
> > good thing to add, and I'm happy that you are finding the feature
> > useful!
> 
> Well, far from obscure, I actually think that RUNTIME_PREFIX should be
> the default behavior on all platforms.  In fact speaking for myself, I
> see no value at all in the hardcoded path behavior and it could be
> removed and RUNTIME_PREFIX be the only option and that would be fine
> with me.
> 
> The only possible advantage I can see to the current default that you
> can copy the Git binary alone somewhere else, but that's of very little
> value IMO: you could instead create a symbolic link or a two-line shell
> script wrapper if you wanted to have "git" available outside of its
> normal relation to the rest of the installation for some reason.

In theory, I agree with you, I would love for RUNTIME_PREFIX not even to
be needed.

In practice, however, a *loooong* time ago it was decided that it was okay
to implement parts of Git as shell scripts, and when those shell scripts
finally became too many, in order not to clutter the `PATH`, they were
moved to the libexec/git-core/ directory.

Obviously, for this to work, Git needs to prefix the `PATH` variable
internally, and for that it has to know where that libexec/git-core/
directory lives.

Now, if you care to have a look at Dan's (and my) patches to implement
RUNTIME_PREFIX so that it looks for a directory *relative to the Git
binary*, you will see that it is far from portable. In fact, it is very
definitely not portable, and needs specific support for *every single
supported Operating System*. And while we covered a lot, we did not cover
all of them.

So unfortunately, it is impossible to make it the default, I am afraid.
Until the time when we can ship a single `git` binary (which is sadly
unlikely to happen, as there has been a *lot* of pushback against that
e.g. on the grounds that having to (lazy-)load the cURL library adds a
tiny bit to the startup time of the `git` binary).

It is all a bit complex, due to non-technical reasons.

Ciao,
Dscho
