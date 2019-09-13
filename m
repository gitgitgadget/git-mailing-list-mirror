Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D561F463
	for <e@80x24.org>; Fri, 13 Sep 2019 14:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbfIMOGb (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 10:06:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33787 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388084AbfIMOGb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 10:06:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id d10so22239258lfi.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cytRWrFkEymoxrvU4Opr8X4kylMVyQGu4MiMlhfFHlk=;
        b=SFHPK/bmnT8DqxvsFIv4MJ6kPT1N5/9L8W7pQbuTM1WgQTOvipLokrjkvnZfidl9yx
         7Uy8t7Eeu0vXdQh4cgbEQz/1HZZ2JWgnxL7sNnDYBAkKczYUkxs8pXTLczo/+pLCMf9T
         xeuRdO8z5Ot7J/LKV3hRAv9F4dG49V3B3BS3xbJdJYGUL4Ab8QYp7ffc5yE6qaH/dqe7
         +qcl6XFJP7CpLC5qdthcVnT6zR0J25BzX/JkcsDJRapauYm4ygoIlCb95MqFT3zD1NaO
         zy/gWY7ei2+fd2qgHU5pNAXq+A4rC4o8JdhG/89Luy0vJ0e8hioPl+OAxQOOAJuYDYeW
         vzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cytRWrFkEymoxrvU4Opr8X4kylMVyQGu4MiMlhfFHlk=;
        b=E1krNd26LLTYJTxUJklJDFAmkZ2Xn02zZ9y/H+3FtOMX31aA/jFNJ2AfVo3pwBmo8j
         R9+MXXS9OYMjXYwGq0d1BAPeyQ9F0khK8bFfJB109EX10fXyrNSkJU6QwpRqdbmQIzKr
         dql2JcQlEWwPLlFcagQE+ZKMVKz71VUKBXY2tjfh8AW0TpZNZVR9sxj4l6u3vwR7LabZ
         JUfaHzSbjphN6tezVsz6FnDWvbL/NLPJykXhhfK5xiKORtfK//hDnwV/0UDjTqq589+g
         aC4//YualZWL6uIlkCgq368OfuhyNolB6xAUquVayMZS4WUWfpXsD/LQwrpMNybgram5
         ZQBw==
X-Gm-Message-State: APjAAAV8ZUU2vmEEyHJ1vcQR05tSlgnL6My/nkEEyX6v5W1myuMGZ/1D
        7/sGBnfEttyVburYXocYCvGNjNgC2LnVO+LUero=
X-Google-Smtp-Source: APXvYqy/vONLbhKl6lwbT+LKdRtnlrMKtwP7x8sWnGesvnmZj8+aJTbrlfrpRK3kmx+WPjP88/mYFYH7o4igOtbv1rE=
X-Received: by 2002:a19:f11c:: with SMTP id p28mr30814050lfh.44.1568383588718;
 Fri, 13 Sep 2019 07:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190806014935.GA26909@google.com> <20190806132052.GB18442@sigill.intra.peff.net>
 <20190806204925.GA196191@google.com> <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
In-Reply-To: <885DEEA4-154B-4990-945D-19DABC87C627@jramsay.com.au>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Fri, 13 Sep 2019 15:05:52 +0100
Message-ID: <CAPMsMoAwfp+jv9h7xAD9PbqV+cU4njyf7Tex6HUCznqjb5hi_w@mail.gmail.com>
Subject: Re: RFC - Git Developer Blog
To:     James Ramsay <james@jramsay.com.au>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a minor question: since we have git-scm, pro-git, and git
translations in github, why not keep in the same place, under the same
organization? I just find it easier to find than having repos
scattered across different git hosting services

James Ramsay <james@jramsay.com.au> escreveu no dia sexta, 13/09/2019
=C3=A0(s) 14:34:
>
> On 6 Aug 2019, at 16:49, Emily Shaffer wrote:
>
> > On Tue, Aug 06, 2019 at 09:20:52AM -0400, Jeff King wrote:
> >> On Mon, Aug 05, 2019 at 06:49:35PM -0700, Emily Shaffer wrote:
> >>
> >>> Are folks interested in writing and reviewing this kind of content?
> >>> Any
> >>> ideas for where we may be able to host (maybe git-scm)?
> >>
> >> I think it would make sense to have blog.git-scm.com (and .org) with
> >> this content. I'd be happy to deal with the technical side of setting
> >> the name up. I think it should live in a different repository than
> >> the
> >> main site, though (which is an overly-messy Rails app).
> >
> > I'd certainly be happy with that setup if others agree, although the
> > incorporation with Git Rev News sounds interesting too (I'll reply to
> > that post also).
> >
>
> As volunteered yesterday at the Virtual Contributors' Summit, I have
> created a project on GitLab to start working on this
> https://gitlab.com/git-scm/blog. I hope to have a basic text centric
> implementation for feedback in the next few weeks. For now, all I've
> created is merge request with an empty Hugo site and automated deploys.
>
> Those who would like to be added as maintainers, you should be able to
> Request Access using the link near the project name.
>
> Peff, you mentioned Jason might have some designs or ideas with regards
> visuals. I'm happy to be put in touch directly or collaborate here.
>


--=20
Obrigado,

Pedro Rijo
