Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79ACA1F667
	for <e@80x24.org>; Mon, 14 Aug 2017 05:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbdHNFLt (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 01:11:49 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36321 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdHNFLs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 01:11:48 -0400
Received: by mail-wm0-f51.google.com with SMTP id t201so29418002wmt.1
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/kfSXxYOCNRc6B/nJ9B7tXgbMXslyxulDq3BE1+zvI=;
        b=mWT42y2DiceY4jVhOAGKKysxrmwbCqWJSy032j/T2XfUIojGcsPK2vQF7jVQo5tOXX
         qDT0GaXFF61aIHzaIWyD0hnY/DDItbf60DgIqzIIXkTn9ssEs6RdsNoRCqcklLY1Q6yq
         A42oFORhwNlmM7t5s2JrGdB1i0e1v4vOLit2WL5WHEhmsOv64/KB8EgCu5bh1IaoylF+
         3FrHSqM7BF9jC+wTSCiLuKI2Em5nQfI/QG7CUx1F5NMjt0i7nuSohqR7dWrFzBASniR0
         v6PHq+88fHGX+n3nzI9FT4HSJ+cysz034i58Jy2Mq5rfcPr3l1TdjJRiZjAvT1igjQd3
         FVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b/kfSXxYOCNRc6B/nJ9B7tXgbMXslyxulDq3BE1+zvI=;
        b=EBZGlrigGwhnAFmOSief7gZo34RHH0uKBYgi+I7689AkAZZh0w9EYayy4DpBUGLj/d
         gAL3vVcx9UfO5sT2NuEMt+IGv2JotqR001jD0akmfHMMfgJJajWDtemudZX+zT0aLNMW
         N6gjoRQ0wRaMJAbIAIswyPHLXNv4LtDK7yyQLk4/3nhYObvV0nsMoWrsbVA3YageLS35
         SZhV7NikE6fw7oEC/J9GE5in0gvXvkYjL+xYL9jHDL8/sD8XLXE9T+vKxqIkksfOAJy1
         U/zJhCxyoVW0hoo7H3xhiElAebW1aqiu9jJExS66hNHA/cw6a9m9HYjEyOaCyrBv3Pb0
         RY7A==
X-Gm-Message-State: AHYfb5gZKL3yJ/VSkGsBbIHDNpEyeu1nzYl9Bb7w3nKpul/17NlLs7+W
        hMIZRR5WrLHgzsY6IfqekA==
X-Received: by 10.28.18.196 with SMTP id 187mr3036612wms.1.1502687507485;
        Sun, 13 Aug 2017 22:11:47 -0700 (PDT)
Received: from [192.168.1.37] (114.red-83-60-25.dynamicip.rima-tde.net. [83.60.25.114])
        by smtp.gmail.com with ESMTPSA id y203sm3841634wmc.27.2017.08.13.22.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Aug 2017 22:11:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: gitk -m ?
From:   =?utf-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
In-Reply-To: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
Date:   Mon, 14 Aug 2017 07:11:44 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7F03EAEF-DFDA-4CD0-86A1-A06C775A895B@madiva.com>
References: <6ef11677ca184e78a545452ffffe55a1@UUSALE0M.utcmail.com>
To:     "Burkhardt, Glenn B UTAS" <Glenn.Burkhardt@utas.utc.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure what you are wanting to achieve, but please make sure neither =
`gitk
PATHSPEC` nor `gitk --all PATHSPEC` are presenting you enough =
information.

> On 3 Aug 2017, at 19:37, Burkhardt, Glenn B UTAS =
<Glenn.Burkhardt@utas.utc.com> wrote:
>=20
> I've been looking in 'gitk' for an option that does what 'git log -m' =
does.  Did I miss something?  In particular, I'd like to get information =
about a file that's currently available with "git log -m --all =
--follow", but presented in 'gitk'.  If it's not there, please consider =
this a feature request.
>=20
> Thanks.

