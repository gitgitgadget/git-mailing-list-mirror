Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B231F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfHHVUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:20:36 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45577 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHVUf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:20:35 -0400
Received: by mail-ot1-f52.google.com with SMTP id x21so31207860otq.12
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAzKyfKNuQ8chVXKkvXb5ds31ZeJCTYlrWaqUCB0G/4=;
        b=Un8JRcCcqI75UJYXMzqbYxp4UjpHBEk40PX+TJcb8DHsd9Bquw2BZnv5U+8pNJno+k
         eDtakXb0Ke3USZkRPZs9N19L8H+JNm2Qys+owrjaWrXhkPw7s8wO0CBcp/QaZ1YO/XXL
         zkv6L46Vtns2pMOlv6p8ZP58NUxtR2UhK5GPaoCyJqb1WaN87O0LmDYMTR41vNrY2drZ
         SUaRtuORJM8bWsAYoctNa8y97tGNAUcCugLVdsmhhqTXOol9qcrWPZ8pb6LdpSiyYCNs
         wNHBcXXESrNAPr0XCOz0m/LLUkgF326yTriy8O1VVFz0qZgetxoXrApTG0+idJAO2tsH
         UW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAzKyfKNuQ8chVXKkvXb5ds31ZeJCTYlrWaqUCB0G/4=;
        b=ctErZtUbCpzvXlOzosXUOo9YtjZLVoH9tVAyj6wvQtBGw33JnrKgI+Ajx1XXOOLefS
         q2JJRBp+4964gn8Y2Pu6qwip4D8pdMMs2MnXp3kYSortprbB+w3xLidK7ayex86he+R4
         Gciku4/eOiYcnCSuZMMCZWggEo5ddMxW87jlkJfQi72w3uw68wDVI+aDfbkDYqKaLuqD
         PmU+grFMY1w7+EgKQnMwDu7h5sDNF5Qp2ZvUslSqZTJ5+2g208CXnlOSeaN4Yr9JjfqL
         YO8Z8jz26osMIYJuu8bAKnhla3nJ96YDqIWbrTcA7mQsb+oZsOA87ZUPNeyVVg6jut6d
         yHuw==
X-Gm-Message-State: APjAAAUE68cHymji1MC4wyPCV/dwTR2zM9+C+JarrA4jaDOPhvGOySND
        s/BxQuuH9JktS/NfMWPf1o0Ji9Jw8gldxjb6DAS4Sg==
X-Google-Smtp-Source: APXvYqypoGRp9C/MiCUMBSxC948LrIbLmXMFwWW+qcFEXSAdRrDlA13XwkUEjmdVKnir79PQiQsQVWOo0knqrhSCx5U=
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr19463466jan.90.1565299234609;
 Thu, 08 Aug 2019 14:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
In-Reply-To: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 8 Aug 2019 14:20:23 -0700
Message-ID: <CAGyf7-FUsfKpr+HzOpS9TqE+x7GTnsVKki94gXzMVRwnnweC9g@mail.gmail.com>
Subject: Re: $> git branch splat response considered harmful
To:     jim.cromie@gmail.com
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 2:08 PM <jim.cromie@gmail.com> wrote:
>
> fwiw,
>
> jimc@frodo:~/prj-1/capnproto.git$ git branch -l
> * master
>
> I find the splat in the response unhelpful
> when wrapped in shell for loop, the splat expands into everything in
> current directory
>
> jimc@frodo:~/prj-1/capnproto.git$ for b in `git branch -l`; do echo $b; done
> appveyor.yml
> c++
> CMakeLists.txt
> CONTRIBUTORS
> ...
>
> it would be nice if some flag combo would suppress that splat.
> save me from fugly brittle sh $IFS fiddlery and incomplete workarounds

Have you tried "git for-each-ref --format="%(refname:short)"
refs/heads/"? That's going to provide short names for branches without
any indicator for the default branch, and without any special
ordering.
