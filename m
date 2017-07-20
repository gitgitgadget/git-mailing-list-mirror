Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602D920288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbdGTAuL (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:50:11 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35812 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbdGTAuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:50:10 -0400
Received: by mail-qt0-f175.google.com with SMTP id b40so12594051qtb.2
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OGPbOzrMJT+wjfT4wVGFpd+vheHcXpPYyryn+jwgyGU=;
        b=UfBy6YUYblxxP5i0q77LxcgOnx4eJ+HeSsQYzr4iSYxEipIuLK+CTFovCWxGnMQcY7
         ZFtUBzyOygzMoQROIWg166skOuqlIJx3P29hBeIBXa8LtaI6de/gyralET8cXK9lV09P
         TCaSvOcnFN/kX+fMy0a0gF+fPVnE64sbQiY2zWHNUVY0Jeyqc30EJ/Zmunt/X9skpzbQ
         8jKkFwRQ9YKHdjVzaTY0Bz4iYh1ADXLsKpZSjCQqDIFaJoNkzEsn1X5vza8lxmF/z2ZH
         4AlVfJNZzggt6bi0Gxh+WOZruqHk82uak1FNcI2790Rnrx+QVRtWvAkZrt2yvf6Stgzt
         0C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OGPbOzrMJT+wjfT4wVGFpd+vheHcXpPYyryn+jwgyGU=;
        b=OYnB8TuHZEIVt4EacLTle98jCxi4AZ/m9j/tRnpI/fIqG87QzRH30DA96aUlXW1TuW
         e7cDhsK8Ev1kLDvU7jVbUrCYmZrnmxU83aHQKpOzxSMd6rBJrWRXOJgDQaV5bARvEXfC
         rxNdRk6HKBWEdIDoi0GU2sYvuFh8qsoIG/+9Q07aERnYa4NOCkMUKIcFnOa6BflOErFf
         jfOWmKGcve5fG3Gb2sWawzS1++hrugDFE1/w0ag1u4E01Vo23jZEWQHfFJYB3rMvYt00
         WVb3UxpZBXdajVGp0n0iyRps12fHEQD9E/VUZRjKvBLLAeFAY6VSQJktyLGZH9TnAoAW
         dlLg==
X-Gm-Message-State: AIVw112xjKDzmBb77eipEz87J4g9SwzO1G7h0veVrQeVoWpEuStydVP1
        QdidUd/ExFeNW9CpNYIws3wW5v748yzP
X-Received: by 10.200.35.116 with SMTP id b49mr2662503qtb.24.1500511809770;
 Wed, 19 Jul 2017 17:50:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Wed, 19 Jul 2017 17:50:09 -0700 (PDT)
In-Reply-To: <9f2b1205-01fa-ef7b-81ec-7717103936c7@softcatala.org>
References: <CANYiYbET27mNrZZTNmn_dKBHLLEb4wJiznZ2O1X=WQ_GtamN7w@mail.gmail.com>
 <9f2b1205-01fa-ef7b-81ec-7717103936c7@softcatala.org>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 20 Jul 2017 08:50:09 +0800
Message-ID: <CANYiYbESKtiAounR3hT-n542qoFcUx90DnMGNk0JGiEq9s47Nw@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.14.0 round 1
To:     Jordi Mas <jmas@softcatala.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-19 13:44 GMT+08:00 Jordi Mas <jmas@softcatala.org>:
> El 15/07/2017 a les 07:06, Jiang Xin ha escrit:
>>
>
> Hello Jiang,
>
> Sometimes I do several commits to complete the translation. However, gith=
ub
> from the UI does not offer me the option to Merge and Squash.
>
> Can you check that you have "Allow squash merging" activated for the
> https://github.com/git-l10n/git-po repository?

Yes, it was activated. But I doubt the commit log of the squash merge
won't follow our standard.

For me, I prefer doing an interactive rebase and squashing all the
commits into one, and will record the contributors in header of the
file and in the commit log message.

>
> Allowing this from the Github UI will make life more easy.
>
> Thanks,
>
> Jordi,
> --
> Jordi Mas i Hern=C3=A0ndez -Bloc: http://gent.softcatala.org/jmas/bloc/
> Planet Softcatal=C3=A0 -> http://planeta.softcatala.org
>
> ---
> This email has been checked for viruses by AVG.
> http://www.avg.com
>



--=20
Jiang Xin
