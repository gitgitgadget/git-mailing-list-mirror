Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469EA200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeEGBXd (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:23:33 -0400
Received: from mout.gmx.net ([212.227.15.18]:57187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeEGBXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:23:32 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1fE7xY2FBl-001PK5; Mon, 07
 May 2018 03:23:25 +0200
Date:   Sun, 6 May 2018 21:23:20 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 18/18] completion: support branch-diff
In-Reply-To: <20180506082440.GA26958@duynguyen.home>
Message-ID: <nycvar.QRO.7.76.6.1805062122150.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de> <20180506082440.GA26958@duynguyen.home>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ElTEpcviRiRSklwGeDMm0nHw1v8e2i8LAc0G5nQRBSiQ3tEqMLX
 wpNUW8iwd6vWfyWAw4ZXjT9/RYCsC9yX5CrKIVPlIyf/jbblH+Q04ncLWILYfAr/wUw8UPq
 bpcK4lDWb77VRkXlyr3ZfJuucu3T/tCUZSCljtuTL0pLbyo/CqNBBCS8eBlLJOeSdItDjAM
 9TU8w3IEQf9k1LMcPD2nA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h5LCF2xCVnE=:vYwDBYfVVFNevi2FmzowuR
 YnZq1ND7WsihsWaHNKrLFht01EsastlXxBavf+HbrJCpzAPQkXYVR7P3R0aCAB8op9jVIEp12
 eEBDlqgAJBJBNkqhZrTr/qy1m9EGneRgMDyzQ0ySlErVEF5dWZCi0psc5wrffXEcKU+C2+h82
 NsYLT/YTQeD+n1BXPSLiUQLYHg+yqUQqKXLNO37jwwFoVO+aXb7PSWbwkiC2zt4KGXFx10r70
 wV3+7qsmIF9mv4fcjf79WklXPdmbiLRE7r25WsDmfNXe2/2ThUuVOmS0vaJF0vS6raxc2eWF5
 ISI90kBvpIdpU+7NtamLmIgxine9tQRWE0JWv1geDdmt2vENe9unu4261mqL/7bjkjn8JJSMj
 LB+sO41z9G+HTlFs9xCp4W+QpWMlReftj8BKmdUysvVGBoB0EOzXMbMrArf6Gv/tQQQo+CA4U
 d6FleCZawz+aRoDbg+9aJ0R3X5gJvsoWSaZ6vCdqSiDskFVgbFg07EYJDWc8iipILUtKnaSvR
 kt75FYNDYj2gcHShgXlCNaHEIkG4H+DfYqeSt8B5aUDP7KvoA8QuI5L9CX27vHGt/DtxKKA6r
 Eb3i3KGtDVLtO6g3sp8CUcAJnOdB4LncU9rvTBZkiLdKjESDPaw3IldgQMRtXf6oG1+AvR5Ls
 Mu+HCgLo2sWBQsX74TilY4Oekzkxg2PadqR0DoCZEXcI59d1FXMcIv5HUFNXR8HjtNkQ6qUNz
 MO4x1xCDvF2FXD+QQShAVSOh0S6CKfZqAQ2+JNBiCqIk5OqJ9TqxPS1D0hwQNEUvkuU5g+hmZ
 1n7bQor
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sun, 6 May 2018, Duy Nguyen wrote:

> On Fri, May 04, 2018 at 05:35:11PM +0200, Johannes Schindelin wrote:
> > Tab completion of `branch-diff` is very convenient, especially given
> > that the revision arguments that need to be passed to `git branch-diff`
> > are typically more complex than, say, your grandfather's `git log`
> > arguments.
> > 
> > Without this patch, we would only complete the `branch-diff` part but
> > not the options and other arguments.
> > 
> > This of itself may already be slightly disruptive for well-trained
> > fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
> > `git branch origin/master`, as we now no longer automatically append a
> > space after completing `git branch`: this is now ambiguous.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  contrib/completion/git-completion.bash | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 01dd9ff07a2..45addd525ac 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1496,6 +1496,24 @@ _git_format_patch ()
> >  	__git_complete_revlist
> >  }
> >  
> > +__git_branch_diff_options="
> > +	--no-patches --creation-weight= --dual-color
> > +"
> > +
> > +_git_branch_diff ()
> > +{
> > +	case "$cur" in
> > +	--*)
> > +		__gitcomp "
> 
> You should use __gitcomp_builtin so you don't have to maintain
> $__git_branch_diff_options here. Something like this
> 
> -- 8< --
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 45addd525a..4745631daf 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1496,18 +1496,11 @@ _git_format_patch ()
>  	__git_complete_revlist
>  }
>  
> -__git_branch_diff_options="
> -	--no-patches --creation-weight= --dual-color
> -"
> -
>  _git_branch_diff ()
>  {
>  	case "$cur" in
>  	--*)
> -		__gitcomp "
> -			$__git_branch_diff_options
> -			$__git_diff_common_options
> -			"
> +		__gitcomp_builtin branch-diff "$__git_diff_common_options"
>  		return
>  		;;
>  	esac
> -- 8< --

Does this really work? I have this instead, for now, and verified that it
works:

-- snipsnap --
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index 01dd9ff07a2..c498c053881 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1205,13 +1205,14 @@ _git_bisect ()

 _git_branch ()
 {
-       local i c=1 only_local_ref="n" has_r="n"
+       local i c=1 only_local_ref="n" has_r="n" diff_mode="n"

        while [ $c -lt $cword ]; do
                i="${words[c]}"
                case "$i" in
                -d|--delete|-m|--move)  only_local_ref="y" ;;
                -r|--remotes)           has_r="y" ;;
+               --diff)                 diff_mode="y" ;;
                esac
                ((c++))
        done
@@ -1221,11 +1222,22 @@ _git_branch ()
                __git_complete_refs --cur="${cur##--set-upstream-to=}"
                ;;
        --*)
+               if [ $diff_mode = "y" ]; then
+                       __gitcomp "
+                               --creation-factor= --dual-color
+                               $__git_diff_common_options
+                               "
+                       return
+               fi
                __gitcomp_builtin branch "--no-color --no-abbrev
                        --no-track --no-column
                        "
                ;;
        *)
+               if [ $diff_mode = "y" ]; then
+                       __git_complete_revlist
+                       return
+               fi
                if [ $only_local_ref = "y" -a $has_r = "n" ]; then
                        __gitcomp_direct "$(__git_heads "" "$cur" " ")"
                else

