Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02D61F859
	for <e@80x24.org>; Tue,  9 Aug 2016 13:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbcHINAL (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 09:00:11 -0400
Received: from mout.web.de ([212.227.15.14]:50716 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbcHINAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 09:00:07 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Lo0YS-1azxfs0IYK-00fzy7; Tue, 09 Aug 2016 15:00:00
 +0200
Date:	Tue, 9 Aug 2016 12:59:58 +0000
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: t0027 racy?
Message-ID: <20160809125958.GA1501@tb-raspi>
References: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
 <20160808152926.mciovipy5qlnqegs@sigill.intra.peff.net>
 <20160808203224.GA28431@tb-raspi>
 <20160809065110.GB17777@peff.net>
 <20160809113337.GA1143@tb-raspi>
 <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:UDYHDJWc+/CY2e/qmokzxqlCvRCBKazh/3G+q91TzyU71Yy8Jud
 9HeqTPg2IFczdJjuw9u2H8nFlg62rICI9xp/7d/SctkJB9MxKLmJ8x02TvHKcOjZdPaUWuQ
 h2COotCxk91PLXjfhJldhi58syzX1JE+oF9Mh3fFt4TfyNHwPH1YqmvTcAxK+4iZv9UT11V
 fiD+i0WgoP5WGFnNiUMyQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:1kj2Q53ygnQ=:2d/7CguY71979wVuXT/kZ6
 bOW8J1HQG8nEWuuLjYS+Dt1YVazfN9a4llzpJiyJAuRXUBS/bOO9EFVeAoxOUAeib3Ym+Xo36
 OL3uKJsjQADjbg1QU8e5BshDQII0w3D6rCWrd3PHlVppP5XE7LjqsmnmJjGKvietl79/hvQLu
 SwybTJioltwwg27JD8wpQiP1SMF5nuCO39682IqnzS2v5pNWLsZ7AbYhdjs6pb/EQ7p1xaIZf
 wVlHWeNkR04QudDSzNRlCu93xrbxLJtuLq+fEUwv6YSqKvMZkbvCpVbouJFGiwcjWkjxyq6+G
 nLEj5qr1IxkTGhEJUBLgOMG6UVXmkErdA2qKwj4SUJCkXm5xbvFjtl67YxqSMKt9Ahl1FB/0y
 84Fs3zFbhVqjyUW4h9q/JW2dB/nepDz9Pr9BzGM6iDNGE3Wufrez7A1qjaD5BWVB/uHM4S4X1
 B6nk4HaxiF+JoUbYusavLwrOXCWnWQzqmOiArv9O74Mkl3Wo1YQJqDNCubRyWU45lJvwRXEIN
 K/yd/YJSC6Cd+/j4GFWSxbjmH5JOpAY9A3ueHEkY0CNsxNwYzXgavVzivuIdAjyVzmi8YHMwg
 Q3E6NEuWFFzV+30b19Lyk7RqJXEjdNPuryyG9L8A5v3MRFLEVNvdff4AOpKH06/rNSVHwKwkz
 Jqg9UuwxBRHvayXZeKsAMBBLZDpAbm2ojd1hdWU6rlC2AuVsoB4YPkBtr97rgamc+KTXZCm7B
 9Z5zNCp1/nkvq7NJeMCdeOlLXHXzee5lR+9SJJkG83J7by4aF7YuXf9lT0o=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 07:49:38AM -0400, Jeff King wrote:
> On Tue, Aug 09, 2016 at 11:33:37AM +0000, Torsten Bögershausen wrote:
> 
> > > The second one seems plausible, given the history of issues with
> > > changing CRLF settings for an existing checkout. I'm not sure if it
> > > would be feasible to reset the index completely before each tested
> > > command, but that would probably solve it.
> > The content of the file has been changed (we appended the letter 'Z' to it,
> > so even if mtime is the same, st.st_size should differ.
> > And it seems as if the commit is triggered, see below.
> 
> I don't think I made myself clear. It's not a question of whether there
> is something to commit. It's that when git asks the index "what is the
> sha1 of the content at this path?", the index may be able to answer
> directly (the file is up-to-date, so we return the index value), or it
> may have to go to the filesystem and read the file content. It is this
> latter which triggers convert_to_git(), which is what generates the
> message in question.
> 
> For a more stripped-down example, try:
> 
>   git add foo
>   git commit -m msg
> 
> versus:
> 
>   git add foo
>   sleep 1
>   git commit -m msg
> 
> In the latter case, we should not generally need convert_to_git() in the
> "commit" step. It was already done by "git add", and we reuse the cached
> result.
> 
> Whereas in the first one, we may run into the racy-index problem and
> have to re-read the file to be on the safe side.
> 
> -Peff

Thanks for the explanation, so there are 2 chances for a race.

I assume that the suggested "touch" will fix race#2 in most cases.
In my understanding, the change of the file size will be more reliable:
 

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 2860d2d..9933a9b 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -120,6 +120,7 @@ commit_chk_wrnNNO () {
                cp $f $fname &&
                printf Z >>"$fname" &&
                git -c core.autocrlf=$crlf add $fname 2>/dev/null &&
+               printf Z >>"$fname" &&
                git -c core.autocrlf=$crlf commit -m "commit_$fname" $fname >"${pfx}_$f.err" 2>&1
        done
-------------------
Does anybody agree ?
And, by the way, the convert warning may be issued twice, once in
"git add" and once in "git commit".
