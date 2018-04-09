Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9141F404
	for <e@80x24.org>; Mon,  9 Apr 2018 21:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeDIVUH (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 17:20:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:60765 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751767AbeDIVTx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 17:19:53 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbMmA-1ecOBO0AQs-00l0SQ; Mon, 09
 Apr 2018 23:19:52 +0200
Date:   Mon, 9 Apr 2018 23:19:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] Make running git under other debugger-like programs
 easy
In-Reply-To: <20180409185136.4880-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804092316280.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <20180409185136.4880-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JrSzxxLlhQ14j/UROy23PhYHHMLKqKF5b5/Kb19RXru+0tUo72p
 F3mxojkmMXnA3dadEyQxJhUAsbD4JKQs55D6SpdoSGD08BOE1WCjAG9ofsJt+Ykr2rGXQxq
 bExQRv57agBOg5FQ6X39X6ksNv4EtHahF05r5WrzPBWYsdhA2hEEx7XgyfN4AtnJzawu4xP
 1VJJQZN3ho7X6RCVmu/Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qSvNJsMsf+c=:ebvjEf4rKWVckoGcKnaH3t
 zTWB0zLtQGWss+z9vwLVsWwPHb6wAVJMMRNtQewGSELAnpTPOriiCPpECU4wgFgefYVoTMXl+
 AFv1jfGNyLZHvCgG6EQ3bEaPR8mHQuV6lQxRicDFGkWXbaWnivZLeV4rtSDLv0YIp+2dFGXPo
 r4pbiVBoObOFkSxjdFOESomvwFMZ+WDejXksuGuYUmpqWKF28L7QCGbKRKYcYPTx0oJMEcw29
 19aMUnO6NAnuya1by8kfu3oYD+BClP5QPVE7zQNrtoYQlaSKz3U7um5shIsNHx/qOBG6j6K+B
 R0J9PEH5SwgBYkQAe8e3qG4iAbG9NA3TUaAnD9b3ls62LK9T9GlzsAwTCoVXAAxsZv0SIszVh
 +JlEVdoGCJgJDnZH15wXnr/HBJI7XY19FoAubzJiwydi3zOmM4Ek5sl+0misnYq25OaRF94nb
 dKczZF1y5yqvx5+iIH8tHd9/nPAjpNsrtGrPLhaGbzElyDKQoZ3lO/Awv2NEtxUIxufi0R9K3
 I9CxDwTU2GmXz7fpa7HOPdtxyO4Dklz6yIXYrPBXVgnbmEDY3rZIapDpMgY1KFFIx+Gau7vwE
 fvGJcaASg06uyfpyCfLVFZp1hufAEjCWfKGXvzg4Z3ALQhXq7K0OM148H0xGhaLmUsChfWsNy
 kFU74FQcsea5NR8Wyq4nNARkjt8L87mBeOIMw2IoHaqG4OYdtjJEK2LfLheH8Uy9LsCAyPkdt
 6R4PZ5SZR9MPMmck1eBP49TBazMnDriOZCtiqXd3X6scR5S+shgtM+F7av/GO/3yGtneUT2mj
 RDewS8HHPiLPoUJrWDdiuvp7xr9+GqSSbIVzC+SuMktbpJvdZY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 9 Apr 2018, Elijah Newren wrote:

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 1701fe2a06..0591d9a7f8 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -145,12 +145,28 @@ test_pause () {
>  	"$SHELL_PATH" <&6 >&5 2>&7
>  }
>  
> -# Wrap git in gdb. Adding this to a command can make it easier to
> -# understand what is going on in a failing test.
> +# Wrap git with a debugger. Adding this to a command can make it easier
> +# to understand what is going on in a failing test.
>  #
> -# Example: "debug git checkout master".
> +# Examples:
> +#     debug git checkout master
> +#     debug --debugger=nemiver git $ARGS
> +#     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
>  debug () {
> -	 GIT_TEST_GDB=1 "$@" <&6 >&5 2>&7
> +	case "$1" in
> +	-d)
> +		DBG_FLAGS="$2" &&

Maybe we can find a way that does not require setting a variable other
than GIT_DEBUGGER? After all, DBG_FLAGS will be visible to the script
calling `debug`...

> +		shift 2
> +		;;
> +	--debugger=*)
> +		DBG_FLAGS="${1#*=}" &&
> +		shift 1
> +		;;
> +	*)
> +		DBG_FLAGS=1
> +		;;
> +	esac &&
> +	GIT_DEBUGGER="${DBG_FLAGS}" "$@" <&6 >&5 2>&7
>  }
>  
>  # Call test_commit with the arguments
> diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
> index 22b6e4948f..376c056842 100644
> --- a/wrap-for-bin.sh
> +++ b/wrap-for-bin.sh
> @@ -20,10 +20,17 @@ PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
>  
>  export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
>  
> -if test -n "$GIT_TEST_GDB"
> -then
> -	unset GIT_TEST_GDB
> -	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> -else
> +case "$GIT_DEBUGGER" in
> +'')
>  	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> -fi
> +	;;
> +1)
> +	unset GIT_DEBUGGER
> +	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
> +	;;
> +*)
> +	GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
> +	unset GIT_DEBUGGER
> +	exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@@PROG@@" "$@"

It may not be a big deal, bug GIT_DEBUGGER_ARGS (if it was exported e.g.
by the user calling the script) is now visible by the called process... (I
thought I had tried my best to avoid such a leaking variable in my
patch...)

Thanks,
Dscho
