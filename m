Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA041F461
	for <e@80x24.org>; Sun,  1 Sep 2019 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfIAS61 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 14:58:27 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36758 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfIAS60 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 14:58:26 -0400
Received: by mail-ua1-f67.google.com with SMTP id n6so431315uaq.3
        for <git@vger.kernel.org>; Sun, 01 Sep 2019 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEIqqVQad2A7gWSLnCrSbfuuw8Ru485Pn59HqjhU+5g=;
        b=HezFK5UH+tUSTHarRX7SoD9RcpXcFNBZSar5VaGfGwKJENu3+RrjlM1trC0z2WcTmR
         rzckaLZ9U18lsZH/eRLv2t7VUauFwMxQO9WZH1lMHKCn5A/3kdgV39lbaoZutxfLKa/P
         aVgODAl5iJo/4jT7QNK27+d+yN5O9aih3G1LACKzkUu4pFKtEoDlo6t/GABsR1AAEUbM
         wYJ6eD6mdcP9DxAC4qt8zLNVkd6iGl5FGxE20ZWemfdZycTSyPJz7UsGPjT6PLJFeflU
         tG7TbqWzLFub7zZcMs5ZXthBGxB4E4uc0R0aUT9QM5AW47razq93fp3GpvmT8c9eCrfU
         0kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEIqqVQad2A7gWSLnCrSbfuuw8Ru485Pn59HqjhU+5g=;
        b=ow9QevIz6y23TVU0DmoKAXSddPfQxCbiXHplXwsDfyZPTlxZYXtLdXxl6gen379icD
         qRxfdx5k70QwUzzRlwHacilLNvfS5NovtDXLo1782OX2LtEobod1MytfhqshRZhqn0Rf
         rIHu6BDDmg/1/Lrzkyw+hliEDXWS+dkmYIe+mvzMXFjb+1chdoqJHJt+r1k2A4ZvobO+
         f83JSeOJAd2AS7d6pa7PssBzNIjajQnzjTOGjQsiZb3mQflmkAzop16+QW+4f/Z8FGce
         2p3RSIRmI2UGb9+jpelA4V5I3QxmwDrbqr4eailGC9BDr5MDdi2O+XZjNVsbDsFfDmdf
         F8WA==
X-Gm-Message-State: APjAAAX1GxedsxZcNPF0LFz6qR0Z7HIyck7QZf9sfWLbIr1jgoiorf1g
        ggKzMUpDxy+ETANgkJrmBJNMOspcFArFiQODmWo=
X-Google-Smtp-Source: APXvYqw1CXiKfDYl4CiZyQPtn8Shs9z6jlyISdCsZDZ3xApIIjgaxy1dF9EWhtMhNuff/V1Gyt7yQ8MVk5sXgA2Kb/o=
X-Received: by 2002:ab0:308c:: with SMTP id h12mr11948215ual.76.1567364305855;
 Sun, 01 Sep 2019 11:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com> <20190831122326.9071-1-birger.sp@gmail.com>
In-Reply-To: <20190831122326.9071-1-birger.sp@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sun, 1 Sep 2019 20:58:15 +0200
Message-ID: <CAKPyHN0+KQTNe=Wc_6KEpbtd-KS1Y6a9ad=dpq9QFR-F5tvpEA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

On Sat, Aug 31, 2019 at 2:23 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> The user cannot change focus between the list of files, the diff view and
> the commit message widgets without using the mouse (clicking either of
> the four widgets ).

that bugged me two, but never come up with a good idea.

>
> Hotkeys CTRL/CMD+number (1-4) now focuses a previously selected path from
> either the "Unstaged Changes" or "Staged Changes", the diff view or the
> commit message dialog widgets, respectively. This enables the user to
> select/unselect files, view the diff and create a commit in git-gui
> using keyboard-only.

But I don't understand this in full. Does this mean pressing CTRL+1 or
+2 does also changes the file selection? Why isn't it sufficient to
just focus the respective file list widget? And than have bindings to
change the selection?

Bert

>
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> ---
>  git-gui/git-gui.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 6de74ce639..cbd0b69804 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2494,7 +2494,7 @@ proc force_first_diff {after} {
>
>  proc toggle_or_diff {mode w args} {
>         global file_states file_lists current_diff_path ui_index ui_workdir
> -       global last_clicked selected_paths
> +       global last_clicked selected_paths file_lists_last_clicked
>
>         if {$mode eq "click"} {
>                 foreach {x y} $args break
> @@ -2551,6 +2551,8 @@ proc toggle_or_diff {mode w args} {
>         $ui_index tag remove in_sel 0.0 end
>         $ui_workdir tag remove in_sel 0.0 end
>
> +       set file_lists_last_clicked($w) $lno
> +
>         # Determine the state of the file
>         if {[info exists file_states($path)]} {
>                 set state [lindex $file_states($path) 0]
> @@ -2664,6 +2666,51 @@ proc show_less_context {} {
>         }
>  }
>
> +proc select_first_path {w} {
> +       global file_lists last_clicked selected_paths ui_workdir
> +       global file_lists_last_clicked
> +
> +       set _list_length [llength $file_lists($w)]
> +
> +       if {$_list_length > 0} {
> +
> +               set _index $file_lists_last_clicked($w)
> +
> +               if {$_index eq {}} {
> +                       set _index 1
> +               } elseif {$_index > $_list_length} {
> +                       set _index $_list_length
> +               }
> +
> +               focus $w
> +               set last_clicked [list $w $_index]
> +               set path [lindex $file_lists($w) [expr $_index - 1]]
> +               array unset selected_paths
> +               set selected_paths($path) 1
> +               show_diff $path $w
> +       }
> +}
> +
> +proc select_first_unstaged_changes_path {} {
> +       global ui_workdir
> +       select_first_path $ui_workdir
> +}
> +
> +proc select_first_staged_changes_path {} {
> +       global ui_index
> +       select_first_path $ui_index
> +}
> +
> +proc focus_diff {} {
> +       global ui_diff
> +       focus $ui_diff
> +}
> +
> +proc focus_commit_message {} {
> +       global ui_comm
> +       focus $ui_comm
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -3877,6 +3924,14 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>
> +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
> +bind . <$M1B-Key-2> {select_first_staged_changes_path}
> +bind . <$M1B-Key-3> {focus_diff}
> +bind . <$M1B-Key-4> {focus_commit_message}
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
