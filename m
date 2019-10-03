Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585ED1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfJCOsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 10:48:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:47056 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJCOsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 10:48:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so3894727qtq.13
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIRk7FnbfVlKDQwWtp0qv43GElm6EBIzUCGc1x5bFtc=;
        b=Qxvi3WmFoofvYxmviJI+GJ/ezZEx9tLK+x+xIBzp31peX3dYxquMgiG98xvSJ0jHCO
         nSvvnWl12cSHEw3tYjH4d1YuqF3UVrfcrWoBcQ6RWtbo1Ho5INkd1SNhPjsW2ASoyIfZ
         /oAOF/6CJ0s8Y8xgBC/bmrj1xNNDrGqzk48VDJ00ugYpG3rxuZtD9i2GEkopzPHyPiYE
         jfvaH8LiJr0QzvZzdh83m28WKRZ/syscp89s7ANYj32VWbcUnOQ7usHW0WPRQt5eT0Xj
         NCeE9a0o0ovHN0qSvg8BO3QJb9yFgvtgipQrGAbaoedc50A9pTbtudvJ/UNwKVNE/GZQ
         CbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIRk7FnbfVlKDQwWtp0qv43GElm6EBIzUCGc1x5bFtc=;
        b=gPOnzxKh8FBnwQLYsLw6SiUvcD2RsczLFk0OgLpn4sJqcIwCNh16SaJdUYur9iUysO
         puEMjYGL284KfQtcU4l5rOO1EsA6asd1WIZ2omU8Dirzu9ThA52wNPG5etDdcd5PnAe+
         AR8K/Bk08PEyo745oD/E73xAQXoQOYtCPbJvdRvlAKOx/sn8vvJjVfRZ1BRWa4Q26dta
         dkrxRoTJNWgH86rmx26Q98DZCFDX0syRPz4sGpf3FSEtZEnkkRcW6Clf6mqTLxb4vtUd
         V0dp52ttlN6lFLCwiDmrSCwR4IwgVkXqeWTlP8mnkdY8mCHSOAe2dEm+UwiiRvlkqaCS
         yQCQ==
X-Gm-Message-State: APjAAAWnp3Sp/TwOn0wq1gxykm8DOU+1oHBLSwOHxcaqSHDFPndJPV1n
        4PprFpQQzDTEq9ABCyTF3S0AWIPBzqOXjPXHGO38IndCM9w=
X-Google-Smtp-Source: APXvYqz92UzAZ+VRcJtudYPzd64vEs4MvS/wlmg62LbdEEFT4yhPuyRRQjB1Z3/TTnz8w2f4S98XyPVx7Pow4F08dh8=
X-Received: by 2002:a0c:8144:: with SMTP id 62mr8821013qvc.6.1570114099032;
 Thu, 03 Oct 2019 07:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com> <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
In-Reply-To: <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
From:   harish k <harish2704@gmail.com>
Date:   Thu, 3 Oct 2019 20:18:06 +0530
Message-ID: <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,
I', Just reopening this feature request.
A quick summary of my proposal is given below.

1. This PR will allow an additional configuration option
"guitool.<name>.gitgui-shortcut" which will allow us to specify
keyboard shortcut  for custom commands in git-gui

2. Even there exists a parameter called "guitool.<name>.shortcut"
which is used by git-cola, I suggest to keep this new additional
config parameter as an independent config parameter, which will not
interfere with git-cola in any way, because, both are different
applications and it may have different "built-in" shortcuts already
assigned. So, sharing shortcut scheme between two apps is not a good
idea.

3. New parameter will expect shortcut combinations specified in TCL/TK
's format and we will not be doing any processing on it. Will keep it
simple.

---
 Documentation/config/guitool.txt | 15 +++++++++++++++
 git-gui/lib/tools.tcl            | 15 ++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/guitool.txt b/Documentation/config/guitool.txt
index 43fb9466ff..79dac23ca3 100644
--- a/Documentation/config/guitool.txt
+++ b/Documentation/config/guitool.txt
@@ -48,3 +48,18 @@ guitool.<name>.prompt::
  Specifies the general prompt string to display at the top of
  the dialog, before subsections for 'argPrompt' and 'revPrompt'.
  The default value includes the actual command.
+
+guitool.<name>.gitgui-shortcut
+ Specifies a keyboard shortcut for the custom tool in the git-gui
+ application. The value must be a valid string ( without "<" , ">" wrapper )
+ understood by the TCL/TK 's bind command.See
https://www.tcl.tk/man/tcl8.4/TkCmd/bind.htm
+ for more details about the supported values. Avoid creating shortcuts that
+ conflict with existing built-in `git gui` shortcuts.
+ Example:
+ [guitool "Terminal"]
+ cmd = gnome-terminal -e zsh
+ noconsole = yes
+ gitgui-shortcut = "Control-y"
+ [guitool "Sync"]
+ cmd = "git pull; git push"
+ gitgui-shortcut = "Alt-s"
diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
index 413f1a1700..40db3f6395 100644
--- a/git-gui/lib/tools.tcl
+++ b/git-gui/lib/tools.tcl
@@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
 }

 proc tools_populate_one {fullname} {
- global tools_menubar tools_menutbl tools_id
+ global tools_menubar tools_menutbl tools_id repo_config

  if {![info exists tools_id]} {
  set tools_id 0
@@ -61,9 +61,18 @@ proc tools_populate_one {fullname} {
  }
  }

- tools_create_item $parent command \
+ if {[info exists repo_config(guitool.$fullname.gitgui-shortcut)]} {
+ set gitgui_shortcut $repo_config(guitool.$fullname.gitgui-shortcut)
+ tools_create_item $parent command \
  -label [lindex $names end] \
- -command [list tools_exec $fullname]
+ -command [list tools_exec $fullname] \
+ -accelerator $gitgui_shortcut
+ bind . <$gitgui_shortcut> [list tools_exec $fullname]
+ } else {
+ tools_create_item $parent command \
+ -label [lindex $names end] \
+ -command [list tools_exec $fullname]
+ }
 }

 proc tools_exec {fullname} {
--
https://github.com/git/git/pull/220
--


On Fri, Apr 1, 2016 at 12:02 PM harish k <harish2704@gmail.com> wrote:
>
> Hi David,
>
> Actually Im a TCL primer.  This is the first time Im dealing with.
> That is why I kept it simple ( ie both accel-key and accel-label need
> to be defined in config ).
>
> I think, git-cola is using Qt style representation accel-key in the config file.
>
> Is git-cola is an official tool from git ? like git-gui?
> if not ,
> My suggesion is, it is better to seperate config fields according to
> application-domain
> like, "git-gui-accel = <Ctrl-l>" etc..
> Other vise there is good chance for conflicts. ( Eg: consider the case
>  that, <Ctrl-p> was assined to a custom tool by git-cola )
>
> Currently this patch will not handle any conflicting shortcuts. I
> think custom shortcuts will overwrite the other.
>
>
> On Thu, Mar 31, 2016 at 10:11 PM, David Aguilar <davvid@gmail.com> wrote:
> > Hello,
> >
> > On Tue, Mar 29, 2016 at 11:38:10AM +0000, Harish K wrote:
> >> ---
> >>  git-gui/lib/tools.tcl | 16 +++++++++++++---
> >>  1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/git-gui/lib/tools.tcl b/git-gui/lib/tools.tcl
> >> index 6ec9411..749bc67 100644
> >> --- a/git-gui/lib/tools.tcl
> >> +++ b/git-gui/lib/tools.tcl
> >> @@ -38,7 +38,7 @@ proc tools_create_item {parent args} {
> >>  }
> >>
> >>  proc tools_populate_one {fullname} {
> >> -     global tools_menubar tools_menutbl tools_id
> >> +     global tools_menubar tools_menutbl tools_id repo_config
> >>
> >>       if {![info exists tools_id]} {
> >>               set tools_id 0
> >> @@ -61,9 +61,19 @@ proc tools_populate_one {fullname} {
> >>               }
> >>       }
> >>
> >> -     tools_create_item $parent command \
> >> +     if {[info exists repo_config(guitool.$fullname.accelerator)] && [info exists repo_config(guitool.$fullname.accelerator-label)]} {
> >> +             set accele_key $repo_config(guitool.$fullname.accelerator)
> >> +             set accel_label $repo_config(guitool.$fullname.accelerator-label)
> >> +             tools_create_item $parent command \
> >>               -label [lindex $names end] \
> >> -             -command [list tools_exec $fullname]
> >> +             -command [list tools_exec $fullname] \
> >> +             -accelerator $accel_label
> >> +             bind . $accele_key [list tools_exec $fullname]
> >> +     } else {
> >> +             tools_create_item $parent command \
> >> +                     -label [lindex $names end] \
> >> +                     -command [list tools_exec $fullname]
> >> +     }
> >>  }
> >>
> >>  proc tools_exec {fullname} {
> >>
> >> --
> >> https://github.com/git/git/pull/220
> >
> > We also support "custom guitools" in git-cola using this same
> > mechanism.  If this gets accepted then we'll want to make
> > similar change there.
> >
> > There's always a small risk that user-defined tools can conflict
> > with builtin shortcuts, but otherwise this seems like a pretty
> > nice feature.  Curious, what is the behavior in the event of a
> > conflict?  Do the builtins win?  IIRC, Qt handles this by
> > disabling the shortcut and warning that it's ambiguous.
> >
> > Please documentation guitool.<name>.accellerator[-label] in
> > Documentation/config.txt otherwise users will not know that it
> > exists.
> >
> > It would also be good for the docs to clarify what the
> > accelerators look like in case we need to munge them when making
> > it work in cola via Qt, which has its own mechanism for
> > associating actions with shortcuts.  Documented examples with
> > one and two modifier keys would be helpful.
> >
> >
> > cheers,
> > --
> > David
>
>
>
> --
>
> -Regards
> Harish.K



-- 

-Thanks
Harish.K
