Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8A61F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfHRUzt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:55:49 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40258 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRUzs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 16:55:48 -0400
Received: by mail-wm1-f54.google.com with SMTP id v19so1255321wmj.5
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mat.ucm.es; s=google;
        h=from:to:cc:subject:references:user-agent:reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LfwZZ2UhJ6EBJ7LZjpUJyY3aThEXhpvxlSwIBxeeSiM=;
        b=FrFdatuRm0i+xr3eLWezbNjdJUgce3gpU2njJ5lM6fMJXUqE1aeY0u/p7W67PkYtPP
         +lxl2VRp2eUQvKGI4RafGKgZfbFbk+XMIJ6zM2tqde0JIz0nF6vhY2UTGLwkgjX6SkpZ
         gunWrCdh5Tw9ZulGJG3KcI0Emp5uwZLNA+R1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=LfwZZ2UhJ6EBJ7LZjpUJyY3aThEXhpvxlSwIBxeeSiM=;
        b=lkwOIlcbe9g7Gh3efrbcNHix43XBsPjhKRVzDdSnN4uhRwM9cnpRdmjZte6NtknlEO
         kiKAiMjy6zgmxKuJUGexCpowti4VTzv+WTE29MIxXgCQYkuVyv5nvgtUDH3sczggzzZ8
         g7IVT7Q8ldYKNw4NxFtFiha7Se0ZPxYPxSrPbbQGoE92qSHZ9lRcMqoHgIlRab4+UwhP
         /eZCLmj9u+R3LP1/2VHIYcCRJk3oYt8ZJYMcZPqIZq8xXaTaav28GO71bWsSgq+gfgY+
         W4CZpqS4PDU9cMq0MjSCUVexVqFM8I9rVDCJUVqqBRY/giVkwUQaENjhAvvdAJRkReDO
         Z+1A==
X-Gm-Message-State: APjAAAWvCxCJ+hv1zmki5L5YblVptFZ1jNUvRvq60uz51XAiyqEoGcS0
        DR3rHk7EBWfcTogd5J6cn2FH1g==
X-Google-Smtp-Source: APXvYqy4TiuUrC/1GDGqwSJanKZH8Ou/K3IXgl3Q3lVI0sQBM/7IClqaTMC4PXNNmPBRxRNUWGAmTw==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr16244453wmj.36.1566161746751;
        Sun, 18 Aug 2019 13:55:46 -0700 (PDT)
Received: from Utnapischtim (p2003000611CFBC551D8B09B695741519.dip0.t-ipconnect.de. [2003:6:11cf:bc55:1d8b:9b6:9574:1519])
        by smtp.gmail.com with ESMTPSA id e3sm13590361wrs.37.2019.08.18.13.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 13:55:46 -0700 (PDT)
X-Mailer: emacs 27.0.50 (via feedmail 11-beta-1 I)
From:   Uwe Brauer <oub@mat.ucm.es>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: [SOLVED] (was: git log --graph with a sort of local revision number)
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
        <87blwmmcbp.fsf@mat.ucm.es>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
Reply-To: Uwe Brauer <oub@mat.ucm.es>
X-Hashcash: 1:20:190818:rafa.almas@gmail.com::1dv5Di0SN68RXkKc:000000000000000000000000000000000000000000DRM
X-Hashcash: 1:20:190818:git@vger.kernel.org::YOUWpm2Bj6ea7Njb:0000000000000000000000000000000000000000002JBX
X-Hashcash: 1:20:190818:oub@mat.ucm.es::8eDiWApj78EU+LwM:0004zK0
X-Hashcash: 1:20:190818:alban.gruin@gmail.com::4ttfwtavOqnBF/Wg:0000000000000000000000000000000000000000CI//
Date:   Sun, 18 Aug 2019 22:55:43 +0200
Message-ID: <8736hymbw0.fsf_-_@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> "UB" =3D=3D Uwe Brauer <oub@mat.ucm.es> writes:

>>> "RA" =3D=3D Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:
   >> You can achieve something close (on small repos, more on that later) =
with:
   >> $ git log --graph --color \
   >> --format=3D'%C(auto)changeset: %h:%H%nuser:      %an%ndate:      %ad%=
nsummary:   %s%n' \
   >> | git name-rev --refs=3D$(git rev-parse --abbrev-ref HEAD) --name-onl=
y --stdin

The script to generate a test repo is
git init
echo "First" > test.org
git add test.org
git add create.sh
git commit -a -m "First commit"
git checkout master=20=20=20
echo "Second" >> test.org
git commit -a -m "Second"
echo "Third" >> test.org
git commit -a -m "Third"
echo "Forth" >> test.org
git commit  -a -m "Fourth"
echo "Fifth" >> test.org
git commit  -a -m "Fifth"
echo "Six" >> test.org
git commit  -a -m "Six"

Then your command even in a short shell script
#!/bin/bash
 git log --graph --color --format=3D'%C(auto)changeset: %h:%H%nuser:      %=
an%ndate:      %ad%nsummary:   %s%n'   | git name-rev --refs=3D$(git rev-pa=
rse --abbrev-ref HEAD) --name-only --stdin | more


Works as you described.

Thanks

Uwe Brauer=20
