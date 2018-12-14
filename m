Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EC920A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeLNKce (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 05:32:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:44139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLNKce (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 05:32:34 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5LJv-1hMZnP3f1L-00zYyz; Fri, 14
 Dec 2018 11:32:28 +0100
Date:   Fri, 14 Dec 2018 11:32:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Erin Dahlgren <eedahlgren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify handling of setup_git_directory_gently() failure
 cases.
In-Reply-To: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812141130180.43@tvgsbejvaqbjf.bet>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EZWcV9FN0WOzWSnDBhJoziW1pWUVRGX2rdYgj3pA+HuaxDP2SBS
 WCOcdn7kMLq+0FITOU0Q9nfNLRES9dgTtVmJ7ZKuStSigPJRWK7xiPXVb53mS4eobhhAbSc
 7M0CRNlMMFSePcwYxhwFzwCN3oUBn5jpO7zow+EXty3m9YGIZ09fR0p/QZzTgaYNKTk3uVE
 Tx7XGYfQhGraA3rgRSF5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ppjMpvPPxC0=:mST0dXYNl2OxJV8coiP6I/
 q/5q2zwp281EMOIC+bsAjcbE0e1Y94jVJ6YN0ZDQD1RVL9bwuOJyxfS4WFrXQmakikseFmlUW
 tWatVQJ81rHB/HZGmLKFTAkp1ufbJzaWzqF+puRxSBCuFq4FhryE3oqnIrZuzEJR0tr7EfrTP
 eB73NQDHXTgvlwYNNrBptGz0ue5zHRSR35DHsHloHH2hNWxCSBY2DPXkan9LbUFfqCiAWNZ5P
 X/VTqwYpfrb35/Ar7irIyTOEHCsNcC9oMyapMVIvUtjI06fERSRso32ajm39SNx69nMCEfrJu
 C19TCnKdM2KPagwYuzVaeSsbbp4tAk5IwJ1X2Oks0KZp2olaRJGvgNfzyBHpDsJB8B0kZKcoe
 zZZhVoN8LEU/9W5On+8RXVK0xWBeGYSe3kKeYL0vASF2K4DbAPJHUwOx3p5XMPY2UNZm9/Xbd
 hsSeJ8bC6T81BoyYK8w7S8Ob0JSIJCNUCRaCQtLhg5mrIl9EsNdYETnMLb7e1qY8LZOyqAOX5
 23Ze95YEj0BSlO2pPzdP3mUuQJwWSJ/+3GyPckVNlAYd/Uc/0LyrT+B5j9ZigTQ2bvS0PMc6Q
 N3NhxHkZeTUTosHqU/kj/yRFtZqNmuDbGGLoccbs+g9kTgKFXgebhHmv2SiEZAXxWhHt+m2hc
 ygr+HTT/tQj3QGpRTGjE67tz0gaCfUe5L0Ym03F5aA4ZhK+rywCXv109nD9tmSfuOA1Hh3r8q
 RPR1KleHBAXH999VWbP1ujuuPc18yz3Nw4h53Az117KRpitsapEFGVZTCo7yhoqpdvDor6pyG
 X3IPEXDcO0smd8mL9c6q9+bAF4sUxC9sTedg5J5eGd/iEkUlkwQBitLENkakLgCbmlukKTzVK
 S9Z+eAwidVekGueVhoFF3KSPNicHDlBmvo98lTbLm9yb4PiJ1364DUYKiqUxpfC9XKgduJXD4
 YDxu3CD5hgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erin,

On Thu, 13 Dec 2018, Erin Dahlgren wrote:

> setup_git_directory_gently() expects two types of failures to
> discover a git directory (e.g. .git/):
> 
>   - GIT_DIR_HIT_CEILING: could not find a git directory in any
> 	parent directories of the cwd.
>   - GIT_DIR_HIT_MOUNT_POINT: could not find a git directory in
> 	any parent directories up to the mount point of the cwd.
> 
> Both cases are handled in a similar way, but there are misleading
> and unimportant differences. In both cases, setup_git_directory_gently()
> should:
> 
>   - Die if we are not in a git repository. Otherwise:
>   - Set nongit_ok = 1, indicating that we are not in a git repository
> 	but this is ok.
>   - Call strbuf_release() on any non-static struct strbufs that we
> 	allocated.
> 
> Before this change are two misleading additional behaviors:
> 
>   - GIT_DIR_HIT_CEILING: setup_nongit() changes to the cwd for no
> 	apparent reason. We never had the chance to change directories
> 	up to this point so chdir(current cwd) is pointless.
>   - GIT_DIR_HIT_MOUNT_POINT: strbuf_release() frees the buffer
> 	of a static struct strbuf (cwd). This is unnecessary because the
> 	struct is static so its buffer is always reachable. This is also
> 	misleading because nowhere else in the function is this buffer
> 	released.
> 
> This change eliminates these two misleading additional behaviors and
> deletes setup_nogit() because the code is clearer without it. The
> result is that we can see clearly that GIT_DIR_HIT_CEILING and
> GIT_DIR_HIT_MOUNT_POINT lead to the same behavior (ignoring the
> different help messages).
> 
> Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Erin Dahlgren <eedahlgren@gmail.com>

Thank you for working on this!

> ---
>  setup.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)

Nice! It's always good to see a code reduction with such a cleanup.

Just one thing:

> diff --git a/setup.c b/setup.c
> index 1be5037..b441e39 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -831,16 +831,6 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
>  	return NULL;
>  }
>  
> -static const char *setup_nongit(const char *cwd, int *nongit_ok)
> -{
> -	if (!nongit_ok)
> -		die(_("not a git repository (or any of the parent directories): %s"), DEFAULT_GIT_DIR_ENVIRONMENT);
> -	if (chdir(cwd))
> -		die_errno(_("cannot come back to cwd"));
> -	*nongit_ok = 1;
> -	return NULL;
> -}
> -
>  static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_len)
>  {
>  	struct stat buf;
> @@ -1097,18 +1087,20 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		prefix = setup_bare_git_dir(&cwd, dir.len, &repo_fmt, nongit_ok);
>  		break;
>  	case GIT_DIR_HIT_CEILING:
> -		prefix = setup_nongit(cwd.buf, nongit_ok);
> -		break;
> +		if (!nongit_ok)
> +			die(_("not a git repository (or any of the parent directories): %s"),
> +					DEFAULT_GIT_DIR_ENVIRONMENT);
> +		*nongit_ok = 1;
> +		strbuf_release(&dir);
> +		return NULL;
>  	case GIT_DIR_HIT_MOUNT_POINT:
> -		if (nongit_ok) {
> -			*nongit_ok = 1;
> -			strbuf_release(&cwd);
> -			strbuf_release(&dir);
> -			return NULL;
> -		}
> -		die(_("not a git repository (or any parent up to mount point %s)\n"
> -		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> -		    dir.buf);
> +		if (!nongit_ok)
> +			die(_("not a git repository (or any parent up to mount point %s)\n"
> +						"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> +					dir.buf);

This indentation would probably be better aligned with the first
double-quote on the `die` line.

Otherwise: ACK!

Thank you,
Johannes

> +		*nongit_ok = 1;
> +		strbuf_release(&dir);
> +		return NULL;
>  	default:
>  		BUG("unhandled setup_git_directory_1() result");
>  	}
> -- 
> 2.7.4
> 
> 
