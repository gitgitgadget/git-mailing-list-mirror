Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35BE1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 01:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfBTBWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 20:22:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51942 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfBTBWu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 20:22:50 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so11416909itc.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 17:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a16UZaqjjxqBWWmP8lhpDhlrG2FwcAJZK9wyagyiKi0=;
        b=NGyCGe5vWGmW37WunGYFqPb0Jpf+JDeYHMTdJz6/XQ74KlRRtYFGF1cKuiiaFdf6Fm
         EyLE2c8eo30Dpqeq6DomUN4JS5coH8JHlnjBwFOgL7sdOsHibDnbDSm2A5phZXnBB7bR
         Pcd9zypxEwI+d9bbDv0af4FfihNCrAiOvl7Bjp5c7f1o2QLtBBqy8kHaYcYwnCeATZeD
         GhnLmAfb6BYke4odMG1OpnK4JeOannqYKc6kStJ9AhYU4AeiZkEQGdyJnvBlqdbmRP2e
         sTYTdI0EMRw2O6CMGMxF+s7P591zELZ0yTnULUCAcWrOkWAgjhfDHJYJZHOBBg6y9CxH
         3ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a16UZaqjjxqBWWmP8lhpDhlrG2FwcAJZK9wyagyiKi0=;
        b=nIF8RLfGmXJ+xpAL5jMHzPAXQ9ELIFbNmhAYIzL7vw8iF3umVZaWZQaGcGAeCwfFbp
         4OFVOs0FFq0lNQeqQIi9XpNd90kB5KCWPY/kKeW/4foMg6dRI4JJ7PiiP414m6msg5Jw
         xJx2DVSPfK07gJkhF6VMdV9X4JV/QIOo71yT1ASK9O2lMEu+5OV1USYmWCdcUwCqWLYr
         l+h+sD+5/rp6j5EmXBBNUhmavbrCWTt2TI0bb5CFEp05tErkRU8cYw/jkeSjtCVTgVa4
         y91q6E/C5CA591dajMuaPKN7iSVwuKZOTMI8GzwkYU8wdmU/atMTpeMu6Xhlj+B2wEc8
         qUSg==
X-Gm-Message-State: AHQUAubdboE7zaJBrlV/gJInhMqtn3Al8NScMuioU8Mbuz0eCoIXdCae
        S7hd2SahWMHdiz03QRz+4F32stX+5xfj32nBUtb/PQ==
X-Google-Smtp-Source: AHgI3IZriHLyO9tsAz6VmIYKnxmbRqul4TniDcQDURmpeUGspwwqnAnGT67wJb7zKU/83ZyRMB79J2udVRVphbrzA3s=
X-Received: by 2002:a24:c056:: with SMTP id u83mr3518710itf.10.1550625769309;
 Tue, 19 Feb 2019 17:22:49 -0800 (PST)
MIME-Version: 1.0
References: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
In-Reply-To: <CAApa7v-F7Y_WR11V-3jc-R4Y1qSv5PPof6GWvJuF_XMeTcC2zw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 08:22:23 +0700
Message-ID: <CACsJy8AS5eNO6gACGtRZq=qdQGkQ3jmQPVivPG+=du9u9hKYcg@mail.gmail.com>
Subject: Re: Feature Request git clone shallow-include
To:     Joe Enzminger <joe.enzminger@exactasystems.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 20, 2019 at 7:07 AM Joe Enzminger
<joe.enzminger@exactasystems.com> wrote:
>
> Currently, git clone supports shallow-exclude=<tag-name>.  The client
> will clone up to, but not including, the commit with the tag.
>
> It would be useful to have the ability to include the commit with the
> tag.  The suggestion would be to add a "shallow-include" options to
> clone to support this behavior.

So exclude the tag's parents and everything before, but keep the tag, correct?

I think if we support --shallow-exclude=<tag>^ then it should work the
way you want (if the tag is a normal merge you may need to add
--shallow-exclude=<tag>^2 as well). And you can do even fancier thing
like --shallow-exclude=<tag>~3 (i.e. exclude the  grand grand parent
of the tag, but keep the tag and grand parents). We will need to
restrict extended SHA-1 syntax to a safe subset of course.

> I have tried to use shallow-exclude with a follow on git fetch
> --deepen=1, but it always returns "fatal: error in object; unshallow
> <sha1>"
-- 
Duy
