Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEF71F453
	for <e@80x24.org>; Tue, 30 Apr 2019 22:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3WX0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:23:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33474 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3WXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:23:25 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so13677213iop.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EXtnnz418/MQV+utIJd7dYPyLz90o6RAxXfq+haJ8yI=;
        b=jaDQHZ2X5Xw4uzD1AWMpXPjm9R/SRJBTMU2uThrWP3uiYt5GZjY2O8ERXsujOO2sKZ
         JMEkDxwDP2oRFTBQmVQnLYPmZ1/W42kgsMXe5yi0KYDoxtpRDNc/2QVwJ3/5PPIIzy7O
         C5uqMr/OErtxy2WsUXawpws0+p4a71ilz4znCPSRIZjAEivPv6ZyLN2PWK2Bk/kqyD7/
         8+phZ7Lu4W8bt2rQIHZrMNYxq3O0HP7qntK9xSSlQXZILuzfZFSzFDCthKe/2b9vWqQl
         23f25fGWRTr3jY9trKWy9C0wyIWmudTxJ/MakVLcqyWYe1aWsvB0v9OA3ZLQzhTXtu4i
         oNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EXtnnz418/MQV+utIJd7dYPyLz90o6RAxXfq+haJ8yI=;
        b=icGQfPksc4vEC2VPq5GMTb8iX00TecKbjJHA3p5j6UzHuVCmbmZUftbYx21pq2AwYO
         txN6XK18jBpu6Tbxd9DgDnbZG1NzdB3ZT9EOu48NMPmzKDjvcJp91ak/0pPvzc9sW6VZ
         KQx9GkXjjtVCPXmD/9DBzZXgDycWwD2tGVnG5rxztsEhqe43xG+7H/O89KuNXRPy3Lib
         2rok/7eQIoxzNUQ9g2QWJZ/77/9L4I8Sgl8op+Tl6JR4BQKk4p0AxRi0TjPqpWFzaOu0
         Why4hTRaEkKUIWn7ywGZdzKNG3j3IKbk7lnex+WspV2ty9Vj+rwumeU8QRt8I38Tr5mc
         /pQg==
X-Gm-Message-State: APjAAAUzNQpNsuVNUoz/8wDfaWTtFdOl24j3E1tk9DUVXna4xx7gb59G
        5laQEMd5jr3c109qwv8f0klHgO3xQ1B3O5PHZiSN30f9m6w=
X-Google-Smtp-Source: APXvYqyuIUadpmgD9+b5OQOklPW+YUXYShy9sI2tu2IXPHIsXRjO64wa3PIMRWAdNVP4S1VnY/tgweDPWUFrN6TdIoM=
X-Received: by 2002:a5d:8795:: with SMTP id f21mr26598528ion.20.1556663004644;
 Tue, 30 Apr 2019 15:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190430060210.79610-1-johnlinp@gmail.com> <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
In-Reply-To: <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Wed, 1 May 2019 06:23:13 +0800
Message-ID: <CAKO26Mtgz_WXnVr80NQGp=-fn4U5W_BD7m-H7iM9ATW5qrp=dw@mail.gmail.com>
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
To:     phillip.wood@dunelm.org.uk
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood <phillip.wood123@gmail.com> =E6=96=BC 2019=E5=B9=B44=E6=9C=883=
0=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:15=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi John
>
> On 30/04/2019 07:02, John Lin wrote:
> > When typing "git status", there is an empty line between
> > the "Changes not staged for commit:" block and the list
> > of changed files.
>
> I'm a bit confused by this as you change a status test below by
> inserting these blank lines into the expected output, implying they are
> not there now. I think maybe the blank line is only shown when status
> prints advice.
>
> > However, when typing "git commit" with
> > no files added, there are no empty lines between them.
>
> I have to say looking at the changes to the output I prefer the
> original, the lists are nicely indented so there is no need for a blank
> line to separate the header from the list and having the header
> immediately before the list means the blank line at the end of the block
> makes the extent of the block clear. It also saves screen space which is
> useful for small laptop screens. I can see why one might want a blank
> line to separate the advice and list of changes (though even there the
> indention of the list and advice is different) but for a one line header
> I think it is better to start the list on the next line.

Thanks for the review. Your opinion does make sense to me. Please
consider this patch dropped. Thank you.

Best,
John Lin

>
> Best Wishes
>
> Phillip
>
> > This patch adds empty lines in the above case and some
> > similar cases.
> >
> > Signed-off-by: John Lin <johnlinp@gmail.com>
> > ---
> >   t/t7500-commit-template-squash-signoff.sh |  1 +
> >   t/t7508-status.sh                         |  5 +++++
> >   t/t7512-status-help.sh                    |  1 +
> >   wt-status.c                               | 12 ++++++++----
> >   4 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit=
-template-squash-signoff.sh
> > index 46a5cd4b73..0423e77d1d 100755
> > --- a/t/t7500-commit-template-squash-signoff.sh
> > +++ b/t/t7500-commit-template-squash-signoff.sh
> > @@ -345,6 +345,7 @@ cat >expected-template <<EOF
> >   #
> >   # On branch commit-template-check
> >   # Changes to be committed:
> > +#
> >   #   new file:   commit-template-check
> >   #
> >   # Untracked files not listed
> > diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> > index e1f11293e2..949b1dbcc4 100755
> > --- a/t/t7508-status.sh
> > +++ b/t/t7508-status.sh
> > @@ -204,12 +204,15 @@ Your branch and 'upstream' have diverged,
> >   and have 1 and 2 different commits each, respectively.
> >
> >   Changes to be committed:
> > +
> >       new file:   dir2/added
> >
> >   Changes not staged for commit:
> > +
> >       modified:   dir1/modified
> >
> >   Untracked files:
> > +
> >       dir1/untracked
> >       dir2/modified
> >       dir2/untracked
> > @@ -449,9 +452,11 @@ Your branch and '\''upstream'\'' have diverged,
> >   and have 1 and 2 different commits each, respectively.
> >
> >   Changes to be committed:
> > +
> >       new file:   dir2/added
> >
> >   Changes not staged for commit:
> > +
> >       modified:   dir1/modified
> >
> >   Untracked files not listed
> > diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> > index 458608cc1e..0a29fa66a2 100755
> > --- a/t/t7512-status-help.sh
> > +++ b/t/t7512-status-help.sh
> > @@ -714,6 +714,7 @@ rebase in progress; onto $ONTO
> >   You are currently rebasing branch '\''statushints_disabled'\'' on '\'=
'$ONTO'\''.
> >
> >   Unmerged paths:
> > +
> >       both modified:   main.txt
> >
> >   no changes added to commit
> > diff --git a/wt-status.c b/wt-status.c
> > index 445a36204a..0766e3ee12 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -175,7 +175,7 @@ static void wt_longstatus_print_unmerged_header(str=
uct wt_status *s)
> >       }
> >
> >       if (!s->hints)
> > -             return;
> > +             goto conclude;
> >       if (s->whence !=3D FROM_COMMIT)
> >               ;
> >       else if (!s->is_initial)
> > @@ -193,6 +193,7 @@ static void wt_longstatus_print_unmerged_header(str=
uct wt_status *s)
> >       } else {
> >               status_printf_ln(s, c, _("  (use \"git add/rm <file>...\"=
 as appropriate to mark resolution)"));
> >       }
> > +conclude:
> >       status_printf_ln(s, c, "%s", "");
> >   }
> >
> > @@ -202,13 +203,14 @@ static void wt_longstatus_print_cached_header(str=
uct wt_status *s)
> >
> >       status_printf_ln(s, c, _("Changes to be committed:"));
> >       if (!s->hints)
> > -             return;
> > +             goto conclude;
> >       if (s->whence !=3D FROM_COMMIT)
> >               ; /* NEEDSWORK: use "git reset --unresolve"??? */
> >       else if (!s->is_initial)
> >               status_printf_ln(s, c, _("  (use \"git reset %s <file>...=
\" to unstage)"), s->reference);
> >       else
> >               status_printf_ln(s, c, _("  (use \"git rm --cached <file>=
...\" to unstage)"));
> > +conclude:
> >       status_printf_ln(s, c, "%s", "");
> >   }
> >
> > @@ -220,7 +222,7 @@ static void wt_longstatus_print_dirty_header(struct=
 wt_status *s,
> >
> >       status_printf_ln(s, c, _("Changes not staged for commit:"));
> >       if (!s->hints)
> > -             return;
> > +             goto conclude;
> >       if (!has_deleted)
> >               status_printf_ln(s, c, _("  (use \"git add <file>...\" to=
 update what will be committed)"));
> >       else
> > @@ -228,6 +230,7 @@ static void wt_longstatus_print_dirty_header(struct=
 wt_status *s,
> >       status_printf_ln(s, c, _("  (use \"git checkout -- <file>...\" to=
 discard changes in working directory)"));
> >       if (has_dirty_submodules)
> >               status_printf_ln(s, c, _("  (commit or discard the untrac=
ked or modified content in submodules)"));
> > +conclude:
> >       status_printf_ln(s, c, "%s", "");
> >   }
> >
> > @@ -238,8 +241,9 @@ static void wt_longstatus_print_other_header(struct=
 wt_status *s,
> >       const char *c =3D color(WT_STATUS_HEADER, s);
> >       status_printf_ln(s, c, "%s:", what);
> >       if (!s->hints)
> > -             return;
> > +             goto conclude;
> >       status_printf_ln(s, c, _("  (use \"git %s <file>...\" to include =
in what will be committed)"), how);
> > +conclude:
> >       status_printf_ln(s, c, "%s", "");
> >   }
> >
> >
