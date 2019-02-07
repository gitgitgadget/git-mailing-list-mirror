Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD031F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfBGWc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:32:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:50437 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfBGWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:32:56 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lkjuq-1hPq452Ufk-00aUGt; Thu, 07
 Feb 2019 23:32:49 +0100
Date:   Thu, 7 Feb 2019 23:32:49 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
In-Reply-To: <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
References: <20190207183736.9299-1-szeder.dev@gmail.com> <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com> <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com> <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4J5DJA/1+RUm5HC9a6IXWLGSI35VjHFRal0nq6V2hllbnaMjYgS
 9y6JkSvc+N8datkpDufgsVBaWPjVCNg+e9+sR1XNzGbHkSYo+mA/sKgTpSqzx0ugEA4mhBj
 BipzWVn2wch4zPINhmzn2XwKGV77muXY5uDCOUwtdg5tYODW4NgrzA4HCYJyTP8gqJb4irW
 CXGpmLR1Buc7KvZHqT86w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fwDte9yJcg=:YSpKpNBm8gjMw4z4tQkdXp
 BtJYiETu8rFeox6J57RKHnOwKcuq82TlwLREyvrKBX1jQN81NsQgTQHUXt8C+LWHe/mV8tpdm
 zxW9sPPNg6VxtJLZuGJkoshPfSCCr/o0lYxpZxMOhcG3KcUtK8rN7RAfqMuw6otdiGHWyMmj0
 v1RPM3yrNQZXjy+4rhvLtRTzOlUGnI7bSXQ3Oy9ShT8tmpXyv1vGvr3yrROwn4on5U8BrI9A1
 d1GkHqU2dDMIoP0HC/WR5d3bJrY2GoMVPsm9yHpw1CgdIs645ZFre/Il2cplMW+i7MhicxVrj
 VRtYHBGrfXO/EEEAoKSwL4/vxJe+RO/9qkQUWgACFTajNDXsi7p7k0nIHgOR1v+4o+SafSvh9
 EnqjgL/7Kc/TIGPebBWA1nJr0U4nOU4Ylse2JGDxzkqd5NjsZcyXQdSlqCASBCkTqF7eT88ar
 /oDLbXr3A0ULHQglIB/hggY1bnL6TJaUjh4qYTBhQji42wCv669Te4RQ5WVJo8b692eWYdAhz
 +6KBuEPONwVMQfLC+U9q7t54tM8vLNTXzzY3iMQ7EsaQh4ZbIS74GFjKcjE9t+TxIISaIRauP
 0pxjJpAuzCp1NPos1w8+2AbsFh8A3fC0AZYzHUsnb6PpZH8PPkg1nRL1sAnrWj8L4Zi4M/R+o
 qkmU5Xb/Hy567Eua/xscPWCJYrJJ0zT1kQQZqVxAuHCIGkud+vHkS5c5vU9dKCnmPsG++eXdw
 HirashJdg8agnIVEgXYjy+3DlK4druMG+5AVXqJTtj5nSMW588wPj517isUQu+t/Fg+TJEr32
 WJwp+N2hIExdXoVogTu5RCMIst59pVwyBgJPpieeVS1DVgVrgaFu3GIFlxFI1FU4r0AA6X7dc
 zrZqci4f1YRaEtVsSeco3gsecuG9LHm0MKXSS8t4NlULXI3w0YuUHBE+RisH+abTPvWiM7Ijz
 jCgQpDIw3zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Feb 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Wouldn't all other hits of "MAKEFLAGS=" in ci/lib.sh also want the
> > same treatment, though?  We know that "if travis to this, otherwise
> > if Asure, do that" is the first block to muck with MAKEFLAGS in the
> > script, but a new assignment before that block can be added in the
> > future and cause a similar issue unless we do so.
> >
> > Of course, at some point we do want to say "we do not want to
> > inherit it from the outside environment", but then such an
> > assignment of empty value should be done at the very beginning with
> > a comment, not with "this happens to be the first one to set, so
> > let's not append but assign to clear any previous value", I would
> > think.
> 
> That is, in a patch form on top of yours, something like this.
> 
> 
>  ci/lib.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/lib.sh b/ci/lib.sh
> index cee51a4cc4..288a5b3884 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -74,6 +74,9 @@ check_unignored_build_artifacts ()
>  	}
>  }
>  
> +# Clear MAKEFLAGS that may come from the outside world.
> +export MAKEFLAGS=
> +
>  # Set 'exit on error' for all CI scripts to let the caller know that
>  # something went wrong.
>  # Set tracing executed commands, primarily setting environment variables
> @@ -101,7 +104,7 @@ then
>  	BREW_INSTALL_PACKAGES="git-lfs gettext"
>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> -	export MAKEFLAGS="--jobs=2"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=2"
>  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
>  then
>  	CI_TYPE=azure-pipelines
> @@ -126,7 +129,7 @@ then
>  	BREW_INSTALL_PACKAGES=gcc@8
>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> -	export MAKEFLAGS="--jobs=10"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>  	test windows_nt != "$CI_OS_NAME" ||
>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
>  else
> @@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
>  	;;
>  esac
>  
> -export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
> +MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"

Since this is intended to be run in a CI setting, there is not a whole lot
of opportunity to set `MAKEFLAGS` outside of the script. And if there is,
that might open a rabbit hole when debugging issues that somehow in the
end turn out to come from a hard-coded `MAKEFLAGS` somewhere in the CI
system.

So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where you `export
MAKEFLAGS`, I'd simply append a `=`).

Ciao,
Dscho
