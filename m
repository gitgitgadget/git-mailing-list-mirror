Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A57DC1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 13:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfGHNMa (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 09:12:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:35603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfGHNMa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 09:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562591544;
        bh=QOnL/iy5489UNWhazwKHt0MHIf8nwC66KXpJYLjrhyY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eFkNIcUGUawD6X21uB1zhOd9mH2HoUBYbZfpZ9UZUJtTKUQkZ56vaRUjrcoE6Rb7B
         iF+fA6r2CJ9ouqkUmfiuL+vb8gQngqjV7Q5GC5b+WDsabO9Fbl+iCCfkLdnjcH23sD
         Dm68V3aYJNqn6mKpUZ+YlJ+yEwtiw36qsyW+7NEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1hiKlj3iq8-00FPNE; Mon, 08
 Jul 2019 15:12:24 +0200
Date:   Mon, 8 Jul 2019 15:12:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 12/14] range-diff: add section header instead of diff
 header
In-Reply-To: <20190708114422.GC16825@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1907081507540.44@tvgsbejvaqbjf.bet>
References: <20190414210933.20875-1-t.gummerer@gmail.com/> <20190705170630.27500-1-t.gummerer@gmail.com> <20190705170630.27500-13-t.gummerer@gmail.com> <nycvar.QRO.7.76.6.1907052114480.44@tvgsbejvaqbjf.bet> <20190708114422.GC16825@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vV7oGY8w9hZp/RvutXC/UaWjQepGikisW2lvs26JkE/CTaoiAxF
 er3+rC4tsBdMWVU5yHGX8rwaCKM31NrSI05X3aYFtqiBn5BaTtNlYjD/TgFv2a9vDDeG68N
 +UdRpQNDv5iXvnDLsY9NP+wm541svd/kpujzpEn5tPnHsGX03QDjMzFDLj2OCmgBUUXUFeH
 a1GxIHTifvI5i5BascSew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UOquKrPQfBE=:/iWDdTaYGKm1C8Uz0eHS44
 c+QHlrgndE7oBhKStqUSeE7NuvhozZfjk28HnmdV/bJ+dLHR1m2bwZ2VLKo9oTALyJPwCLh+D
 K7C3/nC/VSOuPJi4nrxkabqrp5eJi5FK2Akx4pwua/Ru4lvUO2PPGRvIu5UcROOMsN1aB0i/0
 tly0jAQvMl8kACQMweKB3SwHioGOyAM7RZB9D/Cnw/TD/IRun+x0Mji1aUvK5Hvpi/qz4YLfP
 YKXbAz7GyQF+vis7R9vAQQ765Pu0TzpMa7WMgaj+3cYmHaZpjObWe6ppIUh+AXDRv8Y6mM75V
 /dXrPD3blrKss3STUqzyawYKPclPtXCA5V8kQCKnDTf/XZ6HvbQb3Vh5aYyh0JsDiaLFyXe+J
 /Kb6l4G5MCId6XXeF5jdUwHirjxoA7TM9Se/WSZ+EQ2SWkFoQEOlxb5wlIFpP2ZzzXQtJ8x3r
 vYHWwmucsTo5CiLO/j3BctMIUOpfBPrSD9A5ik0qzPtcwdtzkCdLr6rsvr9UPs1Hvn5Z9Ol8R
 rPWiIbYS7MELRlpP0oLIOk1eI7xTVEEcihN3iR6Zv+tE2EUVm6A777zwL48yCR2v9EQ9UNCqc
 sbOjo5K/2M9ZIa2RICN6W0JP6AP57aMIqOkumhV7HO4PSyFOrsPTP8N5nICMqVT8NBd/wLanf
 +kezeqZFbk7/TRvqVZ4/RvPSVDV5iSEyitT97MlEhYhqDG7KqxVOoRVHT1iuMf7eRFYw9LCVX
 TkTASzgVAKvB6O+/yN18y+LDYV1XsVLf3HKMuONVK18GKlhfQlWIeuE4LAv8m6zZdVegkjvGA
 bzrJIQpPbewHmfZu9x2mt20+qaiXd3S3opbBLuNvGPkiuRUtH5m79BAhPZeU93TE0TGn6f7yp
 HRcdTaF7iRqyMDaU4Psk0YEUDmEXN2IZTMSU4ekU6w7dlLpNNUWzLn5dion7c4nhKNGtUbQFt
 VnTO+AWNW5b/Pgsq9/FR+rJfpOC9iwB3MHw5ridVkDulkycTo7dlq1wUxUHInh8fWB4DNhebN
 wurYCeKLW2aAI/LdxWWNdjBQXEvQSOTdXjrwvehllHzwaqE+TWqkqoFPwC0TM+IXIDMhj2kyY
 eGcp+j3EpzF8gvpbkDwJn+39EYYQoI5JAua
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Mon, 8 Jul 2019, Thomas Gummerer wrote:

> On 07/05, Johannes Schindelin wrote:
>
> > >  			 */
> > >  			continue;
> > >  		else if (line[0] =3D=3D '>') {
> > > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > > index 9f89af7178..c277756057 100755
> > > --- a/t/t3206-range-diff.sh
> > > +++ b/t/t3206-range-diff.sh
> > > @@ -181,6 +181,85 @@ test_expect_success 'changed commit with sm con=
fig' '
> > >  	test_cmp expected actual
> > >  '
> > >
> > > +test_expect_success 'renamed file' '
> > > +	git range-diff --no-color --submodule=3Dlog topic...renamed-file >=
actual &&
> > > +	sed s/Z/\ /g >expected <<-EOF &&
> > > +	1:  4de457d =3D 1:  f258d75 s/5/A/
> > > +	2:  fccce22 ! 2:  017b62d s/4/A/
> > > +	    @@
> > > +	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
> > > +	    Z
> > > +	    -    s/4/A/
> > > +	    +    s/4/A/ + rename file
> > > +	    Z
> > > +	    - ## file ##
> > > +	    + ## file =3D> renamed-file ##
> >
> > I guess there is no good way to suppress the `- ## file ##` line in th=
is
> > case? It is a bit distracting...
>
> No, I can't think of a good way.  I'm also not sure it would be right
> to remove it.  In this case it means that in the previous version this
> was only called 'file', while in the new version it was renamend in
> this patch to 'renamed-file', so it does give some useful information.

Oh, I misunderstood! You're right, this is useful information, and I just
have to learn how to read that variant of the range-diffs.

In other words: please leave this part of your patch series as-is.

> > > @@ -216,9 +295,9 @@ test_expect_success 'dual-coloring' '
> > >  	:     <RESET>
> > >  	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<=
RESET>
> > >  	:    <REVERSE><GREEN>+<RESET>
> > > -	:      diff --git a/file b/file<RESET>
> > > -	:      --- a/file<RESET>
> > > -	:      +++ b/file<RESET>
> > > +	:      ## file ##<RESET>
> > > +	:    <CYAN> @@<RESET>
> > > +	:      1<RESET>
> >
> > I am a bit confused where these last two lines come from all of a
> > sudden... They were not there before, and I do not see any code change=
 in
> > this patch that would be responsible for them, either...
> >
> > Could you help me understand?
>
> Sure.  The actual change (in the range-diff) here is that "Also a
> silly comment here!" was added to the commit message.  The diff header
> is context lines after that.
>
> We now replace the diff header with the new "section header", which is
> only a single line, so we get a couple of additional lines of the
> context of the subsequent inner diff.

You know what? This is my typical mistake when reading uncolored
range-diffs: _of course_ I missed that this is talking about context
lines. I really thought they were added by the new iteration. My bad. And
thanks for explaining this patiently to me.

> > >  	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET=
><YELLOW> s/11/B/<RESET>
> > >  	:    <REVERSE><CYAN>@@<RESET>
> > >  	:      9<RESET>
> > > diff --git a/t/t3206/history.export b/t/t3206/history.export
> > > index b8ffff0940..7bb3814962 100644
> > > --- a/t/t3206/history.export
> > > +++ b/t/t3206/history.export
> > > @@ -22,8 +22,8 @@ data 51
> > >  19
> > >  20
> > >
> > > -reset refs/heads/removed
> > > -commit refs/heads/removed
> > > +reset refs/heads/renamed-file
> > > +commit refs/heads/renamed-file
> >
> > Hmm. Is the `removed` ref no longer required by the 'removed a commit'
> > test case?
>
> It is, and it still exists.  I'm not entirely familar with the format
> for fast-export/fast-import scripts.  What I did was just fast-import
> the existing script, create the new refs that were required for the
> tests and then fast-export'ed it again.
>
> So not sure exactly why this changed, but the 'removed' ref still
> exists :)

Right, it would still exist because earlier parts of the script would have
created that ref (otherwise `reset refs/heads/removed` would have failed).

Your strategy to update the script sounds like the best way to go, it just
runs afoul of topological ordering that somehow makes this patch look as
if you had removed parts of the commit history. I believe you when you say
that you didn't, of course.

Thanks,
Dscho
