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
	by dcvr.yhbt.net (Postfix) with ESMTP id CCFA51F461
	for <e@80x24.org>; Sun,  1 Sep 2019 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfIATCF (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 15:02:05 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34290 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfIATCF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 15:02:05 -0400
Received: by mail-vs1-f67.google.com with SMTP id r17so5058469vso.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2019 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dilANJZnw4vJ+s5+0zT0u6BIRhHC1ljiBd43in8eHWU=;
        b=WgcDVtstI/6gCDbYFBhJr+L+104LqU46JUkztuasnrQpr42QJ7uG+r3Fd/AEX1OtqO
         iuhsyR+2jOj5cscxbVXCEIJMLAHxz7Oj8kxl1DW4FNa7COE9dAeMyf7ORTFGhchG/DQF
         9r/hw4tgXlFomiREK8Xfamgu3KTfkbU2kaZmchkChGMGFHY8mC7j5ZBMbe0UKfHBQFoN
         22KJBGnzUd06W6ZBQIjftTToFDZejeCJdEp6gBfFiGKR2DS4X6wSpv5eKr7s99YD8E9H
         GBJIhDxvsJaF3ilO9C6rRCXIUs4UrES6tWKj57jgoxcDL7Xr5u+1In6GC9d+g6F6uwTG
         2poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dilANJZnw4vJ+s5+0zT0u6BIRhHC1ljiBd43in8eHWU=;
        b=sqOuoiHoSIRx1p7r3ytCqn+Bnqc5z8nGckJEsTc9HRlGIz8ZvyGaN8Ir6ntmA40Uzn
         49uMVX4Jd/dPIWqyAIUjnXw8pKYsBDcit7am6kp84SJ44MjynnS88hXxpY/8koyFDjay
         nyF7sTm6+8KDDpml1FSL8C74iYzDqQdkcVcWqy5DnUDr/ddm05VbtZK5CjcD6KWi7DB7
         c2lDi3sxgYSwqVVT9YEC1FGuhm+TFP5h8drVPDGEeHt9hms4S+kjgsxC9HowBniGdMuq
         1u2QO8dVi2ldguFO+8Wnj9AnkkXYqaiVwDcil9ioH3OtrZz6zx3lNOMA+fwlOm3zrMso
         8gjQ==
X-Gm-Message-State: APjAAAUQwoYNw+Vq19NcfJJK/kzD02Won0pxVdF4A2ALnCGf738WgAhz
        vcdilQBCysoDS2PgOeNhxin1cB/1w5RiIdOeUUA=
X-Google-Smtp-Source: APXvYqypo03QXg2eRn9GEKpuszP3UJkUPfirnrPYozW5EUQ0xdkl0PlFk3mdsefGoMl3dQa7AK4J3cDxgszMd0C7gbU=
X-Received: by 2002:a67:2241:: with SMTP id i62mr6587242vsi.85.1567364524878;
 Sun, 01 Sep 2019 12:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com> <20190831122326.9071-1-birger.sp@gmail.com>
 <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
In-Reply-To: <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sun, 1 Sep 2019 21:01:53 +0200
Message-ID: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 1, 2019 at 1:32 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > +
> > +proc select_first_unstaged_changes_path {} {
> > +     global ui_workdir
> > +     select_first_path $ui_workdir
> > +}
> > +
> > +proc select_first_staged_changes_path {} {
> > +     global ui_index
> > +     select_first_path $ui_index
> > +}
> > +
> > +proc focus_diff {} {
> > +     global ui_diff
> > +     focus $ui_diff
> > +}
> > +
> > +proc focus_commit_message {} {
> > +     global ui_comm
> > +     focus $ui_comm
> > +}
> > +
>
> Do you expect these functions to be re-used somewhere in the near
> future? Otherwise...
>
> >  ######################################################################
> >  ##
> >  ## ui construction
> > @@ -3877,6 +3924,14 @@ foreach i [list $ui_index $ui_workdir] {
> >  }
> >  unset i
> >
> > +bind . <$M1B-Key-1> {select_first_unstaged_changes_path}
> > +bind . <$M1B-Key-2> {select_first_staged_changes_path}
> > +bind . <$M1B-Key-3> {focus_diff}
> > +bind . <$M1B-Key-4> {focus_commit_message}
>
> ... why not just put their bodies directly in here? Something like:
>
>   bind . <$M1B-Key-1> {
>         global $ui_workdir
>         select_first_path $ui_workdir
>   }

that should also work:

bind . <$M1B-Key-1> {select_first_path $::ui_workdir}
