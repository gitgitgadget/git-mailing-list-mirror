Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3EE207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 12:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdFZMRZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 08:17:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36466 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdFZMRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 08:17:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id y5so1131039wmh.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=aUkJlDmONw6U/SiM/wrrcBHulIssLtsyWq6sJyAYCNY=;
        b=JZNd4HVvf2Sr700+1kTrgkBOx8R+/+xRzULENXiFWaVfdNyf9VgdxBbr/bBpswpNe8
         HDqEDsbk0+qDd2zZbXkYOXsTB3TpI1g2t8vicAdKD6MO/M55kHLkvp/Vp8VFQfubftHa
         sk0uS7F+uZrrXKkcI5aKXcyvA9ITZdQc4Bxy0BO4XlJYmpuaxnJt33euwmIWOcaiCyx+
         H7KIov9/Rpvf7x9rSzt+bPH/1WGA5jre2+MJsNeCGWmWYDBx//gMH1kqumC2YjgMwyKE
         5pZ5MjQLdMAg48UYGyuzf0B5tBGzeJbIT4I8l6mDR8UW1WkevoHQk6zA/A/b0xk4JQYM
         vJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=aUkJlDmONw6U/SiM/wrrcBHulIssLtsyWq6sJyAYCNY=;
        b=J9Kz1iAWBvg4nqzGb41lMpyST4IB/h15gnf5CEhBar9mefpSKCyx+zFZNvwV1iHvsb
         88xmw1kEMJZMJMTNY4a/01uAIBWSTo/rzQ+i/+cOnKvHSrPD10lZaDbu/houkNu43Q3P
         5qckVTeFlk90QxZi0u0CoVGcA0OkF7+RNd4OqxzPh2XfUBxnBM+f6+ax9k3D04YRBsIG
         iQkGq4GJwPA8/JqWiiHeh75GomqRXhV5ExhJ6PkQGFl3eiR/tYrGVhSnqPgcBxQ0xvAV
         ExeVsQ1B/XECqJhk8A+v2R9nSrAKfxf+8flpGx7/k3TmnSwQWoLL9YCE0xpZ8avaqDJs
         JinQ==
X-Gm-Message-State: AKS2vOwlLYG/LxXdS+waczMAarjl5Q2rZo0Kp+LeRqpnJRFVx3uyytK8
        d5pcC7sJNDwocSPJRC0=
X-Received: by 10.28.113.21 with SMTP id m21mr2126684wmc.80.1498479422381;
        Mon, 26 Jun 2017 05:17:02 -0700 (PDT)
Received: from snth (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id j31sm7609977wre.67.2017.06.26.05.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 05:16:59 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dPSwt-0005fU-4K; Mon, 26 Jun 2017 14:16:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Git ML" <git@vger.kernel.org>,
        "Git Packagers ML" <git-packagers@googlegroups.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: ANNOUNCE: A mailing list for git packaging discussion
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
Date:   Mon, 26 Jun 2017 14:16:59 +0200
Message-ID: <87injjc5ac.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that my PCRE v2 patches have landed, I wanted to prod packagers of
git to tell them they could build against it since they probably had it
packaged already.

After E-Mailing Jonathan Nieder about that asking if there was a better
way to contact packagers than hunting down their E-Mails individually:

    > More generally, do you know if there's some good way to contact the
    > maintainers of various git packages (I was hoping there would be some
    > list, even an unofficial giant CC one), or if I'd just need to hunt down
    > the contact details for common distros manually.

    Sadly I don't know of a git-packagers@ list, or I'd be on it. :)

Hence this list. It'll be a low-volume list used for dev -> packager
announcements & coordinaiton, and perhaps discussion about git packaging
in general (to the extent people feel a need to not discuss that on the
main ML).

If you're interested sign up at:
https://groups.google.com/forum/#!forum/git-packagers

I've already invited a few people I found in
Debian/Ubuntu/Arch/Gentoo/FreeBSD git package changelogs with some quick
Googling & those I personally know package Git, but if you are or know
anyone packaging git please sign up / prod those people.

Thanks!
