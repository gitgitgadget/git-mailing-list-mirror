Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D921F856
	for <e@80x24.org>; Sat, 10 Sep 2016 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbcIJH5u (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Sep 2016 03:57:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:65456 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbcIJH5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2016 03:57:49 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mbfyr-1bRvEL1Yyz-00IzP0; Sat, 10 Sep 2016 09:57:36
 +0200
Date:   Sat, 10 Sep 2016 09:57:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] cat-file: introduce the --filters option
In-Reply-To: <xmqqr38tc7d1.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609100957040.129229@virtualbox>
References: <cover.1472041389.git.johannes.schindelin@gmx.de>        <cover.1473415827.git.johannes.schindelin@gmx.de>        <084088ba86c0af3636d960276c0bfdf7f5d2cfde.1473415827.git.johannes.schindelin@gmx.de>        <xmqqfup9ds9p.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1609091800020.129229@virtualbox>        <xmqqbmzxdpjp.fsf@gitster.mtv.corp.google.com>        <xmqqvay5c7t3.fsf@gitster.mtv.corp.google.com> <xmqqr38tc7d1.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VBoWooyosklG6+0ZxUi5dVIp5UirJt7lVrnU10eU8VYbCR85Vyj
 dQg783Cfa4wj1v8DiwWMzo9oqsl91l60CPDtqxjWI5QU7VqSjW0vMWJosh2rgxXImWK3cgL
 DAMfBhlgyyBrYny2I4iF7mqRotv3AjpgnFfHh3Qtd/h66NEfR81foB68bQwGFRiyWc2nKGg
 Q/ZT5YJFx90umY5zBtTYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kzOi8Rm9yGI=:qUTsVPn2ZkGJD9yUScnWIl
 Lp7wxxCijRB1fa40dvyPIwXQStbmyfo+4nTfap5clUk1pIJTPxlzbGemmTPJpYvkGGhq/DP/S
 vFzQyo4CvXY/485PNT26zUKBYhfUHQ9wqUxZPeQPyW2ylw5KqTt+KvYC9S3qpYsUdSciyau5z
 ZoE4T70krmYGnuquhdSBc9uBaeOP9iByii/wFJVi4QnsunoaZfhriU9iYPjonPoGljm1i1ZBU
 jOnfU38ttNs3Gq7n7k9uhjgmQmi6Eajcagc4NLH6cggiT8ucZccjt4t2hA8n87yZkZY3hLbFZ
 Y06Fx8XlB0YG8vHoo4ql1N+y5sLjLl38FvfYeEx8r2fN0UcGJhJTzYiIbUwhk4lMLOAzvM9u+
 qXICNJl5/1VfDztY0B5kzRdUplGQdUysTVUtFswozCuN1f5cTQ9nc8W9ySyhKNsTlS6nE94hc
 QVDk/85ycz8NBVIwlRmJ909RhikSmHeVo7siVaPyvE7DHoYs8F7EUUmAmTm4PCU5UkW1vqp7x
 rnZGklTFVJEuQdHOmmKQtaKrI2q3+69UlGV8IdIl+rKlis1s7+FW/mWUJij/PlmPvoAabwQYR
 jZ1b125LRCjbpoTL4mcK3xfCKeqfQQ7lSTS2oO/4b/r+s82K7J1cjLTUzxUKNLm0d4wQWTfC8
 WDzdXdgXoSbolsS1BhVw6tQal1vW6vx5vHR3aUw7z/qDVWZE7ksfX4inaHZqbzxB39bho5P+3
 xzlRHM/ZepTWarhTIA44lvSJLXi5YBleDDGJO8Je6IRyGWkmS+eIgWzKjNPhIqv/nGQV5JOqg
 hcEXO6I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 9 Sep 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So I would not mind if we define the semantics of "--filters" as
> > such (as long as it is clearly documented, of course).  AFAICS, the
> > batch interface does not call filter_object() for non-blobs, and by
> > returning successfully without doing anything special for a symbolic
> > link from filter_object() automatically gives us the "by default
> > return as-is, but give processed output only for regular file blobs"
> > semantics to the batch mode.
> >
> > But for a non-batch mode, it feels somewhat funny to be giving the
> > as-is output without saying anything to symbolic links; we can argue
> > that it is being consistent with what we do in the batch mode,
> > though.
> 
> In other words, instead of trying to be consistent by erroring out
> in non-regular blob case, I think the attached change on top would
> make more sense, by consistently passing the object contents as-is
> for all "not filtered" cases, whether it is run from the batch mode
> or from the command line.
> 
>  builtin/cat-file.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index f8a3a08..99cb525 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -33,12 +33,7 @@ static int filter_object(const char *path, unsigned mode,
>  	if (!*buf)
>  		return error(_("cannot read object %s '%s'"),
>  			sha1_to_hex(sha1), path);
> -	if (type != OBJ_BLOB) {
> -		free(*buf);
> -		return error(_("blob expected for %s '%s'"),
> -			sha1_to_hex(sha1), path);
> -	}
> -	if (S_ISREG(mode)) {
> +	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
>  		struct strbuf strbuf = STRBUF_INIT;
>  		if (convert_to_working_tree(path, *buf, *size, &strbuf)) {
>  			free(*buf);

Yes, that makes most sense to me, too.

Ciao,
Dscho
