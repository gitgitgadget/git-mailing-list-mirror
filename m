Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F7F1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 12:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbeLRMfV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 07:35:21 -0500
Received: from mout.gmx.net ([212.227.17.20]:48211 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbeLRMfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 07:35:21 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7Y9j-1hNN8n2lD5-00xMGQ; Tue, 18
 Dec 2018 13:35:14 +0100
Date:   Tue, 18 Dec 2018 13:35:13 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Erin Dahlgren <eedahlgren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
In-Reply-To: <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812181332370.43@tvgsbejvaqbjf.bet>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com> <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vvbj4Dzp9cOlSi651eu+vJq9TrxjiSlKe0w4yCCm8S5OHfK8u5i
 uEsCO1HMZcCbNFQOZLGWmjiJwvsf5wWwtYdvvVR053NuiPU60NkNiyUJdmYH5PvNhY3+mCN
 6+Eh4T3NB0zG50BTbCel7u96weF0vUisGLazugCbGP2b7WFJpXJOcj1lRMhErbN83EtXBh5
 kUIUwHQDl1sjn6H+gPwSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42X0NPb/DkU=:sti0jW/BM5sWZ5SUo2D5CK
 qcDD0ZjK56cEXXiVNYJBSXcgm/bBP2tim8uB2nmIyZA7TRijKBohjGHQ0BQCT0F4YTpSh5kd1
 PcBJn+GZXn+1RJO/p4oTpOBueD9q59HZQ2qaXW8HmLrPepYpjPurDIdFK0sgFAmVK2WYCSrB3
 F8FgcVcZWXQGKtOGuRoXwtFeqBWbUnVV3yUt0aeoJLzEy6JUGxpHImBFx7MilaBJZgJJXU8Db
 bhpEGLMivWZ4TXrqSgt7Bj6IOY7gp+UwMQUyn3MYH1zu5fDNy/1Zp8bZ7SHd6+tW+7B6o89Hc
 R+EnASXc8qatQH4Ax28lIID+KI+fDArWKJcW3nLx9ht1D5qD226UaRFiSHQX7PBCPR8K0wtWV
 p+ODFtf7YrgCFn1mzGaYutw3kU90Ibs4hORBNiLfm3kMNZMgU9uNk7+atAm4OCfBn6zVbWpV4
 +wX5hzYXYnoxJivbkwNdtk8E4NFQ6xsaRL15HueYW2WGf/3sbyOUzriVjWr/sQsN4u+bbc4CA
 Yi+dYwHCCIC3LA7eNj4Mayx5sy2Wz8e8f5r2YjtzsXgKhHOL48UsvL/MX41JmKO0hcrxAibhg
 Qqt+SjI8T1jJDiWudfS4l5X+1yFbTXkN7FcxV9tskwajY25TCc4YRV/lom7gfH29hEvYES0Tw
 qDgdrYI/pqySOn/gqc5v2u9Qs+YD3lEwWZDc1RyJynqC++LKM9qrOZSQ3CDZI711+7T6uYWtv
 hyhncwcE8IXsk4lWs5nWaTVO+tQilQ9ian8THiJ/c2kW6xsPG8yux3wI+N68PfRA3CBpoj/wD
 4FC1OVcmY22cAScrmxyrNq5adK5I9Jf9s/wCj0T47lMLd4YwY/ARd7IR7au/d7onEWtb1WkZa
 I8TfLoMIuA+5i4rcW2QBiuetPjekp8oCyhXncvv141tm61JKlkDk79OONP8fuMzMzRWHKhK9+
 9BIeVCAAuCw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erin,

On Sat, 15 Dec 2018, Erin Dahlgren wrote:

> diff --git a/setup.c b/setup.c
> index 1be5037..e1a9e17 100644
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

I am terribly sorry to bother you about formatting issues (in my mind, it
is quite an annoying thing that we still have no fully automatic way to
format Git's source code according to Git's preferred coding style, but
there you go...): this `DEFAULT_GIT_DIR_ENVIRONMENT` should be aligned
with the first parameter of `die()`, i.e.

+		if (!nongit_ok)
+			die(_("not a git repository (or any of the parent directories): %s"),
+			    DEFAULT_GIT_DIR_ENVIRONMENT);

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
> +			      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
> +					dir.buf);

Likewise, `dir.buf` should be aligned with the `_` two lines above.

Otherwise I think this patch is good to go!

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
