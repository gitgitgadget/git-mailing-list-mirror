Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B4B20188
	for <e@80x24.org>; Fri, 12 May 2017 10:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbdELKP4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 06:15:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:60907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932995AbdELKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 06:15:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1dKh8L3cNO-00Bbph; Fri, 12
 May 2017 12:15:40 +0200
Date:   Fri, 12 May 2017 12:15:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?Q?Ond=C5=99ej_B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance
 guide
In-Reply-To: <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705121214470.146734@virtualbox>
References: <20170504220043.25702-1-avarab@gmail.com>        <20170504220043.25702-2-avarab@gmail.com> <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1031448270-1494584139=:146734"
X-Provags-ID: V03:K0:cb2i5U8TBLTxIs9rRrYkoahvpP2jy27vLXKSC94BMh+wRoBN/Gq
 PT6S47XMiCscXYbTCP7Dy6WZLohcu1nrG4/ohcs3U9TayLtOfzyBB+kpCfUtuPUl+j1ExL5
 zFQKMrf+ZNlHhCUD3LEeVVY9zqRHCwIhlbPumBLjK56xKkudxktkEl0fnVv/CXaEq7cpggJ
 ZABqRLx2YF1yGdonVsKfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L6QiStSfYqk=:7D9iYis16Nmv7rxUUBKggr
 PBil3Jg8NP3mdJXe5lzeGUY49yvpoB/eZoivVrzGROKe/6ejZt9W8o8iu33lYT9y0OuIBHfFy
 nVY+tLGLnSlkyUcb4WR9ZphORuJiwV3N5t26Is/29BZmN3xhkZ9JrKNSwgSKcresJEdqlwxbR
 VY+h1cMEpi3vXjJIBvtjpGNrMbHoNh68O9bKc3+dznm+bZUcMwPICSaRkDbyUJyPx7PehRcv4
 JJ0m6qb78jpuXNIpxktLxVxy75AR+JJh0xhV7XL6bUPiS2C5RSAl5gTvdMmlWzzf7GB1dYkpj
 /yN1FfUIPIkBgCSiBwhSdr9WDEqM+3jdrPnTqhnSOFkQ/kwrBAz95JzNmg8eA8FufFfZn2oqb
 EQ4BwLVvBZBw0hZuyamGADEif2Zl6ZuSjosqNq28itv0Mqv5EG6dzO6byTKcNMpkUG2O7NjWs
 whI0L7pEiPfQWuoJVzjbyaEsNE0LIX/vsizU+eP6Q7uk3JsPmFfQk36NxGG5EZmX8q4kIxE4x
 bLMjZ8imCmamWG6jrBKuWKtgu9yiJyeyrc7n7mlPjkNcPbwUyepwcOOdr+KqYaYw83sLc4vXN
 HMlrMsXccp8YV0/qiaVeYrdsnfIUhr1n4VFlIREGZheTqsxH8+D7VYKzAbxCjX/MUuxWCb0Wh
 riYWfc7CwS2JG5SgX/O2m8+DpgdPUJcWM7fVWIhp/NjoC1LCst7PtYZoKDhu0kFXuXdcnigh8
 Gic6G3AVKmwUdTBIOE5XH6pWvkVTGbWJTh9WjlD92iiIz5/vw8crI20psTNAKtiGz1h8RynBl
 fyTBVWc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1031448270-1494584139=:146734
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

[replacing Ramsay's email address with a working one]

On Fri, 12 May 2017, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > diff --git a/compat/regex/README b/compat/regex/README
> > new file mode 100644
> > index 0000000000..345d322d8c
> > --- /dev/null
> > +++ b/compat/regex/README
> > @@ -0,0 +1,21 @@
> > +This is the Git project's copy of the GNU awk (Gawk) regex
> > +engine. It's used when Git is build with e.g. NO_REGEX=3DNeedsStartEnd=
,
> > +or when the C library's regular expression functions are otherwise
> > +deficient.
> > +
> > +This is not a fork, but a source code copy. Upstream is the Gawk
> > +project, and the sources should be periodically updated from their
> > +copy, which can be done with:
> > +
> > +    for f in $(find . -name '*.[ch]' -printf "%f\n"); do wget http://g=
it.savannah.gnu.org/cgit/gawk.git/plain/support/$f -O $f; done
> > +
> > +For ease of maintenance, and to intentionally make it inconvenient to
> > +diverge from upstream (since it makes it harder to re-merge) any local
> > +changes should be stored in the patches/ directory, which after doing
> > +the above can be applied as:
> > +
> > +    for p in patches/*; do patch -p3 < $p; done
> > +
> > +For any changes that aren't specific to the git.git copy please submit
> > +a patch to the Gawk project and/or to the GNU C library (the Gawk
> > +regex engine is a periodically & forked copy from glibc.git).
>=20
> I am not a huge fan of placing patch files under version control.
>=20
> If I were doing the "code drop from the outside world from time to
> time", I'd rather do the following every time we update:
>=20
>  - have a topic branch for importing version N+1, and in its first
>    commit, replace compat/regex/ with the pristine copy of the files
>    we'll borrow from version N+1.
>=20
>  - ask "git log -p compat/regex/" to grab all changes made to the
>    directory, and stop at the commit that imported the pristine copy
>    of the files we borrowed from version N.  These are the changes
>    we made to the pristine copy of version N to adjust it to our
>    needs.
>=20
>  - cherry-pick these patches on the topic branch; some of them
>    hopefully have been upstreamed, the remainder of the patches are
>    presumably to adjust the code to our local needs.
>=20
>  - make more changes, while still on the topic branch, to adjust the
>    code to our local and current needs.
>=20
>  - once the result becomes buildable and tests OK, merge it back to
>    the mainline.
>=20
> This may break bisectability, but I think it is OK (you should be
> able to skip and test only first-parent chain, treating as if these
> are squashed together into a single change).  The patch files your
> approach is keeping will become the individual patches on the topic
> branch, and will be explained and justified the same way as any
> other patches in their commit log message.
>=20
> Having said all that, since I am not expecting to be the primary one
> working in this area, I'll let you (who I take to be volunteering to
> be the one) pick the approach that you would find the easiest and
> least error prone to handle this task.

FWIW I agree that Junio's proposed strategy would make more sense, with
one addition of my own:

- rather than scraping the files from the CGit website (which does not
  guarantee that the first scraped file will be from the same revision as
  the last scraped file), I would very strongly prefer the files to be
  copied from a clone of gawk.git, and the gawk.git revision from which
  they were copied should be recorded in git.git's commit adding them.

Thanks,
Dscho
--8323329-1031448270-1494584139=:146734--
