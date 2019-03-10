Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FA6920248
	for <e@80x24.org>; Sun, 10 Mar 2019 18:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCJS1n (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 14:27:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfCJS1m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 14:27:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so2242833wmj.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 11:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ykhjqbgavH/qcjR3xy4hCRqSpsnf6wBrUMARPqSO7mk=;
        b=sQ1C+GPFRHtf1ZtgDSb/7Ffr4Ky9cP9GgsX9B1emYJNSWL5Ezr0gFygk1lJZdd+aS4
         1+W+y+f0reIjbqRA0L8ELe6puI9A0Osonh4OQsGfL3JwoGmzWY4NrcE9Mcn80Fcj0bO+
         kivL11QlCYR1Jk0jNW5lp9Wp4qJxf3KgdRb9181a8d+LZ7CWr3KNR2n3l5ocjSfkM0Bk
         +3Mi/xpy/wTKkjVs1T4StN460xaTsiowfv6Vnn7ZEEP0x06vYPm6F2cYA7QJCq9iTeSU
         rVxDQq37c9SDNsVobxRQ6Xnb6RLhETFsQOdQaGfJjqWkaG4b8z8u16aGmBL2VoxWJ0pW
         VGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ykhjqbgavH/qcjR3xy4hCRqSpsnf6wBrUMARPqSO7mk=;
        b=bf61RGOrg8NwZvO0DilkpckKVL5xGu0EVN4tpD3TwCptuupbI/UihMvSVfsy05HxC3
         o+boo7TaeIYfK19RKLDfcN5vhkN8pVniwfY9kzK7DWSZ0Pde+dqwhxxXuQizvTYVwUis
         LS07jC6NIY6fN7qFr7Anr0oAq9mX/f1THqvhyTGRKiomR5wmtt99sU1xFisuj3TL1ZIh
         Es9YUO2y60aMTaGZXDrb0nmh7e6xgUuivq4DOeG8tiMtwpC2ZpmQYcpS6h6+08PsPPZA
         ouk+buN1QomewSMlP+lXq1uETi9a+EIpMOcOvH9a3gk3dFveJAhwa22+oWOC/yAMZ0sX
         JvbA==
X-Gm-Message-State: APjAAAWbZDk+9S5i5mga/GpmNZ/b8VzjRtrycEyIL5IwKsmGVs9A740J
        7TKv7Y22v2E4/lWQcl5ojxg=
X-Google-Smtp-Source: APXvYqzYh+GqXE6ezy8rEhcyak4ZI8VVKMkXqNRHyj0xHqMU8U5OwnTtvDV1SRwzVWpBmLJ9I9/qlQ==
X-Received: by 2002:a1c:e1c4:: with SMTP id y187mr15471351wmg.50.1552242460268;
        Sun, 10 Mar 2019 11:27:40 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id e16sm3555456wrw.84.2019.03.10.11.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 11:27:39 -0700 (PDT)
Date:   Sun, 10 Mar 2019 18:27:38 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
Message-ID: <20190310182738.GH31533@hank.intra.tgummerer.com>
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
 <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com>
 <CABPp-BHtpb_EyNTNGcP+EbRbrrMJg1C=W4JenjE1AbnE1WrbNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHtpb_EyNTNGcP+EbRbrrMJg1C=W4JenjE1AbnE1WrbNA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Elijah Newren wrote:
> Hi,
> 
> On Sat, Mar 9, 2019 at 9:29 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 03/07, Duy Nguyen wrote:
> > > On Thu, Mar 7, 2019 at 7:34 PM Philip Oakley <philipoakley@iee.org> wrote:
> > > > The one point I noted is that "Overlay" is a new magic term without any
> > > > explanation within the _documentation_.
> > > >
> > > > It would appear worth it to also add something (follow up patch?) to the
> > > > e.g. git glossary to clarify how overlay differs, or is similar to, the
> > > > different merge and reset modes.
> > >
> > > I think Jonathan questions the name "overlay" too. Since this is
> > > similar to "cp -R" mode, another suggestion is --copy-mode.
> >
> > That would leave the negative form as --no-copy-mode, which almost
> > sounds like we wouldn't copy anything.  I think that would be more
> > confusing that [no ]overlay mode.
> >
> > I'd be fine in general with changing the name, if there is a consensus
> > for a different and better name, but I also think overlay is
> > reasonable, so I'd rather leave pushing for a different name to
> > someone else that has strong opinions about it.
> >
> > Philip, do you think something like this would help?  Not sure if it
> > should be called overlay_mode in the glossary, rather than just
> > overlay?
> >
> > --- >8 ---
> > Subject: [PATCH] glossary: add definition for overlay
> >
> > Add a definition for what overlay means in the context of git, to
> > clarify the recently introduced overlay-mode in git checkout.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  Documentation/glossary-content.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> > index 023ca95e7c..70e6477a9f 100644
> > --- a/Documentation/glossary-content.txt
> > +++ b/Documentation/glossary-content.txt
> > @@ -287,6 +287,11 @@ This commit is referred to as a "merge commit", or sometimes just a
> >         origin/name-of-upstream-branch, which you can see using
> >         `git branch -r`.
> >
> > +[[def_overlay]]overlay::
> > +       Only update and add files to the working directory, but don't
> > +       delete them, similar to how 'cp -R' works.  This is the
> > +       default in a <<def_checkout,checkout>>.
> 
> I think this is good, but maybe also add:
>    In contrast, no-overlay mode will also delete files not present in
> the source, similar to 'rsync --delete'
> ?

Yeah, I think that makes sense, thanks!  I'll wait a bit more to see
if there are any other comments, and then send an updated version.

> > +
> >  [[def_pack]]pack::
> >         A set of objects which have been compressed into one file (to save space
> >         or to transmit them efficiently).
> > --
> > 2.20.1.495.gaa96b0ce6b
