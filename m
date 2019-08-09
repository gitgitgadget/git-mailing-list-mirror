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
	by dcvr.yhbt.net (Postfix) with ESMTP id 909A31F731
	for <e@80x24.org>; Fri,  9 Aug 2019 05:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfHIFba (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 01:31:30 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:39621 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfHIFb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 01:31:29 -0400
Received: by mail-ed1-f41.google.com with SMTP id e16so404016edv.6
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 22:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5UJraK/xSDxU14pViRQ28L+xJv8eEAFKySmLsvZ+ky4=;
        b=RbvP98zeK26bOnsIDIk9/8sFJeA4WJGjgfrENIHenKyXqJDj1TDCiTxDDXlyibHE3r
         XonEjKQqXoVaoUevsCWMp/C80pTJwuaZ3Lce2CW+WApGYOaaZWcHLinfDl7jB1b+gzTE
         WmdmGW8c5QjfVtCPnj5caD3uKnqzivYjGK058MExHmrrFGie1vPCiq5mRzOjrMHlBqUX
         6Z7nf5sYBpMIUvFeGkaz+HPJqBYTHhq78XziD2+GP0StJUrxgtlXSh8o5Unbr2aBm08V
         h6iAk2SfGxDSagb76Yy/yOVySvF1VSFOIIjvyYVNsC4nogpkEqG1Llqn2UnXCAtLTn58
         VqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5UJraK/xSDxU14pViRQ28L+xJv8eEAFKySmLsvZ+ky4=;
        b=q1y6+28ECAMwHO9xAldPf7ErUwRn3a/zMw5oHlgFJ/GCESiobmALazCAMU1ufn77di
         ZJSR27FQxKGubX/cF48UqWMM/HhlukkEQWxpeMd+22cFqYCmeuwZVCAqIFDhmQePhk4v
         tjk79+NMB7C38Yd76drYJ4MnhdpDC6XJI6/MWiki3GUDt+sBtPvKRaiJM1xq1d7Obr3M
         1o775es37dYZJhkSdktPQJgCiaLuX8KhpHZ6+9t8pE8ggerwcl/HmlkEw3haEkSHWAkt
         N6Ln9NQGm83sVGk/E097DRN77aeFyfHNSzucZ4DGtgABeAlXhUpbIEQP/Bj7DS8ofqAp
         E8VQ==
X-Gm-Message-State: APjAAAX5SFRkC6AHy5vP/USuFFlwe4FLs4UcsSf/P5qlCKQnmBlz6MhF
        5RMu1myZcR9WILjkk9F5mrIwNpX76217n5Eh5TietKOVXQk=
X-Google-Smtp-Source: APXvYqzNQ+JFlxUV/M6JGM3XTfB7ogZBUOqZOZ0cbnDsfh/4UiK+MQqM3i3UVcimFdOKkZWUTIwvT12oKpfvGKyJU04=
X-Received: by 2002:a50:ec03:: with SMTP id g3mr19959357edr.233.1565328688016;
 Thu, 08 Aug 2019 22:31:28 -0700 (PDT)
MIME-Version: 1.0
From:   Jadian Radiator <gazbonicacid@gmail.com>
Date:   Fri, 9 Aug 2019 00:31:12 -0500
Message-ID: <CAMCV-8avBaFCuYoX8asmoHX_p_dvj_o_WrQrSj_GtNJK0AROuQ@mail.gmail.com>
Subject: Git For Windows' installer can't see my Atom installation.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git For Windows' installer can't see my Atom installation.
I got Atom directly from Atom's official site.
I think git can't see it because of this unfortunate fact.
It doesn't let you choose where to install,
and it installs to your appdata folder.
Any idea what I need to do?
