Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE2F1FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbdEaSdd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:33:33 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35773 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbdEaSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:33:32 -0400
Received: by mail-qt0-f174.google.com with SMTP id v27so19176854qtg.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edmodo.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=tmuUEmxyazhCrOfFmRF/nAUNyvdsBXHARkMqYKK01NM=;
        b=B3/zfD+7Tkl25mV2n93e6Rtc2P41abKGRuhfttplIdapTUOMlzwdZymKBenhGfPDLK
         z6M4V8WgdBL2Ssm+6G3QrkV/uiJFRIXxoGqFLN1SNtrSV8tJRqQR1joIame0G0zPPw63
         vBtvFspQ4yO6W9omRHWDEC3xD9E7dPnwC+dgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tmuUEmxyazhCrOfFmRF/nAUNyvdsBXHARkMqYKK01NM=;
        b=Gl2DkHC/3LxD/7U72bdX3HEd3gL+KrO0JVQ/E0xwRGWniT4gg2lUKbt7buv65mONLH
         MGhGTf9UrP5BN8FN8xcQWrA5eBg8Fhc+Ci2gg3scjPkGGx9vDUNowklXMLQ3JvDaJzJv
         y0eHMdxhgWlcRynlIvlH77tatGg6Mj6JPY05yo1O4nrEG73FY8Ais4eD/qGr/rYjbCUF
         BthKQ75pZ9+rn9oV8+MR1rbiHaeq+b1w64OxeHTSsUrYyjudbD9IYadqiexbCnlofvw8
         Z/WtpLzNqPTLKqB+YngS+luKkprozI2KO0+Ysxjl++SiR4VFcPzsdHxufOXOimAzLKG8
         oCyg==
X-Gm-Message-State: AODbwcBnjlcYqNsBVGBY3whFwUL6b3aG15mGGHxTtAcayFyaL9qk9nBA
        QzuU7dR76MoHe9TWwyGuAMvN+uI9VY2CJ6ABzw==
X-Received: by 10.237.56.68 with SMTP id j62mr8348941qte.82.1496255611859;
 Wed, 31 May 2017 11:33:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.147.44 with HTTP; Wed, 31 May 2017 11:33:31 -0700 (PDT)
From:   Irving Rabin <irving@edmodo.com>
Date:   Wed, 31 May 2017 11:33:31 -0700
Message-ID: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
Subject: Coloring
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Folks, I am reporting an issue with coloring of the output of Git
commands, like status, diff, etc.

Specifically, if the field is supposed to be white, it doesn't mean it
should be literally 0xFFFFFF. It should be the color that I have
configured as White color for my console emulator.

I like light-screen terminals, and I configure my ANSI colors in the
way that they are clearly visible on the background and clearly
distinct between themselves. In my terminal settings background is
light-yellow, Black is black, Yellow is brown, Red is dark red,
Magenta is purple and White is dark gray. I set it once and I can use
it everywhere - all Unix commands work correctly, I can edit
highlighted source code in Vim, and all my color settings are
respected.

However Git behaves differently. When I run git diff, some of the
output is literally white on light yellow background. It is like "we
know what is White, so we ignore your settings". And it is quite
irritating.

Is there a way to make Git respect terminal settings and not to
override them with absolute colors? If so, please advise. If not, then
I guess it is a bug to fix, right?

Thanks,
Irving Rabin
Software Developer @Edmodo
408-242-1299
