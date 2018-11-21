Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1785E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 14:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeKVAlM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 19:41:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:51585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbeKVAlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 19:41:11 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldcv0-1fi7hp0jvW-00ikt1; Wed, 21
 Nov 2018 15:06:35 +0100
Date:   Wed, 21 Nov 2018 15:06:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Carlo Arenas <carenas@gmail.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] legacy-rebase: backport -C<n> and --whitespace=<option>
 checks
In-Reply-To: <xmqqin0r82mu.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811211506120.41@tvgsbejvaqbjf.bet>
References: <pull.86.git.gitgitgadget@gmail.com> <84e65a4efb3d58ca777cd59c52fe86d63060ea9e.1542744118.git.gitgitgadget@gmail.com> <CAPUEspgxNm9oEA-fuT7kBegEp5F2za5Nm6CSvFkMB+Kz_pNbrw@mail.gmail.com> <xmqqin0r82mu.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1804597446-1542809195=:41"
X-Provags-ID: V03:K1:5d2f2npEzCBekt+WRsUuDKy07jtxPi5Jt9bj5pqCxJneYc7KVAQ
 v7cxhZdgzhoSqpMNUs+d3fZJ2JEitZoecr3W1B5KZ5tgXxWQD44BPUtPnCU0ZtzyiiRq8GS
 8ivCV2nHlbhHy/O/X1jzD2laSnfy2MPpCoEEFrG1ACXIc1qS9XyYaW2ZejOh5Vxj5QcM/kl
 GizKtWEpMls3cijOTJ67Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6axJxak/BM=:Hy63MHN0UWKuB/y/cqNf2B
 rP2wenAnOnuD+c5ulib3YmK0odp4JnvM9I2/72hp2uFe/WdSwDax3rRe4C8DE8TmEwoZPNEEN
 nCpKSCzGSxJPsWPxKrqPG4drG7tJs97WPFPhz7w9QCRNEvR03b2gOq5JUV/qa9RdVMzjQyPbB
 0xrCWEoIiwh8O7JGDxRkiQPnsmR5JC6KaLqluMtkhFAGt2u06CNBnEwm/JjQubXA+2juflbUp
 QIp94I1yz0o8M96EmiZHl4rY0EAytuYfHY6/JG5Gx2v5Esjl6ap+m09+6E2ytzuzdOcOHrmKF
 Vd0lT8svqrie19Ea+Kfz8j5JK/HK1qMuR2v4ZfcUCds5VFucfXOaDdguKYS51MVxfxOQIuu/1
 0/877BAeh6jmvW/fFVID84oL82YCc67D/+kS5RN/kysrJH2Ri8IUpE98B6df8q8y95EtBkZvs
 1O+N0oQ2M/y4k0wKLLP+Dh4UN9Ovpo+UdaXuOVfIKz+iZW1I608dhkIyNKv4bNoMDgFDFXddy
 AI65U2ft9GJVUHMrb2nsZxMVmcK3ctJPjgf/ntf7iEqEF747GG5y970OQtA2CWU6HzTKG+0z1
 W15nVaGXwOp6zPdQtmJgxbHgqcd4/1OxcPjJQ0geQEGpn2HTHyMHcgcq7L1/DPeXZVbldSMRM
 duHDlPNJn/EqJ7K4bTbiMnowdQgq6aHBEFcHh5Ws/nk71d3UChTlrm08zhjnpY7eefKAS9+kS
 LMt7gvuCtWOU9DycjIz5nzk99+BOM/5okzqQa1bkLzX0HhTUjNOG/9AbSIJnM89v5w0CCcUBP
 C8pLVq89vcpVhh4gxfdolvxToEfS8TtxQFfiD/EGViP78NhQJjSe+rKnSuTiBTcBZXFeKfnFn
 PA7jD3GhDwfxgiUa8wQ4mZlI6pQf84zxy6gI2cEmY8mOyft71fqCP3KNO1aOYp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1804597446-1542809195=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Wed, 21 Nov 2018, Junio C Hamano wrote:

> Carlo Arenas <carenas@gmail.com> writes:
> 
> > Tested-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> >
> > the C version prepends: "fatal: " unlike the shell version for both
> > error messages
> 
> In addition, "Invalid whitespace option" says 'bad', not
> '--whitespace=bad', in the builtin version.
> 
> I think the following would address both issues.

Yes! Thank you. Can you squash it in?

Thanks,
Dscho

> 
> 
>  git-legacy-rebase.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
> index ced0635326..b97ffdc9dd 100755
> --- a/git-legacy-rebase.sh
> +++ b/git-legacy-rebase.sh
> @@ -340,7 +340,7 @@ do
>  		warn|nowarn|error|error-all)
>  			;; # okay, known whitespace option
>  		*)
> -			die "Invalid whitespace option: '${1%*=}'"
> +			die "fatal: Invalid whitespace option: '${1#*=}'"
>  			;;
>  		esac
>  		;;
> @@ -358,7 +358,7 @@ do
>  		force_rebase=t
>  		;;
>  	-C*[!0-9]*)
> -		die "switch \`C' expects a numerical value"
> +		die "fatal: switch \`C' expects a numerical value"
>  		;;
>  	-C*)
>  		git_am_opt="$git_am_opt $1"
> 
> 
> 
--8323328-1804597446-1542809195=:41--
