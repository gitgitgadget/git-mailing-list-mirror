Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08582018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcF1Q1m (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:27:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:58891 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbcF1Q1l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:27:41 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LwrPM-1bOSF01vbc-016RoF; Tue, 28 Jun 2016 18:27:38
 +0200
Date:	Tue, 28 Jun 2016 18:27:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Ioannis Kappas <ioannis.kappas@rbs.com>
cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
In-Reply-To: <loom.20160628T175016-898@post.gmane.org>
Message-ID: <alpine.DEB.2.20.1606281825190.12947@virtualbox>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5ZkmUO6ZzaKbxF8inxbIMSgh3vbFRbHBUNd3vKsCM7K81uaMsvz
 ABmZwthHEjzCKgkleDw9H9EYoD0Djj6qQDnRpKgQy90S7SMKVhAThF5Kpg2byMqKR2YWaxc
 NgA07F05zVBmMBnql/LVvr5mb+4EJsD6X2Q2Rys9TMRgxknch1B3uuZ6MJx7PgQXZp6aLQP
 h559L/l/xxZblJwiGqAEw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pqpgm6SRBq4=:N8e6BfPwJPfufvhY2jjuGd
 9F028hdr24sFx4n1iFhTHT0/sk3IvfeEytK2NxfmNw7/UlaXqHlXWvlyZjVxNV1xWW6JmNw+K
 edjBRwYQ1vFoiOJBehJHhwIF/irIDbxWnkxlYPPH4Cckg0Hz3NYmpt/G8SIyVLorhD46bjlML
 /RAvTcx5LptP2vAM5mqtK5BkzapB3bo8wR2NDAhxl5tZf9qzWr2WF1NMVgwLIE983y9Fje0XQ
 qB4koe+NBUdUj0rMkCpYpGq32Yf8bvtokJATSzZW5e2Ix9Yt1xppL5iE7k4ez9pMiGZWjiFaw
 BX9UOold0zPlc/d0y2wEmS4KipjFC4rCl5U3H+Say6MJX1LFQQ4GRbw812tR4OhsIVt0Dwmy4
 VEO7j5g+VHCkjJuQShzQEbX/pTkfn+7KsfRelWPNlOwwfza9+vn3RZlORdKjeyQwRi1N9eaRQ
 izICRxHbpw1bbL2JaTOhmRankF3ZH5S8YCoTsuYZ5S2W7opuxpIAG9Dewiu+ptnN/xv/PZ7K0
 492KebSoiL74qC8zh2F0UzkhgQEruZ/e6TDxVobsV5DNZGA+MEY4A7M6oWO/zIeTtjYjcXRw1
 SGte+PvecckEK+JSNUI0o2HjVte6Xe+CKXyp+Hsq5byGLrxfure3kCiT/O2boYxarYlDHWZn7
 oFnQAsPXvHXjuqLY73yOpTtIQ58+vo5JF549yfTeXJxnwaj3wHWWA4h+/nFg1O4auL5pLSJRr
 LAqjbvhJlg9tivb53TtpA1OGLpKYN6hFFERddDsUYHtmuy9euNaoQqtLFkAkCRr8llThYJMGh
 g3sDsnY
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Yannis,

On Tue, 28 Jun 2016, Ioannis Kappas wrote:

> Hi Johanes,

Almost ;-)

> Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:
> 
> > Would you mind giving them a whirl?
> 
> The patch in "source code (zip)" seems to be missing the line in the prepare
> () section of PKGBUILD to actually apply the fix:
> 
> diff --git a/subversion/PKGBUILD b/subversion/PKGBUILD
> --- a/subversion/PKGBUILD
> +++ b/subversion/PKGBUILD
> 
> @@ -101,6 +103,7 @@ prepare() {
>    patch -p1 -i ${srcdir}/17-fix-test-link.patch
>    patch -p1 -i ${srcdir}/18-fix-serf-config.patch
>    patch -p1 -i ${srcdir}/19-remove-contrib-from-configure.patch
> +  patch -p1 -i ${srcdir}/20-fix-stack-corruption-in-swig-wrappers.patch
>    patch -p1 -i ${srcdir}/subversion-1.9.1-msys2.patch
>    patch -p1 -i ${srcdir}/remove-checking-symlink.patch
>    patch -p1 -i ${srcdir}/90-use-copy-instead-symlink.patch
> 
> 
> Would you be so kind to add the above and rebuild. 

Oh bummer. Sorry for that! I will fix it and rebuild tomorrow.

> I have just tested it locally to work successfully, but I do not mind 
> retesting if you wish to provide another build :)

Thanks, that would be much appreciated! I'll send a reply when I rebuilt
the packages.

Ciao,
Johannes
