Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF73C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CCC20733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KYlLsH38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfLQSpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:45:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:48839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfLQSpa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576608328;
        bh=nggEqtAqqFdnDOJIqtSDDhe7NTUwxC1Le0EYqNIXaJs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KYlLsH38r6Zi8seBEr1fpHCQCw6UzShHeS5RGO6BteTCUYX8LVPmUNZZnKb7m2Prc
         ftSvY7uRPH7y0byKX3JNd25kKcmrF0beTDcvq5zBt2fZgaoN155jAl3vDIR6RGYItY
         IT6HtluZfW4t0prK6Za95skaZqikhtyLpP3tIE9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Msq24-1hoVOq1aY4-00tEVc; Tue, 17
 Dec 2019 19:45:28 +0100
Date:   Tue, 17 Dec 2019 19:45:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 03/15] bugreport: gather git version and build info
In-Reply-To: <20191213004312.169753-4-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912171941451.46@tvgsbejvaqbjf.bet>
References: <20191213004312.169753-1-emilyshaffer@google.com> <20191213004312.169753-4-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vxNbWpskix9uaXKNhG733fvpx6BvXdhUVcOWItLRSJupDcqarQL
 /h5Gx+jjcPGnEnE9WESok6j9UumhL9ca5dp23z4/rlCjJzJGL+JexxwjPYCTXXof+24MduK
 DF2M0dgMpljLb0ieq0+8X/K+jgUbn7vVvmsJiiTomicZvnAJDHd8iRngS1aTaNDnOzsZgRc
 wq7Vh4iaR2k9aAheGCVRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d3og0ycUgEk=:Cbf5rH7KMvshKOzIpOMqDX
 Oc9pucnK8WES2KuFEyM8uvipcso0nFODwNgy9sYaJkibwvAdTbHJXtXLBtNGOYaf/RBxzxdp3
 5UQuHourFD42r2/1HaMKQuIkDUiZW2fEB2Ump2iyC38XekHPLKlzP8e8hXaylszsaJydmbPrH
 eEbL3V094U/xMFSDE/Diy1SYxUHD2Nj32NgilsM+mVnd2vSXcMKc+JPIm7sIxnOpo6lo8nf9d
 PocCFD2jVAly7EgrqLx4hCsIFrhqfeHNgWkj5YWRC8sM4MNnVLzGMJgIUSlGyqDJ9Xcjtbz4r
 z5yeMtcQnaoUtZe1d8Q8pGSEwfPHRkksZdKcKZy+AwGkZU4X1AsouwdugrENag27ONAOF300c
 uWEsYNmCJOHwJe6q4ZapPJXG37Vy8HB0277/CoS+5iM7i4WW0sQgqbebqKfsZn+aAQ21NIwG+
 lY5PAQjj60AdpNSW5xKnN8QqeGwOVQMENYw4o05mWDk98JzJ17aNgP+25iE16gcsWYi3E/4T4
 0d6I4fowMYlPpCvXqjqYtc7W37RyRXp6GMVjhLCJmeh6F30NlGSa0JePVb2rgczUeeXF7Je9S
 G5KXfIwo2+4UVKZJPN/J+JsC02+GBgIXmJfdRMDOnIdPBEpq4sbgA4PomU/qGitVmMuq4o8qk
 bRWha7yn0reolT0jZ+iamTshsUHqFI1N+5f7QSRlPtxM2EDh7R4dXGoeED4H2BA1J9WbwkTab
 UrlB2kV4y0p/khQZL0MYBuBNs64Hgytjm0gvEu4Runyz0D2n0Xa2QIcYnWJQITEEjgUhA7Uoe
 Kqgn6kv6/vcL1DGESiOrrJ3I08kLA5s5HV5qjQBvJwr3rB5XXDdykwd8WWEm0JXGhklE9i1vx
 28VafibMwtQqk7ZQDJO/t0jKSwTc57b93iK16WSVjpL7aU12e5Fbbs3w5LIg0SzbRLhNNkaaW
 GG4jqlsPORQzWq2tjMINLQsd2YlOzJFw1SGQmUPebVV0YraVW1oCi+ZY6mf0+pFwDrSXvQ9kr
 0mADJkB+IhfIyICXtwfMBTUZSANdJCN1cH0J19HR3S6iOQpG9afyC1foVtooWsKsc86y4eXUE
 k9T5CIPyRUVWZT988LTsqVDBlqtQnzh36YSLGxahUmeOE0bdDNLDPBVvTu0FZWBNR0+Max/ic
 XoBdmXOULjdfxZqpc9r547n8X+agZUiTjqyuMYo/JGGpX2wgG+wTF7VGnp6U3NlovU04NY0aD
 ywbh1aIgOJLqO94wbrqifOum1pBDSUL9z4J7svgDmfNtksslBHkI+l8+A++k=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 12 Dec 2019, Emily Shaffer wrote:

> diff --git a/help.c b/help.c
> index a21487db77..a43693fca5 100644
> --- a/help.c
> +++ b/help.c
> @@ -622,8 +622,33 @@ const char *help_unknown_cmd(const char *cmd)
>  	exit(1);
>  }
>
> +void list_version_info(struct strbuf *buf, int build_options)
> +{
> +	strbuf_reset(buf);
> +	/*
> +	 * The format of this string should be kept stable for compatibility
> +	 * with external projects that rely on the output of "git version".
> +	 *
> +	 * Always show the version, even if other options are given.
> +	 */
> +	strbuf_addf(buf, "git version %s\n", git_version_string);
> +
> +	if (build_options) {
> +		strbuf_addf(buf, "cpu: %s\n", GIT_HOST_CPU);
> +		if (git_built_from_commit_string[0])
> +			strbuf_addf(buf, "built from commit: %s\n",
> +			       git_built_from_commit_string);
> +		else
> +			strbuf_addf(buf, "no commit associated with this build\n");

The "StaticAnalysis" job of the Azure Pipeline is not happy with this,
claiming that this should be an `strbuf_addstr()` call instead. For
details, see:

https://dev.azure.com/gitgitgadget/8fc4a374-71dc-4558-a5ea-dd1c081ea621/_a=
pis/build/builds/23830/logs/68

Ciao,
Dscho

> +		strbuf_addf(buf, "sizeof-long: %d\n", (int)sizeof(long));
> +		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
> +		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> +	}
> +}
> +
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> +	struct strbuf buf =3D STRBUF_INIT;
>  	int build_options =3D 0;
>  	const char * const usage[] =3D {
>  		N_("git version [<options>]"),
> @@ -637,25 +662,9 @@ int cmd_version(int argc, const char **argv, const =
char *prefix)
>
>  	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>
> -	/*
> -	 * The format of this string should be kept stable for compatibility
> -	 * with external projects that rely on the output of "git version".
> -	 *
> -	 * Always show the version, even if other options are given.
> -	 */
> -	printf("git version %s\n", git_version_string);
> +	list_version_info(&buf, build_options);
> +	printf("%s", buf.buf);
>
> -	if (build_options) {
> -		printf("cpu: %s\n", GIT_HOST_CPU);
> -		if (git_built_from_commit_string[0])
> -			printf("built from commit: %s\n",
> -			       git_built_from_commit_string);
> -		else
> -			printf("no commit associated with this build\n");
> -		printf("sizeof-long: %d\n", (int)sizeof(long));
> -		printf("sizeof-size_t: %d\n", (int)sizeof(size_t));
> -		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
> -	}
>  	return 0;
>  }
>
> diff --git a/help.h b/help.h
> index 9071894e8c..54f6b5f793 100644
> --- a/help.h
> +++ b/help.h
> @@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *na=
me, int len);
>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>  int is_in_cmdlist(struct cmdnames *cmds, const char *name);
>  void list_commands(unsigned int colopts, struct cmdnames *main_cmds, st=
ruct cmdnames *other_cmds);
> +void list_version_info(struct strbuf *buf, int build_options);
>
>  /*
>   * call this to die(), when it is suspected that the user mistyped a
> --
> 2.24.1.735.g03f4e72817-goog
>
>
>
