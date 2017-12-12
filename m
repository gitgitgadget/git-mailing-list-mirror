Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1261F407
	for <e@80x24.org>; Tue, 12 Dec 2017 10:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdLLKyA (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 05:54:00 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:44614 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbdLLKx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 05:53:59 -0500
Received: by mail-pg0-f44.google.com with SMTP id j9so13143723pgc.11
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6Oulr/k8sVycq1rYXSH+WUAWeu2cVreHqoM5MYKtZlo=;
        b=nvqKqRiZw2kCII4Me2jlr+zvD5pi6eHLSdDy6vJqzt2HZ9SQW1hXc8lHgHT9GFDX7H
         GIOxVrk+r5Z/OUW2FQGPOcmw5DqX1PCb20QSP26SObeQ2z1tiSyhdsItXxzPRKjpfm0y
         G8NusRqXAu+hwdZ268iRp7PGKpdQwOob92AFlyro+5KLo518vEb79JaxwJaM8Tr92jnq
         adGeDTMLdCWEZ/ZR2RbQJ3OvhNm0qGlMMTbJgMjFp2TOXYTQMVmmgPfFMXRXgFFtBzOY
         QGnz0P4DQTTsz83WH0WBaRDXTZEzsm4HwWfeY0/FZWJRrlpGUzJO/87cVI1FhyvmGobj
         4QyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6Oulr/k8sVycq1rYXSH+WUAWeu2cVreHqoM5MYKtZlo=;
        b=eTPUHHbb6tUEsisBpvub0KlplkzyydIV/86UrGKrhJREpEtfuMQ9GeTiV3FiCszF8S
         Q/3rHRPFXj07KB9Wg5XM9CVncTEK1SEQ/d4cOsFLejO88rvVh1VLnN8Zkvdb9vj0aD7O
         aQc5pgSzyZnYBU0iB9wTC4Uq0hgmU/xEPQiORS1IK8GSjHYyqyTkSNZMvNdpoDiZLPKa
         KC3iMJR597sGdQ/5vXtPBDgEHeDwowFkEwiV4EZHqv8G5XPNpgBUjwYCt/aNWVfRZIhu
         d27jrSQkthvlmPmLZt4jSJfikZTEUT/GU+6dRYexCMNvNn3lbOAgFJkiv7JZd230J/L7
         2rKw==
X-Gm-Message-State: AKGB3mL/Go++hbpK/hCajigLHocMdJ2IzeOTIXFcSMYNdGMtn9Bm0Ygg
        Rk3vFXwLJR3sZFfacGmNm+Ywf7ERfda2TeH3+z2Xvsjk
X-Google-Smtp-Source: ACJfBovXHMvs+BNNjKiBhDIbi9JDPhTKob+LOXYvTpzRm7MZrHyjZpx6S6V6TT5B+ZqUa2vnBwZD2NtaPNRaykRTj4o=
X-Received: by 10.84.240.68 with SMTP id h4mr1818784plt.431.1513076038809;
 Tue, 12 Dec 2017 02:53:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.180.194 with HTTP; Tue, 12 Dec 2017 02:53:38 -0800 (PST)
From:   Simon Doodkin <helpmepro1@gmail.com>
Date:   Tue, 12 Dec 2017 12:53:38 +0200
Message-ID: <CANaQPdK4xWek3PhiFZrURBBTgPBwsC3d3watd-cWVNBVZRqZRA@mail.gmail.com>
Subject: feature-request: git "cp" like there is git mv.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

please develop a new feature, git "cp" like there is git mv tomovefile1 tofile2
(to save space).

there is a solution in https://stackoverflow.com/a/44036771/466363
however, it is not single easy command.
