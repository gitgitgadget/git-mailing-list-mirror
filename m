Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 468281F731
	for <e@80x24.org>; Thu,  8 Aug 2019 21:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbfHHVIf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 17:08:35 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36915 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732427AbfHHVIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 17:08:35 -0400
Received: by mail-lf1-f45.google.com with SMTP id c9so67841725lfh.4
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d6kqTrNfU5qiTUJMkBC9e85ZK+B6c4vf3uIJ/RQQ1/w=;
        b=BxVbyzJmFy1S5oi+ZH8FX5EFFluiAIeg3viekwhJEqLUQapdN7jiMQsFBPuCyhRTkM
         q0NtXVKl+Xqug/YW+G7cImGmjOSpTB17RgcZM9QqoCwadBFrnTkVQNi//UveL9vWyi4Y
         SEddlhqID7GYSFqahoP1BGX7Pz0xZxbBJ+bXGAv7Vz3hbgZ/mDFk4+dEDdAn1Pxf5N2f
         b04lawWc2qmHZVGsACqVpb+1QYhTPOQ/eGo7n0KZpQrSEt65G7puLZijAGPE5qKk6cZg
         2t4CRq7xIzd6P4nFGcN5YfyNshPhNNZcR6HGrXIWLMXLW1LYp5DIFZSqC1G4neX39wGF
         VT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d6kqTrNfU5qiTUJMkBC9e85ZK+B6c4vf3uIJ/RQQ1/w=;
        b=m2ue4gHG1Jrj71QjWI9M48kerItEWTPVlxnjpdfuXeRNy5fGOpHV0GyvWzcRGWsCw9
         prvnORCZS49A/qI7pDueEK7Rx1MX5t5NA/n5VsaA2pFDyxoXDEZylHwywZphCE8S1KUM
         mfZNZKNRL5zMzDUf9Tb98w4oS6DsqASdKCFDpy8gzuaMVlLCxYxM68YvLI8EuP+j/3Sh
         8Gb9OIKUdTlu4ElANRiMCjBq7boXBsmIu0XeqDhN1gBAti2g8XEjcnhzSZy2kpMn7z2g
         OS4GCt3aF3Bvh57NwkPG7EmIRFXSwtBznpQFAoWl4LdHSNKbt+9DVxJymTT7M/AflYo7
         XTYw==
X-Gm-Message-State: APjAAAVNLVMIQsJlLf509tZK/0zo8QULAY1nyJumktz/ZgwCQuVPvXE8
        nPFfYSsFyIvlJeQ4lKMGyn0WP+qIO5dDmKX3z/k2YQ==
X-Google-Smtp-Source: APXvYqzeBQbr8J35znClht3Wr8nySBh9GvOpaQ1s02n9/FGktLWGs0tB/0jNSUIaqef0GYpHrJSji8Ltn7S9W4WHLYI=
X-Received: by 2002:ac2:42c3:: with SMTP id n3mr5538603lfl.117.1565298512489;
 Thu, 08 Aug 2019 14:08:32 -0700 (PDT)
MIME-Version: 1.0
From:   jim.cromie@gmail.com
Date:   Thu, 8 Aug 2019 15:08:06 -0600
Message-ID: <CAJfuBxx5R28cjUj1v+mB4J+uUpbTMWnYowrCc=iOAbOcqWX-_w@mail.gmail.com>
Subject: $> git branch splat response considered harmful
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fwiw,

jimc@frodo:~/prj-1/capnproto.git$ git branch -l
* master

I find the splat in the response unhelpful
when wrapped in shell for loop, the splat expands into everything in
current directory

jimc@frodo:~/prj-1/capnproto.git$ for b in `git branch -l`; do echo $b; done
appveyor.yml
c++
CMakeLists.txt
CONTRIBUTORS
...

it would be nice if some flag combo would suppress that splat.
save me from fugly brittle sh $IFS fiddlery and incomplete workarounds

git branch -l  # no splat
  master
git branch # splat ok for back-compat (if you think it necessary)
  * master

it appears that by convention, checked out branch is both 1st in list,
and splatted,
perhaps _DIRTY_, JUNK, or maybe "" would be good 1st line of response
if not on a branch ?

also, I found no mention of the splat in the man page.
