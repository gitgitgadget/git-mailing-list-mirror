Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945AD1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 19:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfIBTmZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 15:42:25 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46755 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfIBTmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 15:42:25 -0400
Received: by mail-vk1-f195.google.com with SMTP id m195so3089986vke.13
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+KxvuUDrKWeVJanzdhHs0+f8HpufTR7MnVkeJYzxRs=;
        b=Q1ZhRSEOcx5RRqqC2A2MLDF+kOyShD9qE7ZfxToTvLFE1LAFy2JwdXg6tN61C4Hot1
         qL8vgPOvwANj/DNaEqx40f3WjcREg98qRlhQ96C9R0eC5FD5JIz2OA2VEknkccAZlGGp
         dybTb8X9Y3ZPGQbouN7FQjO0OFTZYTxTkZ8kZKh47u8ULOFzoL/r+QtlqeW9L9PVUTnF
         TJaULUNtBUYYMeUZ2ZSQhaRYu06jGZvcPOtCnrVqyi5UcOG6k5TEncExC+S9P3NSPErh
         9fYMqqTsVhIXGaKoWnJENn/c84lnk3tekl4UW9BeEgAi7k6tnlpJq87eoj8V+63KmvML
         sm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+KxvuUDrKWeVJanzdhHs0+f8HpufTR7MnVkeJYzxRs=;
        b=Qbj5BJ4D4Y63atOQMxEz4Yr7rwYnmGWbCIgcOlc2yEaxC1991ecmQj1A3L4GzkLDYK
         pWaaFFNw01MwLnZnTHdW3jEieEuafa4xFYuatWqcvynCKJtpyMaBnDz1nwgHZ09zzvrB
         F+4r9FX7hrwyeM8BiyzpxRE0mW2arugtiprDaGoLLJB4Y2WAqI8g1ZtkLo7yanR/iIJq
         lK9syF993D2P0vrdj1qGiMyW+MHyXq7+WP2lQgox4+0aNbFgI2QU0NsNOIqBr3XiB9oU
         zHCm/ucxfG1LLCFYYWhZ4hNT4tJCDf/bF5M5E9GpH5uYdyye4vrl36Ba/+Ng+2oGvScU
         to9w==
X-Gm-Message-State: APjAAAXa79swtlJhvNqfKKirfnlDJaLZMWX6EoSgxBLJdAygdTbYKVxf
        5Jhfh0bmtYyYxhG1ECgwiUAZMkKE5RU1OxiL7bg=
X-Google-Smtp-Source: APXvYqzFKrCqqf+JURIimi5kHUfukatV4hvW0P0dYgQyvWTtZG9FJPnv4iPh1Xf88DQUNIk6JpP30NdOt2nqizG6JVo=
X-Received: by 2002:a1f:3cc9:: with SMTP id j192mr5241204vka.58.1567453343905;
 Mon, 02 Sep 2019 12:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com>
In-Reply-To: <20190901193652.21086-1-birger.sp@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Mon, 2 Sep 2019 21:42:12 +0200
Message-ID: <CAKPyHN0LtOG9mFQ6qxc-w-EdpJ3HGJmHAGdrGp2FKkq4uCf55A@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 1, 2019 at 9:37 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> The user cannot change focus between the list of files, the diff view and
> the commit message widgets without using the mouse (clicking either of
> the four widgets).
>
> With this patch, the user may set ui focus to the previously selected path
> in either the "Unstaged Changes" or "Staged Changes" widgets, using
> CTRL/CMD+1 or CTRL/CMD+2.
>
> The user may also set the ui focus to the diff view widget with
> CTRL/CMD+3, or to the commit message widget with CTRL/CMD+4.
>
> This enables the user to select/unselect files, view the diff and create a
> commit in git-gui using keyboard-only.
>
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui.sh | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..ce620f1 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2495,7 +2495,7 @@ proc force_first_diff {after} {
>
>  proc toggle_or_diff {mode w args} {
>         global file_states file_lists current_diff_path ui_index ui_workdir
> -       global last_clicked selected_paths
> +       global last_clicked selected_paths file_lists_last_clicked
>
>         if {$mode eq "click"} {
>                 foreach {x y} $args break
> @@ -2527,6 +2527,8 @@ proc toggle_or_diff {mode w args} {
>         $ui_index tag remove in_sel 0.0 end
>         $ui_workdir tag remove in_sel 0.0 end
>
> +       set file_lists_last_clicked($w) $lno

So we only remember the lno in the widget, that could mean, that we
select the wrong file after a rescan, which shifted the previous path
one down. Can we remember the pathname instead, and try to find this
again in the file list?

> +
>         # Determine the state of the file
>         if {[info exists file_states($path)]} {
>                 set state [lindex $file_states($path) 0]
> @@ -2640,6 +2642,29 @@ proc show_less_context {} {
>         }
>  }
>
> +proc select_path_in {widget} {

can we name it 'focus_and_select_path_in', as the main job ob this
function is to focus the widget. It makes also the 'bind' command
below more readily, because than all bind commands start with 'focus'.

> +       global file_lists last_clicked selected_paths ui_workdir

ui_workdir not referenced in this function

> +       global file_lists_last_clicked
> +
> +       set _list_length [llength $file_lists($widget)]
> +       if {$_list_length > 0} {
> +
> +               set _index $file_lists_last_clicked($widget)

I have the impression that variables starting with '_' are mainly used
as read-only global variables, see the list at line 158, and not that
often as temporal local variables.

> +               if {$_index eq {}} {
> +                       set _index 1
> +               } elseif {$_index > $_list_length} {
> +                       set _index $_list_length
> +               }
> +
> +               focus $widget
> +               set last_clicked [list $widget $_index]
> +               set path [lindex $file_lists($widget) [expr $_index - 1]]
> +               array unset selected_paths
> +               set selected_paths($path) 1
> +               show_diff $path $widget
> +       }
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3852,6 +3877,14 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>
> +bind . <$M1B-Key-1> {select_path_in $::ui_workdir}
> +bind . <$M1B-Key-2> {select_path_in $::ui_index}
> +bind . <$M1B-Key-3> {focus $::ui_diff}
> +bind . <$M1B-Key-4> {focus $::ui_comm}

I would like to bring up a proposal: AFAICS, more or less all CTRL
bindings have a menu entry. But it does not make sense to have a menu
entry for these bindings. And I think we could add more bindings for
keyboard-afine users. Thus I would like to propose to use ALT as the
modifier for these bindings, which would give us a nice binding
classification.

How about that?

Bert

> +
> +set file_lists_last_clicked($ui_index) {}
> +set file_lists_last_clicked($ui_workdir) {}
> +
>  set file_lists($ui_index) [list]
>  set file_lists($ui_workdir) [list]
>
> --
> 2.23.0.37.g745f681289
>
