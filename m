Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4971D1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbdLTQkI (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:40:08 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:44147 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdLTQkH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:40:07 -0500
Received: by mail-ua0-f171.google.com with SMTP id j14so15671493uag.11
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 08:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=uAx/RQaIr/YNF6s7JgA2SCsvmkLPJR9d0KufEvOUL3g=;
        b=IvCDtPeILD0rWg1unfZtqr5+gbDhfFR1kulWnLZyoAEO3pcntGXuyFWnql8Xgm4scf
         ielyVvNVmfdUuvKojkb9SP/pKhF9/026Jz/Jk+TIaHsZm49av/aEVfZuPQGcHZc1rXo9
         tMp2aayIgFrfafaVdpJ6jySuRCBiBI1KuEL+4bhQB7jpwNn4EDtI6P/zpGbZlhEadrLE
         hh3eaDytzS2eJJkltJAxAbhxfap78oCoJILTGp+QD7IDeJTv6zZR4zpqGqZdQr2aCnsT
         lgNgmW+z2zelR6Dfe8hXcZwp4t7FGZ0CDn6aD+p0lZPVRwuGo/E1qcN1xgEbaEaNZ5+f
         KYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uAx/RQaIr/YNF6s7JgA2SCsvmkLPJR9d0KufEvOUL3g=;
        b=f+wBzamkxDcXISVvhss30LaivaLecmZoJw/hvPUX8WN5dv21dnJoLNpULnW6/PSKJb
         sB/3AZP3R35LAJ5jfMof+hOK5hucUm4b2KEHm98tAgPVwglkL258pQOxiYgIaCYR96q5
         WZQuYgGCEHWknHLZPJBbafEmFRc4PiM1Lx71NMz5e9SEUPkArEvKPOlE5EqcF5WPxq2s
         oMnzD9H6ZXX01UDmD3e5GqK3bNDva42jiIbiyrn8pW7YJ8EBOvQ8aa+UiJiwNcCGRIrw
         0ivulkoUVZbzzv7e7G0E27Jl5M/VkZzBCG4n0FkUgLbGKDFV16w5oRQtzvVsCl5AiZhQ
         yYjg==
X-Gm-Message-State: AKGB3mIMm86PuoPwPM3PVh4kLCP/cCFhOtf4weZg4Ya/uwU+AnrvviES
        hk52+4s7P5Sy1X/ipUtHeNDSA/tjsB0SSQUBC5JE3BA6
X-Google-Smtp-Source: ACJfBoursEtsxR2U/E5fwodatc3SargFm8XrWaVnK3v0M3ZIeNsKZA4cA7dHxcT0qD7SjhiNwFiqG3iGzeaGocVb1JI=
X-Received: by 10.176.1.134 with SMTP id 6mr7828513ual.180.1513788006269; Wed,
 20 Dec 2017 08:40:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.112.3 with HTTP; Wed, 20 Dec 2017 08:40:05 -0800 (PST)
From:   Cristian Achim <brancoliticus@gmail.com>
Date:   Wed, 20 Dec 2017 18:40:05 +0200
Message-ID: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
Subject: Usability outrage as far as I am concerned
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All I will do is paste the stackoverflow question below. It covers the
commands I made in chronological order and the way I would have
expected git to behave differently.

So I did

git pull home_subfolder

while in usb_subfolder. Can't remember the immediate output, but it
included a part about two repos having no commits in common. Would
have been wiser for git to just error out with a message that in one
of the folders there is not git repository.

At all times

git status

in home_subfolder gives

branch master
Working directory clean

This is so stupid considering the circumstances.

Doing again

git pull home_subfolder

at all times from usb_folder now returns U in front of 2 files in
home_folder and A in front of another file and then says

Pull is not possible because you have unmerged files

Had the bright idea to do

git clone home_subfolder

from the usb_subfolder because of my worries going away when

git status

in home_subfolder conforted me that there must be nothing bad about
the situation. Therefore I suspect that now doing

git pull usb_subfolder

from home_subfolder will do the same broken result as above.

I do not want to resolve merge conflicts because git doesn't error out
with a sane message of the situation when it should. I just want to
get the home_subfolder and usb_subfolder repositories state to where
it was before my breakage generating git pull and git clone commands.

Ubuntu 14.04 64 bit, git 1.9.1.

Thank you for your time.
