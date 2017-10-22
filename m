Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894321FF72
	for <e@80x24.org>; Sun, 22 Oct 2017 04:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdJVEgS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 00:36:18 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47820 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdJVEgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 00:36:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id r25so9390400pgn.4
        for <git@vger.kernel.org>; Sat, 21 Oct 2017 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=duxut3wTym20BwsxsfyfVFKuGERje3GEJXHIKgbghOQ=;
        b=DuhDWJbaGaWQz9RrfW/3qL+MEmd5N8Oelv6AYSn3HOASvPJDUK349xG/4kqn+hSaPI
         9KlzkmZl9wYoeSyFvG21jF/Om47ZecKumzHlSwDTYDLUru7aFqKfz/fneX2j8LO5lyVU
         3m3sKvlLFJ7Ds+my+2fejcGr8du4eT+LAMp9iaCntSTLxw09sIUK9f6rgVxGP/AXM0j0
         oCSilnWqaUdHeeWXj13Kg3xpwEAovgU+o6BeJOatN/o0U04QektbkysAWcqm6k2w0D8c
         NtIG2heeUP4cr4hwU2SB2ualvKIROP9v08vwxYMMwETFWL0nJ8AAXl/OrcEw66CX79Pr
         7tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=duxut3wTym20BwsxsfyfVFKuGERje3GEJXHIKgbghOQ=;
        b=axO2XpbMyr76eTQiIe+KEbeVGgvvdj2T1zKQS8SidyK0Z4hcC/5N8Ek5Vp+FSKxOgu
         3HPcNA9MV9k4QfhePK3WlZM5G2JKutPmYa3emmt2u24zByLTsBgmLJc7I3+2QgS5pRK/
         gQ3YSphMXTXBn1dnnPQYSSrzyQIPQqPGi8vsdH8AvySJGi8grgDSot4QB+rekSBazDmX
         EOxDUdr/BKGjpYHKcXLCJYaHU42of7bUwxRYRCrWlfZMn/LduLVs4OTZsJ14Pi2Tm77E
         ka1chJCQu2ZwISN+z7INFuXxiyIzjD61Xc4XHDIysIOzMj0XW6I1HGA0dWhpClp7HTOg
         Qz2w==
X-Gm-Message-State: AMCzsaX5z6hqmuYIygjnj4/TFUchobn+qmKmauv5NFTm16Bp/t4vqfHv
        ZZHHMozQvWeWW4vfF0dunX4=
X-Google-Smtp-Source: ABhQp+TL9lID+IuVN+ZC2Rh2Aj39tIYXI+v5C4dOEULxCphEA4wROaHJo/lSVoeU9VafFIkgJgqakQ==
X-Received: by 10.98.71.13 with SMTP id u13mr9341650pfa.302.1508646976435;
        Sat, 21 Oct 2017 21:36:16 -0700 (PDT)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id c22sm7891684pfe.177.2017.10.21.21.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Oct 2017 21:36:15 -0700 (PDT)
Message-ID: <1508646970.2152.2.camel@gmail.com>
Subject: Re: [PATCH 0/3] a small branch API clean-up
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
In-Reply-To: <xmqqtvysg9w8.fsf@gitster.mtv.corp.google.com>
References: <20171013051132.3973-1-gitster@pobox.com>
         <1508555222.2516.11.camel@gmail.com>
         <xmqqtvysg9w8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 22 Oct 2017 10:06:10 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-10-21 at 17:52 +0900, Junio C Hamano wrote:
> 
> Sorry, but I am not sure what you are asking.  
> 
> I was looking at the code, noticed NEEDSWORK comment and worked on
> cleaning things up---you seem to feel that I need a reason, or
> perhaps even your permission, when I try improving the codebase?
> That starts to sound a bit ridiculous.

Nothing like that, sorry. I was thinking that you would "remember" the
fact that I was trying to clean up the NEEDSWORK in the patch series
mentioned before as you have reviewed/commented on it. So, I thought
there would be something my patch series was doing wrong which made you
send another series that cleans up the NEEDSWORK. I just wanted to know
that specific reason (the reason which made you send a series cleaning
up the NEEDSWORK when you saw another series doing the same thing)?

Of course that's assuming that you remembered my series cleaning up the
NEEDSWORK, in the first place. If that's not the case then there's no
reason you could give :-)

-- 
Kaartic
