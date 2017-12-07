Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F0320954
	for <e@80x24.org>; Thu,  7 Dec 2017 16:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbdLGQQR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 11:16:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:44996 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdLGQQP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 11:16:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id t8so13980258wmc.3
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 08:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PZZRYCXIhZbhK1M9SOkjdC9T8sQ2vw6EWBizNt1Kywk=;
        b=qME4w2QM41C7AulPhfjRXMBHGrkegVa+8rv5xaGaFPNyaHLgRjzhycwh8whmWFM8pj
         UouBItqEFYNpp29thxzpYRys2eOBfI82MO5GkffVi6nZA87Maz5QGa0YafzhEAjdiG0K
         UfzyK34KOrkNg0IQUV301hV7SLEbeL7TkCi//rwrLjR1RmRh/9rkE5uOT4W5WMKN0Tw5
         n2tGm0tM+4+gMVeQMUonPf8HHMyz98JuB7v9i4JWRzgF4GGhUgFJjURradTnnSuOP3Ve
         oGQQLQeh+rKIXZdwJbyHEIb2o+srJCJ9iFSpmy1nKaloV7hmmESebhWsLxg8RQOYBS1z
         NyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PZZRYCXIhZbhK1M9SOkjdC9T8sQ2vw6EWBizNt1Kywk=;
        b=RTBppPo1IlsyE48OKMwXzxC6lGOO8H41Yulet1RuA+7+ZPpcwh/NLVSaGGKkNMyh5S
         WRr/cSnsODX5/lk9QKlHbFiIQf5R6U+dp4JPpLu5bVCe+dBrZTn1hTZAT+3k+uoctLA1
         gvEYfVLz5oQEnc/beGupcdZaQI4gctkki9LMypQCepVPIFdqXy9WM3Rz3oPyg3dRgjC6
         SPbels+omqynmFT0vWw0Fent/pIRWHg/RxP1IsQI3ypRyhoZV3L/Cc5YU18oQiMF6bte
         MZ0WVBjJ+oehilIeaSoRd/QMv1IvJi64LVhWodGsidTv419mKp0qEvcDAPZ3DrSTmNQW
         sB2g==
X-Gm-Message-State: AKGB3mLA/jIeO7u5+oO/i6HmNnKlLMPiMZNibkJYY8gCPmW0NKLobBTp
        Rg+vbG8dSieazG2iC+ZArxQ=
X-Google-Smtp-Source: AGs4zMa1PCqEeDsCQ9mDNPg8GS4TN9yygXsfno0JZbJCRZStjypT7ldQjFU8meLWdrZDo7g+oDEGqQ==
X-Received: by 10.28.5.201 with SMTP id 192mr1559265wmf.142.1512663374725;
        Thu, 07 Dec 2017 08:16:14 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id q74sm6425034wmg.22.2017.12.07.08.16.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 08:16:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com>
Date:   Thu, 7 Dec 2017 17:16:13 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Content-Transfer-Encoding: 7bit
Message-Id: <D17F94FA-702E-4E37-BDA5-94F0FFD5BD01@gmail.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com> <20171207151641.75065-3-lars.schneider@autodesk.com> <xmqqr2s6ee7e.fsf@gitster.mtv.corp.google.com> <FCBDBD58-0593-4FFC-B574-61D67CAF13C6@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Dec 2017, at 16:48, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 07 Dec 2017, at 16:43, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> lars.schneider@autodesk.com writes:
>> ...
> 
> How about this?
> 
> 			fprintf(stderr,
> 				_("hint: Waiting for your editor to close the file..."));
> 			if (is_terminal_dumb())
> 				/*
> 				 * A dumb terminal cannot erase the line later on. Add a
> 				 * newline to separate the hint from subsequent output.
> 				 */
> 				fprintf(stderr, "\n")
> 			else
> 				fprintf(stderr, " ")
> 

I forgot the ";" ... switching between programming languages ;-)

			if (is_terminal_dumb())
				/*
				 * A dumb terminal cannot erase the line later on. Add a
				 * newline to separate the hint from subsequent output.
				 */
				fprintf(stderr, "\n");
			else
				fprintf(stderr, " ");



> Can you squash that if you like it?
> 
> Thanks,
> Lars

