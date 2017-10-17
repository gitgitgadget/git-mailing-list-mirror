Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0553620446
	for <e@80x24.org>; Tue, 17 Oct 2017 23:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbdJQXu6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 19:50:58 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:46934 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbdJQXu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 19:50:58 -0400
Received: by mail-qt0-f177.google.com with SMTP id 1so7324564qtn.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=qBCrSox5uTx+TiRoNWXd75pjIgppzszgmo4ggdXiSTI=;
        b=SBJ4THVz8X4+xdbmnFFLy4ppidcp79asJJ7q5XOzpe3In+1jaBXYAsQb1xOfi7GSUr
         mkpfy0wvCYGTfFHEaTsiissGyxvgO0kc3NGbKSv6W/item7NoBtG0YmfPXB9kFLnuKsO
         CVGuBQJ31lyd7/G3hRkoofgSD3Ug7myeItg/0KFXOr+M1GiJ+jZZ1CexDLDDuVZG2jBB
         ZNAKduoUYAPPDCKomhPTN/M56fuEAXevW7wZoAPP6WUG3ha92rOWg/Z78qV8k29Oq/bB
         SrEmVGmwsOhPxJgS9kmNnaY90m+nyB811J3P5eWnpJ66KNE/+OhDxKZ/NkwkYiukLjoI
         4TLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=qBCrSox5uTx+TiRoNWXd75pjIgppzszgmo4ggdXiSTI=;
        b=Vbu6b1m+GXNCkemfF1a7LS5hMxS+s3GGzKq+aOa03GNSC60PvPdJD7EoxY2QGqqoTo
         P22V9XtqOBEWu71qbNZiDFkzv2SQNc6GEKSbqTKP1VJ0xQvlsM8HyaAlwOxwilMr79bF
         JpLW8AGM6hLridHq9BBTOkTH2/EIFNuHMTD9tDs2GNsrsAo1ijUkVigMGqd00NERZ3do
         3rA8vrRHqe7nYu9wND+eNWJ4meTLhVnTEdB8N53cpO2sNcCVqk2makElnNYXhd2hpt3L
         w12hUMelwNP5ESyBxoZX1g/Kf/OMdNTojfHLfV8c58lyM6cm/v1KLOxjXLcwwoCT3vJO
         gV5w==
X-Gm-Message-State: AMCzsaX1EpQs3z7TEPI/MrF4vNnZJTbvQOcdiDq1fLDd6Zrw5ZKH0zfQ
        9ip/DSyhfqSbjO4WcySdGNqnWb20WNGYw+ee5hiX
X-Google-Smtp-Source: ABhQp+TRYZOgCjlv0DHOQKyV/piYJoOG1HGD/5KPVIJgSu92ZdyDBI/cWm2w8D8PYetR/rmbJGSIoHVmZohoQ4sYOpU=
X-Received: by 10.129.146.73 with SMTP id j70mr317025ywg.148.1508284257313;
 Tue, 17 Oct 2017 16:50:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.242.195 with HTTP; Tue, 17 Oct 2017 16:50:36 -0700 (PDT)
In-Reply-To: <CACjmu29CV_0HgmNaBmNLn-J4ZdUx+jRgweNSibBsB2SOZBWWEg@mail.gmail.com>
References: <CACjmu29CV_0HgmNaBmNLn-J4ZdUx+jRgweNSibBsB2SOZBWWEg@mail.gmail.com>
From:   Gilberto Stankiewicz <kiewic@gmail.com>
Date:   Tue, 17 Oct 2017 16:50:36 -0700
Message-ID: <CACjmu28WBUZMyivR-uvttMURSEtVuCUaYHdtT0mpv4LAffOd5g@mail.gmail.com>
Subject: Fwd: Has git-gui repo moved from location?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am trying to clone git://repo.or.cz/git-gui.git as described at
https://github.com/git/git/blob/master/Documentation/SubmittingPatches
but it seems the repo does not exist.

Has the repo changed from location?

Thank you,
Gilberto
