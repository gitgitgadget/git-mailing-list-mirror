Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA976201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbdKPAaq (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:30:46 -0500
Received: from mail-yw0-f172.google.com ([209.85.161.172]:44341 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbdKPAao (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:30:44 -0500
Received: by mail-yw0-f172.google.com with SMTP id k191so9601721ywe.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 16:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=burkitt-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=vO+rWLn7uuxi2u1yKoQ8l1qlJm+Zh3NXYAA6aeZmT7k=;
        b=MV9HxRjw7cda2HmW+XbWkt5KyOrjBgJA3G+FY8ta3YgXRaIUva69/ZLt+INDzWAsLb
         ojJGQdLRdcAAFewQw0N2Dwj8EOr6GPN+Lsyq4z1fvye3NmYJToOyx2ULOe1zizwGAYxY
         XDcmOHorCpS4ELEe6Qm9q/YVifseGbij/z0tZEVtpw35Ael/r4IGRA0IdpZT/lqLCMka
         7txEkTwKjq+FGJNgMv2XLaRAusUbFpc3rtbd96DoUV5FyAiVHfOSR5n6f5gU9we88mMM
         616zBtDXBMlCLjp0UoMBz2VncI2p7XefftPmkOEE7RIY78kuKqhnbNMEWoKhZb/4LFkL
         Z52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vO+rWLn7uuxi2u1yKoQ8l1qlJm+Zh3NXYAA6aeZmT7k=;
        b=tx+vw2qo42tVTH2htEITaUeHOmeLJibAEgHEAWDTRw8imyQWPAMw26pWo1LJYWSsVL
         u+SoAQw/KeUchsQR6WC9NKKBVVGqVIrmVCp0sESwbrQGv6OKWeLNKmIdIu11/HC/kwDy
         PNc2z3oVbWpkC5XdWpHQzJvlpXGOMeeg7iNX9Q0+/0pCPHumyGZ0QWqX4pntOXBM5h7B
         aaTxUfjl93jOREYsLiCTJxOfyd+Qhpd6+ZSOfVbVOKx+STAik5iwpJSkXK43CoV9fVVA
         EPdFjrtUHKQdkPD1qXY3+JEPr/fKcispfP2jvybBK6ksjhLNAmFVs6D51jKkuHIxVEPP
         gQjQ==
X-Gm-Message-State: AJaThX7Ao5DNgwbYNT8CyoB/5XMFT2SGxuNYUbz3eNTAxzE+MZ3xtUCM
        mXrT19fznpJClY1doN4MU/LIbnZRfON/aJ7sZEgfko7d2Qw=
X-Google-Smtp-Source: AGs4zMaYrZiskC9m6kx/RC9GQMboOWnfPeVkQSNd0dUtWcZR22h9bcw2/K/JJ7A0+Je+Go7iXEj3S7OeQe+ndyAZaXI=
X-Received: by 10.129.98.213 with SMTP id w204mr12113202ywb.395.1510792244038;
 Wed, 15 Nov 2017 16:30:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.72.70 with HTTP; Wed, 15 Nov 2017 16:30:23 -0800 (PST)
From:   Frank Burkitt <fburkitt@burkitt.com>
Date:   Wed, 15 Nov 2017 17:30:23 -0700
Message-ID: <CAHY2EeuCUh3bzdZxtmvC3H=j=QchLgvkuHaW_KWcVsD=-fJUFw@mail.gmail.com>
Subject: Git on Mac - Segmentation fault:11
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am using Git on a Macbook pro with MacOS High Sierra version 10.13.1
(17B48).  I have been using it in a virtualenv with python 3.  I have
begun to get "Segmentation fault: 11" with every git command.  I have
been searching for a reason why this is occurring but have not been
able to find a solution.  I have reinstalled the operating system,
uninstalled and reinstalled Git, and a variety of other attempts at
finding a solution.  Is this a know issue? Any suggestions would be
appreciated.
