Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0310A1F744
	for <e@80x24.org>; Wed, 20 Jul 2016 12:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbcGTM61 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 08:58:27 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36255 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbcGTM60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 08:58:26 -0400
Received: by mail-wm0-f41.google.com with SMTP id q128so55319984wma.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 05:58:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0tZEa2rJxhnb0wAchCld5SvL+FaYxa4Uvy0cOEOOjQU=;
        b=xCU4gAk6P8PaQlTmL4gzlI2k6cBIX4cBdRv7VUTSfy8NE3rHElRK4bBN8zUp6qi8Hr
         xEGNRrebVdo6CbJ//qbXACsGOJHRzutfB2wubfHTmAs8HutzPXQVarfq8+ytc9nZKIz5
         qQiz+ttSdaMgXhTck+BYugim1I6uv1pxXN7rv1cfiXIzIxu+wIzsCI9+/eBYVSuBbzii
         FbCR+ZFgSwXyeKACskpAAaPCBOSnqX3t1DzHiUKfes9TL6mFKJ8uVM02q7MNXtX3TnUJ
         WS8FHQ+sJX371SDUgjHiJMpMG3fzfo73LwH0T6qxXspz99qbAKwPf1gd1ouu2PHn4duE
         +57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0tZEa2rJxhnb0wAchCld5SvL+FaYxa4Uvy0cOEOOjQU=;
        b=UxjVs7fT09JRPqvdTrp0wWGmvgmSBX0rHS0EMUJbLP3T3wnKl+Mx+nVZwDuyDZC5D0
         L0S3Jmh7+9oZBf9UAal0qTkfMTTMCyhTf9wQvYSgoaI0qjliraphue5B/fF+q/Hj+8sm
         6evRUdumBzIziv6AqfezZjXENES+/arUK4CGofVaAikMi0+7alkD2Y5aYprrQhLSKt2l
         67o+Itm9MRSzGiVoF0w11xkH8NGEHpVHisbz83temsLdMLTrnGoEaGWQdEwkVsHYyoju
         eFN+GtqbJQ5yvoLeGjq9SkCgANHG5tp2x540Joq3imS45cWJoWVTipbQh3JH0INPOHPp
         2+tQ==
X-Gm-Message-State: ALyK8tLPLyGu0Xe5HGwbMykWZva+E3QTGFoiLNbS2kBHv4+T8FxMKk74LsvrvAQqB9ejvEzV9UtG31HyHKN7cQ==
X-Received: by 10.28.167.80 with SMTP id q77mr11847625wme.62.1469019504774;
 Wed, 20 Jul 2016 05:58:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 20 Jul 2016 05:58:24 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 20 Jul 2016 14:58:24 +0200
Message-ID: <CAP8UFD2PjKHkcs-EWzDU6eWF9ar7BzOxRB838iFr6iDAaGnkeA@mail.gmail.com>
Subject: [ANNOUNCE] GitRev News edition 17
To:	git <git@vger.kernel.org>
Cc:	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>, lwn@lwn.net,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Greene <greened@obbligato.org>,
	Ovatta Bianca <ovattabianca@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi everyone,

I'm happy announce that the 17th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/07/20/edition-17/

Thanks a lot to all the contributors and helpers, especially Jakub and
Dscho!

Enjoy,
Christian, Thomas and Nicola.
