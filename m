Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C5F1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 16:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeBWQm1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 11:42:27 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44913 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbeBWQmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 11:42:24 -0500
Received: by mail-oi0-f68.google.com with SMTP id b8so6280192oib.11
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 08:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=lFPg5dMvp53VuW7uf995jm8z8xMQtp92wHl+vFt2Uf0=;
        b=ZM72EZts+3pBdJvSYWwOtxL//h+L84x8xix0AwUX+XFeT+CSNP4R9HV71dKfN8No8Z
         G9YVpe7xW7/EWCjm7lWdGvuA0POYoK/n90lkTwPqIDcWBVJ9nkOekbXYR8m9rFfX8j3k
         mpAnlz49ATRnEkuTfbe0GUzjBvK4mbFn8EQCr+f9+oyDbxD7zMe6fBH9ZsrT8J1U65WP
         6DeDC49O/g0DrOePjLGkM1CKLJAmCGLGq2JfhcrdgUtOgc8G0Iv8tBmjfOGb6clYDj98
         2t6c4mE0NRB2hSUtiRjfX9iXqZ+ligkZAJiVGGFy65EidbFKDW7cY6mT7oBoqB+vceml
         52kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=lFPg5dMvp53VuW7uf995jm8z8xMQtp92wHl+vFt2Uf0=;
        b=nF5+yP0bT6XVwHVuZyx3S4qwDUy75JtBoHSQBs3mar1rQRSJU5QwhPVRWrXCS+X+ar
         nsa5agyuYRHq8voLXKWZMBZHigFMPzTJFbI4DGmFt6E8z4ip2W2fm6VXrww5EtFNYoFd
         fVTRsxKmAgJVmmOBzf/xnjZ1xZff+eJ/4fUTBzLqM675zBN8wQlNCtCYxSiS58lIj+N/
         6vS4u7o6TnZ7MYEVIwTtSonT3RnusQwVT/47DYNAKamYitOsPeCOVa7HdMfqDiML2QYL
         Cda9fGSdA4hd1kQwRQxegDhFEs7wPhHnR5axX1nX8/dxAJQP/CoZvh/NpUsOUT2t2CVL
         BF2A==
X-Gm-Message-State: APf1xPCdbNmj54VnvrOrxWJRiD8GMt4WwC5aUzxoIkOrfAFv4UNOYP4B
        eIibG179XllFIH+P6IDfRREuy1ICtW59ePZbV+RgiA==
X-Google-Smtp-Source: AG47ELvfnUnqv3LgrNto2pQD7XX0iWnJh7HrWMHvYiRIglXXmS+ByNeqgO0E8Es/06ZUJBiKU5cYf41yT58dfD6ZvGw=
X-Received: by 10.202.244.11 with SMTP id s11mr1363165oih.204.1519404143405;
 Fri, 23 Feb 2018 08:42:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.98.4 with HTTP; Fri, 23 Feb 2018 08:42:22 -0800 (PST)
In-Reply-To: <20180223102242.5850-1-birgersp@gmail.com>
References: <CAGr--=LZ9TSM9v0SZOi_mj1t8se0Ck-nDHkwum3kC8uz9HKW6A@mail.gmail.com>
 <20180223102242.5850-1-birgersp@gmail.com>
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Fri, 23 Feb 2018 17:42:22 +0100
X-Google-Sender-Auth: 3-T7zlFKJwX6ed92qymVN03T17U
Message-ID: <CAGr--=Kn5pRindZ-fu0YQ+s4uKgNz+d1rB1O4O6W+fhd_o2zTg@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to change focus between ui widgets
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've discovered a bug, I'll be sending a new version soon.

br
Birger

On Fri, Feb 23, 2018 at 11:22 AM, Birger Skogeng Pedersen
<birgersp@gmail.com> wrote:
> The user cannot change focus between the list of files, the diff view
> and the commit message widgets without using the mouse (clicking either of
> the four widgets ).
>
> Hotkeys CTRL/CMD+number (1-4) now focuses the first file of either the
> "Unstaged Changes" or "Staged Changes", the diff view or the
> commit message dialog widgets, respectively. This enables the user to
> select/unselect files, view the diff and create a commit in git-gui
> using keyboard-only.
>
> Signed-off-by: Birger Skogeng Pedersen <birgersp@gmail.com>
> ---
>  git-gui/git-gui.sh | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 91c00e648..bdbe166f7 100755
>
> (First timere here, any feedback is highly appreciated)
>
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2664,6 +2664,35 @@ proc show_less_context {} {
>         }
>  }
>
> +proc select_first_path {w} {
> +       global file_lists last_clicked selected_paths
> +       if {[llength $file_lists($w)] > 0} {
> +               focus $w
> +               set last_clicked [list $w 1]
> +               show_diff [lindex $file_lists($w) 0] $w
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
> @@ -3876,6 +3905,11 @@ foreach i [list $ui_index $ui_workdir] {
>  }
>  unset i
>
> +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
> +bind . <$M1B-Key-2> {select_first_staged_changes_path}
> +bind . <$M1B-Key-3> {focus_diff}
> +bind . <$M1B-Key-4> {focus_commit_message}
> +
>  set file_lists($ui_index) [list]
>  set file_lists($ui_workdir) [list]
>
> --
> 2.16.2.266.g75bb9601e
>
