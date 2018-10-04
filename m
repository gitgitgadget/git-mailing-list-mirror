Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A741F453
	for <e@80x24.org>; Thu,  4 Oct 2018 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeJDXEI (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 19:04:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46813 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJDXEH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 19:04:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so8863494ljj.13
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ljBAfoyyuJQLDaIZrwBWe/O5Lx2wHmIlDMPhmBuP6U=;
        b=EdMBJIYDdCgJZvLxwKE3DZ9DMRz+rYXN/KkONRPs2DUrIJ1+BmpFAhurcHyNHckpI6
         RUVCIFhMR4BwY4JNjYmZ/9SkqMktCG1tS2IUL+a4Cc3Fv7J2hkUGLM1qcZPfHMAVF6lQ
         0pvH5aJ2oZqUm9eQM8caaYsRXTCnTZTmJmBMGwpIw8+Nh5+jTwyLAt5B0FYQbeOp9jp+
         aY8p51XRLNhfH+JDCymP74i+U3HGmbDG9D6rmz9inj9JMq5BKIL8HC+2IOd5enqvitjZ
         VmMVUsYj3jVYURaD0wnpgnbtwvo/ApAslD+BOMulJ7EsirT1hRL7vFVfAt8/tHA1WpFW
         Febg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ljBAfoyyuJQLDaIZrwBWe/O5Lx2wHmIlDMPhmBuP6U=;
        b=NuT+Dn+UUOEuH51TQS8Dl4jkdO2s18DtDSEauoe0AVJA7MZh78qNBkpeyvK1ABPV0x
         ExqnMk0at0NM4bBJv/g5k0cuVCWbuu+j1uh+Z3drtT8ZJqV9Lusk+pfSQnVxmoco5ENX
         27CumuGFPwgip0YTcbUsm6puEfolQjW0wxylFxzkQQZeJBohTNSwlPJTc1RU35/DirT2
         6TkHnmqFwBuJSbSDNojHKdl6K8wJgiytbts/7ZXJJK3HG9ER1NDVem9/pjUMWLiYpDDD
         Qh7SB8xZuDTlQGN7mOggjgwwoVQv1UH4NUKQ8WwP3wzrvmD5CMdb0XOHlVKBuau0vCKb
         I9OQ==
X-Gm-Message-State: ABuFfoigrN7sfMJoH7ook0uStcvMfRXrMd+/iJ6931m++teZwIC5i7tv
        g40c1VRapCw1gacLom1SJPlwl0RBN4bwnYHByCg=
X-Google-Smtp-Source: ACcGV63J6InK0NSPos8PMvlqCZsJgKXISpP0y8yWkGu/gjtdEWetpqJOwlGQYtkQyuk+C+osKkkDqdbCZs/bJI2v4QY=
X-Received: by 2002:a2e:5645:: with SMTP id k66-v6mr4590507ljb.48.1538669409647;
 Thu, 04 Oct 2018 09:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181004113015.GA30901@manohar-ssh> <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
 <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com> <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810041718480.73@tvgsbejvaqbjf.bet>
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
Date:   Thu, 4 Oct 2018 16:09:57 +0530
Message-ID: <CA+=o6KHxwYdYsvFDzBaG1q2jvgtN5f4LruD5k=dqei8workWfQ@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Oct 2018 at 20:56, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Ananya,
>
> On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:
>
> > On Thu, 4 Oct 2018 at 19:56, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Ananya,
> > >
> > > thank you for taking the time to write this patch!
> > >
> > > On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:
> > >
> > > > the forward slash character should be escaped with backslash. Fix
> > > > Unescaped forward slash error in Python regex statements.
> > > >
> > > > Signed-off-by: Ananya Krishna Maram<ananyakittu1997@gmail.com>
> > >
> > > That explains pretty well what you did, but I wonder why the forward slash
> > > needs to be escaped? I would understand if we enclosed the pattern in
> > > `/<regex>/`, as it is done e.g. in Javascript, but we do not...
> >
> > You are correct, the code would execute either ways. But when I came across
> > this line, I didn't get it's meaning instantly because as per standards, forward
> > slash has to be escaped. In fact when open source code is written according to
> > standards, the code will be reachable to more people.
>
> I am afraid that I do not follow... Regular expressions have quite a few
> special characters, but forward slashes are not among them.
>
> Meaning: if we had specified the regular expression thusly (in any
> language that supports them to be specified in this way):
>
>         /|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?/
>
> then I would agree that this is a bug, and needs to be fixed. But we
> specify it as a regular C string:
>
>         "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"
>
> In this context, the backslash has an additional, nested meaning: it
> escapes special characters in a C string, too. So writing
>
>         "\\"
>
> will actually result in a string consisting of a single backslash. And
>
>         "\n"
>
> would specify a string consisting of a single line feed character. Some C
> compilers ignore incorrectly-escaped characters, i.e. "\/" would simply
> expand to the forward slash.
>
> However, you wanted to escape the forward slash in the regular expression.
> To do that, you would have to write
>
>         "\\/"
>
> i.e. specifying, in a C string, a backslash character, followed by a
> forward slash character.
>
> However, the regular expression would then be interpreting the backslash
> character as escape character in its own right, seeing the forward slash,
> and replacing this sequence by a forward slash.
>
> But it does not need to be escaped, when you specify the regular
> expression the way we do. And the way we specified it is really the
> standard when specifying regular expressions in C code, i.e. *without* the
> suggested backslash.

Aha!. this makes total sense. I was thinking from a general regular expression
point of view. But I should be thinking from C point of view and how C
might interpret this newly submitted string.
This explanation is very clear. Thanks for taking time to reply to my
patch. From next time on, I will try to think from
git project's point of view.

Thanks,
Ananya.

> Ciao,
> Johannes
>
> >
> > Thanks,
> > Ananya.
> >
> > > Thanks,
> > > Johannes
> > >
> > > > ---
> > > >  userdiff.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/userdiff.c b/userdiff.c
> > > > index f565f6731..f4ff9b9e5 100644
> > > > --- a/userdiff.c
> > > > +++ b/userdiff.c
> > > > @@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
> > > >        /* -- */
> > > >        "[a-zA-Z_][a-zA-Z0-9_]*"
> > > >        "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> > > > -      "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
> > > > +      "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
> > > >        /* -- */
> > > >  PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> > > >        /* -- */
> > > > --
> > > > 2.17.1
> > > >
> > > >
> >
