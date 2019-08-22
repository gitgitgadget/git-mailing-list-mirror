Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 912111F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387498AbfHVQ7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:59:00 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:45308 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbfHVQ7A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:59:00 -0400
Received: by mail-io1-f46.google.com with SMTP id t3so13199200ioj.12
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/vRSSVtXVttFp891eSegROvOPod4ydVEYcLXKVN0eMo=;
        b=by6vpre+vh3pUOVhZEzhVpyTLwa4bTiduHL8JfyWfNC+RhzWU9UZOQitkSaSScT4PB
         XGODxAveiB1hjkeTkd93U3syr8svh3NMJk/qQMc3ggSZqVgSQY/p6zRJi9Bux6oJkuHj
         lcFh1Uk5mrsTs4M0R1lwou4VivH78PltyYZVxUz6YTaunjxc+V3yu/otU9SZUyuhdXdv
         ql94LovEQtNTwJ+RKPecMkeIDa2GkNilNLXltT4b3tVX3Bm/jGpPY83UoI9g+tW3bjMX
         0shvDIl918Ip3DLLPEUeejLtK+tHQvRPgLdyYgf6mvU9PbUhHDp6RKM39Qx4p3H+Bvy7
         MzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/vRSSVtXVttFp891eSegROvOPod4ydVEYcLXKVN0eMo=;
        b=ISW01X13cHVy8nviqtLyFANbiORVoqWdoAkBUeAJHL5DYMSPxawAv9ZwpLQl6XqmG/
         mXI+IxDIUi0WmQsbVvLFWPY6hNvxN0yc5NTKDCYpBzH6Ri0QuWDCy34vUSxILuhnlNrT
         HQm22ZkCinSl3neYaAjv7rX0sQ7oH8koKQWMNf2bljf4iE318I5HQ6kF1kNZaIuLka2T
         RFCyGf+gn+pOyXvptAU/PlJhgdDTv9TdnMQyFSOkvYtqYpEDBfOI3uaLoeRTOCf017d2
         51kdJitUdPka5lgs+wZP7O3ggIfws5L0rQ1E7ztd6IK6NONOEoUH/FLSaiH4/WvvbdsI
         pcDQ==
X-Gm-Message-State: APjAAAXywhHru85YmAWlY7pAO8JmAYSeejJ5rqwaHQnSLS9eOJcCu6Qk
        GSLvM77uiV6INeE4jDEMpU9CpTpg392LDPqx7Ut0WbaHyILLIQ==
X-Google-Smtp-Source: APXvYqyBsv1CD6oEW1VLmEJxJ88GNZl96VCTDefIqtGuJ1eNqlYRXMHMZkS2Y0Ynw5X0TgmnKW7h9i9ctg5s9uNQt0M=
X-Received: by 2002:a05:6602:2492:: with SMTP id g18mr870600ioe.266.1566493139608;
 Thu, 22 Aug 2019 09:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
In-Reply-To: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 22 Aug 2019 09:58:48 -0700
Message-ID: <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
Subject: Re: [BUG] You can't have single quote in your username
To:     =?UTF-8?Q?Giuseppe_Crin=C3=B2?= <giuscri@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 5:32 AM Giuseppe Crin=C3=B2 <giuscri@gmail.com> wro=
te:
>
> Note how `git log` discards the ending quote character:

<snip>

> root@NBR1710R:~/repo# git add foo
> root@NBR1710R:~/repo# git commit -m 'first'
> [master (root-commit) a78e11f] first
>  Committer: Les Actualite <root@NBR1710R>

If you look closely here, in the "git commit" output, you can see
that, as Pratyush indicated, it was actually "git commit" that dropped
the trailing apostrophe, and "git log" is simply presenting the
information as it exists in the repository.

If your goal is an accented "e", wouldn't it be better to set your
name using =C3=A9, rather than a trailing apostrophe? "git commit" would
likely preserve that without issue.

Best regards,
Bryan Turner
