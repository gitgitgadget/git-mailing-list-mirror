Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5039C1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 00:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfARAci (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 19:32:38 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:40008 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfARAcg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 19:32:36 -0500
Received: by mail-it1-f178.google.com with SMTP id h193so3682916ita.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LGVv3j3vAHYqltA9H/ysUh4jg8+lc6BJcqwsJfTR8FY=;
        b=AUCMJRXeRu0zPd6A0JNiv4RSnRXEyHv2fJrk0pkKAY3PXeiJn8lqhuUGHvVzbVrc3X
         jSB1fQ7M+7AELE1rvNmj5LGBoESEHAzFK6lV0VE3s3bk/5hwlnp4zZzCIySeVfto6RH/
         gm0kDP19hZVZjBLTa04WduPBywao167Y6ZBPrivN7XRvu/v1tsQApJldw98YYRhjI7QZ
         tZh3Q+CPCmN1yc5XoEmHBQnBokHVPWSbTLCQ+xu996Tlx3ZsJ4DpFJUhRxcY4W5kfxlm
         uipr7EbLaeSOENrrv3Au8c7N9oGcipyyjHeiV7MCUEjh7dpfqVxMLOp8cWoAPplLF9r5
         oZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=LGVv3j3vAHYqltA9H/ysUh4jg8+lc6BJcqwsJfTR8FY=;
        b=nIRfSs+JL1LFByjmvgxEDR/oyP24Z1nm7GOztK3G2tpkSZy2VVM+5d1HxUpM/5Agkr
         cldEaznflRb76iR6YrfYKvdJo0lMC/N8k74KyyYs7cPXpsBejM4A0+BrG9dJ0lQGWprb
         Kr4f2D5+ru7oF1q9xRZ1dW5E7qonVgAXRy7OoCE009hbgy5TCfRqxo86FkPaG35N/So+
         Gtk/Giv1yCk0uOA1RtlGux1biFppK7wdGLHRKO9/g8M8gzx9Cc6AB8jzuInJn8G1gxEO
         IKwBvuebeDObvxv+gmiAaL2pZFRdxGWS6e9z1MREHhsNLzrVYOV4676HzcWBbx8VpoOm
         1Tcg==
X-Gm-Message-State: AJcUukdBUPON/Ufq1h+MlzCoYNbalNXTG4nqJMNuEhiPJybGV5uFAsBV
        B8nXVwy1U0WA16DLKThv0NocCrA/8nfiVN3tLNtL+pM0
X-Google-Smtp-Source: ALg8bN6c6YDJW0xWH3dZH5cKRUenjFF058fgf75C06OtRj0Gl396/x/QmYyc3UDM513ydVNTw9speCG6cb5HXFMJ9+E=
X-Received: by 2002:a02:183:: with SMTP id 3mr9646132jak.130.1547771554855;
 Thu, 17 Jan 2019 16:32:34 -0800 (PST)
MIME-Version: 1.0
References: <CAG2YSPxynGyj3kFxPbvHDETdievY0c_NGSohPSFURuNjhyaYWQ@mail.gmail.com>
 <CAG2YSPzFzpwKpDo4cCjUinpTDhFgd3ax0f_g--ZDd76=UJt35g@mail.gmail.com>
In-Reply-To: <CAG2YSPzFzpwKpDo4cCjUinpTDhFgd3ax0f_g--ZDd76=UJt35g@mail.gmail.com>
From:   Mark Kharitonov <mark.kharitonov@gmail.com>
Date:   Thu, 17 Jan 2019 19:32:23 -0500
Message-ID: <CAG2YSPzATssL9Ym4FWszfOqEMZsAR2VN+mm-Qs7XFhod79E88w@mail.gmail.com>
Subject: Re: A seemingly wrong PR merge resolution.
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please, ignore - the developer used the Merge Conflict resolution
plugin for VSTS to take the target of the merge, instead of the
source.

Please, accept my apologies for the noise.

Le jeu. 17 janv. 2019 =C3=A0 15:56, Mark Kharitonov
<mark.kharitonov@gmail.com> a =C3=A9crit :
>
> Hi,
>
> I have a very strange issue where a change has disappeared from the PR
> merge commit.
>
> I described it in great detail on SO here -
> https://stackoverflow.com/questions/54244042/incorrect-pr-merge-in-vsts-t=
he-new-change-disappeared-after-the-merge
>
> (Sorry for the spaces, did not want it to be rejected)
>
> The post contains quite a few images and it would be cumbersome to
> replicate it faithfully in plain text.
>
> --
> Be well and prosper.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> "There are two kinds of people.Those whose guns are loaded and those who =
dig."
>    ("The good, the bad and the ugly")
> So let us drink for our guns always be loaded.
>
>
> --
> Be well and prosper.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> "There are two kinds of people.Those whose guns are loaded and those who =
dig."
>    ("The good, the bad and the ugly")
> So let us drink for our guns always be loaded.



--=20
Be well and prosper.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
"There are two kinds of people.Those whose guns are loaded and those who di=
g."
   ("The good, the bad and the ugly")
So let us drink for our guns always be loaded.
