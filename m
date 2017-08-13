Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2EB20899
	for <e@80x24.org>; Sun, 13 Aug 2017 06:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbdHMGjh (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 02:39:37 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33981 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdHMGjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 02:39:36 -0400
Received: by mail-qt0-f179.google.com with SMTP id s6so39132824qtc.1
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 23:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=/a3Ocv4KKlcap3r5FJrMg+1S8HE2/Mkojy4QhdyLcE0=;
        b=hXQtRNzEZKw1Zck6oBw9lnlY4MsJW9BXCc4jrwshtc9Q7FQmwabmMHfuSvN5/icIXJ
         ifeWbnsRZS+5Ta6XocAc/aGf9NIcTjLPjTmsA9dawAAk5fnpsRr0bYC5W4dAltDjvq2T
         J0Edm0cu4rhToByhYF6MblBpik/7ZMSYCRdSq118buvWbmcNw81UZPyZfDe58ZRxl8fM
         d2x0b8MdUq5GJtJ9SZjrozC5iMpDZnT3NJMO8YNl9LuespV4dOJvOGQa3DV/wtThj12e
         q5L9IOVTOGxjkLD1l0tLNptS4o5xbnwIYQOQb05atO6m9+cS3W5DTsODsx38fE8FH/Rq
         /c/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=/a3Ocv4KKlcap3r5FJrMg+1S8HE2/Mkojy4QhdyLcE0=;
        b=i3U01VBPftK3BLcaHDXDmXk+mspdt8Lj5T4JNWZllfJ04wc+oSB6tJoYqma7eQFMAx
         QUjNl8XU9SnsHUMGZU+vjKJJi859+K6LrlHndwQg/jOzOSMtlw3vN2jmWrjiRsjE9at4
         Mz3KqsiJ+BdZX5OziwB1nbBKoolhEstFYoeo5exRXB/2MkHEBOJyqBzksuikLVIqYydV
         hZOJaNXiWq8Am4YMlD8Bf01o5lPdilPFhUhDWf2omRmzdQB69Yn38CzY6RgLuBFQcAm1
         rXGgbs/0fw2HjyUmzZqQUERgCro1wakFLhU8FK5ehNxCF+8gGPPqxoMnnmrsYDmfO3U2
         kuWQ==
X-Gm-Message-State: AHYfb5iWppnqL1IFzV9MxFxyXj9Z25QFvT/RQTSMoEeJyGP2BejsXND1
        aMrU0omRet9e89vwjKAiAPzMba1zhQ==
X-Received: by 10.237.58.170 with SMTP id o39mr27680063qte.301.1502606376076;
 Sat, 12 Aug 2017 23:39:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.32.165 with HTTP; Sat, 12 Aug 2017 23:39:35 -0700 (PDT)
In-Reply-To: <CANOKemc32rreg5TVYdxYQ=te1a-wv5PeOPwGfX3Sye0gPQPC=Q@mail.gmail.com>
References: <CANOKeme4j9fHuQoQY3MQeoNuietjez8m1wPkAO=1eSDtHG3J9w@mail.gmail.com>
 <87shgyh2a3.fsf@linux-m68k.org> <CANOKemc32rreg5TVYdxYQ=te1a-wv5PeOPwGfX3Sye0gPQPC=Q@mail.gmail.com>
From:   Davide Cavallari <davide.cavallari@gmail.com>
Date:   Sun, 13 Aug 2017 08:39:35 +0200
Message-ID: <CANOKemdSA0OgaLosQ6ez=YPGJWOCCax6qQ5s=XSv1DQ4DwuMUw@mail.gmail.com>
Subject: Re: git-describe --contains
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Andreas and Nicholas, I'll check it out.
