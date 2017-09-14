Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E170209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 12:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdINMzH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 08:55:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:52487 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdINMzF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 08:55:05 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M81vR-1dWo7547mr-00vdKe; Thu, 14
 Sep 2017 14:54:55 +0200
Date:   Thu, 14 Sep 2017 14:54:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     Michael J Gruber <git@grubix.eu>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: don't use ulimit in test prerequisites on
 cygwin
In-Reply-To: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
Message-ID: <alpine.DEB.2.21.1.1709141440510.4132@virtualbox>
References: <b57731ed-4640-d27f-f7b2-6c70af8dd400@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YZr95N7+HjnbEu0xjtWvJN1dXNQwvAwVM6q/YkHspqTfkADVo+W
 VgQcx1d9XiQHjhczYWOogmePLELkbzDiLY1xkHt4/qNTHzhw5VRhuR3sgGwKMr71GFACcaF
 iVSqLORvhxlKapZwwT+PBURcdJBnvEbrlBAGmgR/wCAJOZiCEYJfEq97zyv3p2HH97bizeE
 UDrQprVkiaAKBPR4s243g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a753mInTtPE=:QJ2AnhBdfQT5U/P96ZOPHT
 4GsJFOXEBfTaPzvm+GDxsoDaW0XZs3R1lA89IWnDtRTWcHQSj55GTXomvboKM9cwE6MYPKKSZ
 K4v6LWNhT/z0bv1qxw8p8QdWMQCrtkXnbXbTNMIC60GcB3cyR11r3ZN+NXRbcStDsa6mRMWG5
 o8VWxSafeHceL5t7SQeu9IeAmHNbkkWeq57o8879FZjXINK0AD2Y07p+S0w4m8fWWoH1zsbd0
 gUGd3BPegBF55s8UNYJVT5g5e6wEbP8P295W80/GRABm+kdKKYtE5z8Z2fsZkEBlNnA7NlKFS
 dP+1QsUC7SndduBmFxTaUpXINIRTGUV4hQ7kaH9N4E1sPTlwzMmbVwqVqiJFID/TnbJQXCWQd
 SochS/u5bgy43GBnrJqczB1d6eOri4DwmoauvNx82M+uReNSanwCBeMMjPslkQHSCSF3P0fLi
 EYBBeihX0KSChN4Y7RpuphbWO5clrLQhT6ixuLfK1CATjaLodcOe/g5wKpMyt16+rAMC0s00m
 ZiaZGfnZ0xdE0kVXaIjF1zyjivRJmsfA7ySL5stJwZm23BEuefiDGu/nJwQ56xl6cho48DecB
 nBJDqGpRYHlEHZ4EY/klj0iFGlercndxApPUoiiEtumAfac6XPu8odQc6FL+R5eK4qxTOyMKC
 mRv1hBaYbqB85982bi6m2NMmtKERvfkZYvGc5kyyYXQqqUm78BHpHyJmJObb4oZzEpoXmQAI7
 byfyyq97cQBl8I3hK5tqx10X8QVTUMdK3PbMdENt7V8a6Hiu7oddG1MqgL6Kfq8lfavHwUm/c
 zIv25k5nRWz4mffm/Yq4gwtz5qNMuIi6YdIB0EQy1eqRXW10QI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Wed, 13 Sep 2017, Ramsay Jones wrote:

> So, I finally got around to testing ulimit with open files and
> found that it does not limit them on cygwin (it actually fails
> on the hard limit of 3200).

Thank you!

> Having seen Johannes email earlier, I took a chance and added MinGW to
> this patch as well. (Hopefully this won't cause any screams!) ;-)

It earns you my gratitude instead.

If you want to see the difference between the MSYS2 runtime (Git for
Windows flavor) and the Cygwin runtime, the patches applied on top of the
Cygwin runtime's source code can be seen here:

https://github.com/git-for-windows/MSYS2-packages/tree/master/msys2-runtime

The current overall diff can be inspected here:

https://github.com/git-for-windows/msys2-runtime/compare/aca9144e65ba...874e2c8efeed

The changes are not *all* that extensive, revolving more around the
Windows <-> POSIX path conversion (I am actually no longer certain that
the characterisation of "POSIX path" is correct, think about VMS still
being considered POSIX...).

There is also some stuff about environment variables, but that's about it.

Most importantly, the core code (such as ulimit functionality) seems not
to be changed at all IIAC.

Meaning: I agree with your assessment to enable the workaround also for
`uname -s` starting with MINGW.

One suggestion:

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index dc98b4bc6..49415074f 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1253,7 +1253,16 @@ run_with_limited_open_files () {
>  	(ulimit -n 32 && "$@")
>  }
>  
> -test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
> +test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
> +	case $(uname -s) in
> +	CYGWIN*|MINGW*)
> +		false
> +		;;
> +	*)
> +		run_with_limited_open_files true
> +		;;
> +	esac
> +'

It would be more semantically meanginful to do this instead:

-test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
+test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
+	test_have_prereq !MINGW,!CYGWIN && run_with_limited_open_files true
+'

In other words, *spell out* that we want neither MINGW nor CYGWIN as
prerequisites before testing ulimit with that shell function.

It would also be a little more succinct.

Ciao,
Dscho
