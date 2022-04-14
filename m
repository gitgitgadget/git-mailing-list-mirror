Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD03BC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 04:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiDNEtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 00:49:24 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D08396A7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 21:47:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t207so3093951qke.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 21:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SjqYXBdShxKU7g9AB6ze9AuJiR5b6EkEotoXL9nkLz0=;
        b=JkGJpM7YJTTFDzMuBmWm8xpricqgZ4YumNfStMj015k47WEhuzufGhCe2TABSlXFzD
         47yUsCxmJNgHpC3OoNQc2HzMxe5PaqHk2GRxL166aDHJuvRpbQZMCieJu4EhVVmTG051
         Mr1XzPh3z+0QOZB/EV7n/GfxTThtEEyTEH4MIYSaqcYHVUwc4N/uDoORUFoUmrzgn/Xe
         K9rIVUPnijudaGyi4Lm1zpSrSxsT3zQf/hnd00wvlbzPis1ukX2+k/ffGM1CPBT41rWx
         RM6nwc+cth4vJFvaGVJ1QNbDkNmrgurAllIQzEqI+RmAMIaQwd5+VLw5qwCGn3aKoDrZ
         qVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SjqYXBdShxKU7g9AB6ze9AuJiR5b6EkEotoXL9nkLz0=;
        b=mtMzVYd+6XD8ih6OVOkbniKmy3EXTbFCXW1A+GpfgC/qve1gI83HVpUNseovKsuRar
         mmwLWwZ1hlwjYGczHvJTp4mEvJmXZOQjVZaFy4DhObPM/S2EAQhQGRdla8rDH2kq6ivR
         9UtCBl/N/SOCUTCyrN7Cb3uiyAAaWIXj7iQjWlOxacCH7jfPUfK7q6u5gV99UIkYOvML
         aS2UWZGhCRIj6rUCMMOZMi2bfSLUYEuod3JweC0Pc6oEwKtaf+lx0/jFUZwFsYY1xb19
         w473c6dE0b/f5C9sUlTMCTYB7H4zNqalsOU1+DGBeVq0+oqftimv9QpTRt0QLvlXxkmS
         d0Bw==
X-Gm-Message-State: AOAM532deJBwS1EQxXDwr8+6ha9Uka0ojwXd/oNj1qBhG1so7IBF3l/H
        HRLMJ0FikPVogHIkM2JuG51hBEfTTAupHDzUMLF6dDPDi3KGZvO5
X-Google-Smtp-Source: ABdhPJzLelzrVC08ry4x25IwbgLw/AlGG3Og7AsDHn3ipjS2XxXK+1rl/JqdafAH0LjUepr/dZvpAer/XWUF4X1gFT4=
X-Received: by 2002:a37:9c14:0:b0:69b:fcb7:9b11 with SMTP id
 f20-20020a379c14000000b0069bfcb79b11mr598601qke.206.1649911618314; Wed, 13
 Apr 2022 21:46:58 -0700 (PDT)
MIME-Version: 1.0
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 14 Apr 2022 06:46:47 +0200
Message-ID: <CANgJU+WApga2t+Ubzz5sk=7AR5pNCy-Sm8P7pwMULsBpmb8asQ@mail.gmail.com>
Subject: Thanks for git and especially thanks for git add --interactive
To:     Git <git@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I don't know who to thank directly, and I guess it is a community
effort anyway, but I just wanted to thank everyone involved in making
git add --interactive and its wrapper git commit --interactive. IMO it
has really revolutionized my development workflow and dramatically
improved the quality of the commits I create. I often spend longer
using it to create a clean crafted series of patches than I have spent
on making the actual changes. I have seen people describe it as an
"advanced" feature, and maybe it is, but I think it is one of the
*killer* features of git that has impacted the quality of commits
across the industry.

git as a whole is a wonderful and fantastic tool that has obviously
completely transformed the version control part of our industry, but
commit interactive has completely and utterly changed how I think
about writing patches and the quality of the commits I produce. It is
not unusual for me to use an almost completely reverse workflow than I
used to. I often create a change, not worrying too much about how I
structure the commits on the way to the final state, then I squash
them down to the final state I am happy with, and then work backwards
to create a tailored series of commits that changes the code to that
final state. That is something that I cannot imagine doing without
git.

So thanks to everybody on this list, Linus, Junio, and everybody
involved with making git such an awesome tool, but *especial* thanks
to whomever it was that dreamed up the interactive commit modes and
everyone else who worked to make it such a fantastic tool. It has
literally changed my life.

cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
