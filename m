Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53761FF76
	for <e@80x24.org>; Wed, 21 Dec 2016 00:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933871AbcLUAST (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 19:18:19 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35759 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933131AbcLUASS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 19:18:18 -0500
Received: by mail-it0-f54.google.com with SMTP id c20so92510342itb.0
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 16:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dvNYfTkc3WahK74tmDYeHhRgDLbZM9/gh3JRcJBrcEk=;
        b=dQobu0OKSHxf8y63EJeQWs4rIYcSeIciRn6nfu1y9PJiyV7i534CMVRVuG3+tF/vFg
         Y9vvhWRpZtsoCb/bQlTU1a+VDCAF43hsRU8bPPIY1EGZ6Njfmg3h0tT7oK2MfJgupb3f
         1v6lkFDTi4W0aS463iUYfnpre4lGKjDa/L3y48FN9H2HvyGEWCa+bz0cTzM2D8YbKzoq
         HCiLRGP965jPqn/dBhoYSnVmTdkBEPn0TMugmDH851wGlYc/HU/TGfZUTwH7Ps7PRIck
         4G1/9a7c1SjDm9qxpY45Qd1J6Sv2T0pxM8OTQpyR+0rQ1RP+PQ/wywy5b3ceerWhpWiN
         pRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dvNYfTkc3WahK74tmDYeHhRgDLbZM9/gh3JRcJBrcEk=;
        b=tvcS/o25ZxZlE+QskNQER/08dNYSb3hT33LGOFQF4bWQIo2FmH013mbi+YcBwaYVcy
         caaV0VF4PNCW6/LApknN2tfb7coPw247a5TO5Wyp1uDsVytfqj2ruUK4uIkzrotq2xxv
         tWweIiEhMf71S/0xdWbwETNejrzueZGvQeXr3ru68Cpl9BvlwxAjrZ90xqA8luVD6zSl
         OWzlRqXfg4rtTWQtT0opzJ5frMlXdydSDMjbhdvCYDxiyEon9P/ZTcFbU3t/QedfB1MZ
         0oRgHkP8Yyz/Z5Wcfv50AF2TkDJxKA8nid/NmnnBXy37OyQotdS166zSpn5Nefc587RL
         rBxQ==
X-Gm-Message-State: AIkVDXIPt5ro2ejIMCYanoiRIajnvz02dSXk7GofHwfHVj/6TWjYmETqDw7NuHFyXFmQNv7uptR5GQMxWOa2PA==
X-Received: by 10.36.146.134 with SMTP id l128mr3071929itd.11.1482279497359;
 Tue, 20 Dec 2016 16:18:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.6.163 with HTTP; Tue, 20 Dec 2016 16:18:16 -0800 (PST)
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Tue, 20 Dec 2016 16:18:16 -0800
Message-ID: <CAM+g_NtsSaiZdy2Pq0gR9AaO6xiNnGSUbj5yd-uW3S80roEGCg@mail.gmail.com>
Subject: config for `format-patch --notes`?
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I use `git format-patch master..myBranch` quite a bit to send patches
to other developers.  I also add notes to the commits
so that I e.g. remember which patches were emailed to whom.  `git log`
has an option to automatically include the notes in
the output.  However, I can't find such an option for `git
format-patch`.  Am I missing something?

Another nice option would to to somehow include the branch name in the
resulting output.  Right now I use either notes
or abuse the `--subject` option for this.

</nk>

P.S.: Today I'm sad and proud to say "Ich bin ein Berliner!" --nk
