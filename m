Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14DFE1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 20:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbfIEUOS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 16:14:18 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:32824 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbfIEUOS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 16:14:18 -0400
Received: by mail-vs1-f67.google.com with SMTP id s18so2535887vsa.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNZg0gwDa/MrBhl/QKWahSQLpwl7O1aexOUhmD+p15k=;
        b=ElfSXyOF66hzjQRXyqkSIX4JYLYP31QdTfLZX7enG5ByQ6dfmPtst8tZ7fWs+4P+vb
         kjvc6Vbg1AvuG1FlT9byp1ZXT4oK52ZDIJS4a7jY9xO/2A2zoa+2HPf6yszOzrMchvJs
         qxemwSvsK9glsYfZdUTUUuKFmNaljTlCNwaD6Tq5r2fkU0i4AGHYSg1ixpAjpP2kkphy
         hT7K0tiRaLOw2Kvi8BSECjt/gwShs3ZTX95UUUDCoa2nusXEWhfI4Q8I4bLRKCVPND4U
         PDCMa3774hk0bSBpqT1t8fygKNKUJDCL9iTO1OjuBPKGIabgxpLxU1zDX+9dMtXu1Doy
         typw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNZg0gwDa/MrBhl/QKWahSQLpwl7O1aexOUhmD+p15k=;
        b=qcf6pdK6ROmf9+TX0jqleIlJm166xG8L+HX8DrxtRhcgaHLnBJ6fcSaWzyJz8UkvCZ
         W61NIfGINsAULqnaUwU4pknvb3du8PR3YffmA+TIMPpdQApChk0tGOxPy07BzNeRKzOA
         DwKphHGfyuhP5MyBk1NZP4peZq35+6U3fOl6bp3YioOtYyOt+2MKZsDCDMSNK9i6slfw
         L8+AshpA4xX7JLHE9wtXKDVvUPyaKAy3X1LysvCGyu4MclgRkCqtOafkh/BniFv2lWwo
         lndJFRCFGW7CTO0G4orzLS56ypRbLcmaBxDS08rZpSslwWMki7uQRaQaidMgVddxUL40
         zbRA==
X-Gm-Message-State: APjAAAV0gnssL4t/tIUXny/CvE4U7DCOc95z4M7AFQDvN4NnFMdReNoG
        NZ4ggKiehNpm/SOEl4/mJKha8TlQpiDhq/nRLW4=
X-Google-Smtp-Source: APXvYqykaO467HLd8rIc2dXQ0J8Ld49Gs0rPB+ABHOmJJPywvKzM+s4oinwK5Gd1DwLeEp5Fie9PfQ5wOfRIXoM2pnQ=
X-Received: by 2002:a67:fd11:: with SMTP id f17mr2802196vsr.31.1567714457299;
 Thu, 05 Sep 2019 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190904173642.2hkrqm5klatw33w7@yadavpratyush.com> <20190904175943.11924-1-birger.sp@gmail.com>
In-Reply-To: <20190904175943.11924-1-birger.sp@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 5 Sep 2019 22:14:06 +0200
Message-ID: <CAKPyHN2EFKnkgAoCCJ4zdO7hvMsATuSweraxkR_KJZUhuzizPA@mail.gmail.com>
Subject: Re: [PATCH v2] git-gui: add hotkey to toggle "Amend Last Commit"
 radio selector
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 8:00 PM Birger Skogeng Pedersen
<birger.sp@gmail.com> wrote:
>
> Selecting whether to do a "New Commit" or "Amend Last Commit" does not have
> a hotkey.
>
> With this patch, the user may toggle between the two options with
> CTRL/CMD+e.
>
> Signed-off-by: Birger Skogeng Pedersen <birger.sp@gmail.com>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  git-gui.sh | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 5bc21b8..47c5db0 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1445,7 +1445,7 @@ proc force_amend {} {
>         set commit_type $newType
>
>         set selected_commit_type amend
> -       do_select_commit_type
> +       ui_select_commit_type
>  }
>
>  proc rescan {after {honor_trustmtime 1}} {
> @@ -2640,6 +2640,16 @@ proc show_less_context {} {
>         }
>  }
>
> +proc toggle_commit_type {} {
> +       global selected_commit_type
> +       if {[string match amend* $selected_commit_type]} {

only $commit_type has multiple incarnations of amend, thus this should
have been $commit_type here.

Though I posted new patches which convert it first to b a checkbutton
and than addedyour keybinding patch on top of it.

Bert

> +               set selected_commit_type new
> +       } else {
> +               set selected_commit_type amend
> +       }
> +       ui_select_commit_type
> +}
> +
>  ######################################################################
>  ##
>  ## ui construction
> @@ -2824,13 +2834,31 @@ proc commit_btn_caption {} {
>         }
>  }
>
> +proc ui_select_commit_type {} {
> +       global selected_commit_type
> +       global ui_commit_type_commit ui_commit_type_amend
> +
> +       do_select_commit_type
> +       if {$selected_commit_type eq {new}} {
> +               .mbar.commit entryconf [mc "New Commit"] \
> +                       -accelerator {}
> +               .mbar.commit entryconf [mc "Amend Last Commit"] \
> +                       -accelerator $::M1T-E
> +       } elseif {$selected_commit_type eq {amend}} {
> +               .mbar.commit entryconf [mc "New Commit"] \
> +                       -accelerator $::M1T-E
> +               .mbar.commit entryconf [mc "Amend Last Commit"] \
> +                       -accelerator {}
> +       }
> +}
> +
>  if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>         menu .mbar.commit
>
>         if {![is_enabled nocommit]} {
>                 .mbar.commit add radiobutton \
>                         -label [mc "New Commit"] \
> -                       -command do_select_commit_type \
> +                       -command ui_select_commit_type \
>                         -variable selected_commit_type \
>                         -value new
>                 lappend disable_on_lock \
> @@ -2838,7 +2866,8 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
>
>                 .mbar.commit add radiobutton \
>                         -label [mc "Amend Last Commit"] \
> -                       -command do_select_commit_type \
> +                       -accelerator $M1T-E \
> +                       -command ui_select_commit_type \
>                         -variable selected_commit_type \
>                         -value amend
>                 lappend disable_on_lock \
> @@ -3315,14 +3344,14 @@ set ui_coml .vpane.lower.commarea.buffer.header.l
>  if {![is_enabled nocommit]} {
>         ${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
>                 -text [mc "New Commit"] \
> -               -command do_select_commit_type \
> +               -command ui_select_commit_type \
>                 -variable selected_commit_type \
>                 -value new
>         lappend disable_on_lock \
>                 [list .vpane.lower.commarea.buffer.header.new conf -state]
>         ${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
>                 -text [mc "Amend Last Commit"] \
> -               -command do_select_commit_type \
> +               -command ui_select_commit_type \
>                 -variable selected_commit_type \
>                 -value amend
>         lappend disable_on_lock \
> @@ -3843,6 +3872,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
>  bind .   <$M1B-Key-plus> {show_more_context;break}
>  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>  bind .   <$M1B-Key-Return> do_commit
> +bind .   <$M1B-Key-e> toggle_commit_type
>  foreach i [list $ui_index $ui_workdir] {
>         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
>         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
> --
> 2.21.0.windows.1
>
