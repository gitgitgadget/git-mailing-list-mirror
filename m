Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 807D520756
	for <e@80x24.org>; Thu, 12 Jan 2017 09:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbdALJxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 04:53:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:65299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdALJxx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 04:53:53 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZhg-1d39eA0Ts0-00bZ67; Thu, 12
 Jan 2017 10:47:10 +0100
Date:   Thu, 12 Jan 2017 10:47:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/5] doc: add documentation for OPT_STRING_LIST
In-Reply-To: <20170112001721.2534-2-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.20.1701121044120.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com> <20170112001721.2534-2-jacob.e.keller@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:37O1RNLiriZLmiIB+CVubxSuW7wCW9FkzzsnZW1wlhA/xjYiajV
 kOWM+O0qFrmZu3IFKHoYQL4capvkMeZk3mACzV9T1z607/HJ7znJTAlZNjcAo+iRupI98v6
 RxEMKKHenNZ7t69I45f50Wg6LrjV6O87kEN1NxnW13w9DaGMOYcM0HX2HytrPtjx9XBo61P
 7rCRL8+yBfOCzGnOpjPfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kV1FJiVAUQ0=:UaUScylnQ6oaWnsijnEndp
 Jkw7byNBVaYTkBAci8Cn7shQGpFxQ32gkXXQA3LFGhfH2rIYqUx7RgG5ZKAQwlVglmZR8bD6n
 g8g8bEFnjBVHE/RVx2gB1ykthxutZ7SBbO3jpqYNseAGykpvcIOyjVCN9YUUwzQ0W8vtUgQSF
 rv7ntLAlN7veke8UCXpp4nseimx4wkGgMjM5llLZmWp+3uhSmvlZTZ1avYY/QDkBJ5DlALHGz
 yGHYZxQZ22ahifBS5QnYm+TKDsI4lNX4sxf3erjcKpAkUxIL/B1ax6yPZWlLGM52Xm+mDbRpQ
 G2QDhZYLXUP8zSULtaHBea+yntHPez6R+j513HVm6gLHkhH37ESCJ9l+kqmMWh4n8xGBjhJ8f
 fZurB3Xoz6pmGNwpl4q2m9ERVid4JpgYZeEyilqJv68BDNYXa23SRgSRtwBRPb1We0u+H9u0C
 cXY3ScCYUcxHTCYRnFfIZe7M9ELs8KVbyPmiRUf2dvEzkdm48luvf+d+ChhSPgYjP9geChWFu
 ai2sDTCDCmXV15xA+9+AEsd/DX/2Krrj/rp+4Q6dlOW28DqSFMhYgOWFd0a0Z+0GL4YjTkcgc
 lT9gIgGM58TxORIgkqqT3j/1CiKFGXVoqHJZu8xLS1zJRQp/t6bgyaLNj6/XkkyIV115sxK7U
 t6GJ5MAKdWdLCKGUzCEeJLlRKoukM4rXoFjbnIjsr5B+LOTsNE5OasM3KIHl8Xmlle/0iYwko
 15BcAyeqPhtm9eVI31RTynehk+iezSxgIscTO4Q8/s5j3oxFZ9rc5S8RP48XQPbfzTbZ78FFO
 r2O90SBGklnPwYdQwJ4NmjWlXK7gQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 11 Jan 2017, Jacob Keller wrote:

> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 27bd701c0d68..15e876e4c804 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>  	Introduce an option with string argument.
>  	The string argument is put into `str_var`.
>  
> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
> +	Introduce an option with a string argument. Repeated invocations
> +	accumulate into a list of strings. Reset and clear the list with
> +	`--no-option`.

One suggestions: as the list parameter is not type-safe (apart from
checking that it can be cast to a `void *`), it would be good to mention
in the documentation that `list` must be of type `struct string_list`.

I was about to suggest that `--no-option` may be misleading, as the
command-line option is not really called `--option` in almost all cases,
but I see that the rest of that document uses that convention to refer to
the negated option already...

Ciao,
Dscho
