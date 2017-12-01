Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AB020954
	for <e@80x24.org>; Fri,  1 Dec 2017 13:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbdLAN4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 08:56:41 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:37160 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdLAN4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 08:56:40 -0500
Received: by mail-wr0-f180.google.com with SMTP id k61so10192929wrc.4
        for <git@vger.kernel.org>; Fri, 01 Dec 2017 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Iom05+RvSH0NXeQ6szr5EuwT+OXJXRDTv0M7MIsj1K0=;
        b=XTgehUt+B2pxbd8eROg/31WdtH57/Ittyai8Y4+sokDaMQeQ6AYqDQ5SuNJPz49M4v
         Z3T+kYyQCCozgJ11QECWljXUSEcvSlTQaeFo/yQTMmyXmoHSTFxdHi1WuzmdIJLjitRn
         JEBsGDgsUCPv4bDvyuoGl9CmAguSGgcy4SUjbcDKbI+sy70NWuCR+qc/Yprh5Km5NaQe
         O2Qj4npq+mFcYYY+VQNZ5KVevC+heCUVMLFZ6nZ8Ej3MQqCBMPiNX5/eLHLqOWpEoKvx
         4j7PZHJmFitycYR0vTOHAEhADoVebyWejieu9VOOy1QMPjm1DwWGu3JXCLrly72f45Kn
         1bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Iom05+RvSH0NXeQ6szr5EuwT+OXJXRDTv0M7MIsj1K0=;
        b=uYIkFAXqeN7etxdWcujDe5bbkJsk4E+J+cIu5Q0aJbzpT3GFPaxs0p83Pb2xhqd+AX
         TCIsE1vhtnqZtnJQk4vrSeie+UHSL76pwLplsaUmxP3+bHsczbGyBilEILwCQZXz1tg5
         KRvbqQEFxyV00Ll6gpuTOgKoIkhj7EispM+q6uJyp7WBkSPO7hBeNABcwpQ/TRabEMdw
         TaNacC1g85hoYsthcvYiUQf28024jMAdXFqbRsMMJvXEkhABZNkvmC3QlaBFKPr5neuo
         1TAt/LQnG1x6+gENGaR4UljLc1gLD1O8SGCYUJzOZvkZU4cgACfs8XbklIekSVemYvXv
         g6Ow==
X-Gm-Message-State: AJaThX46IXtWYkQqstJzUBzJeODKlJFJCacf10kCi/SRYz8LTe1itzHG
        6Xv0UzXYTTF8ZNYruHss9ie2kC25
X-Google-Smtp-Source: AGs4zMaM4o6+sS1C9LWA5oSDwuznOljUEOyPZh8OT4+Try5dunpGEugX//gtGzQnL4oTQ8kSCrw6XQ==
X-Received: by 10.223.180.66 with SMTP id v2mr5352942wrd.93.1512136599420;
        Fri, 01 Dec 2017 05:56:39 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p42sm7816509wrb.28.2017.12.01.05.56.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Dec 2017 05:56:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Nov 2017, #08; Tue, 28)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 1 Dec 2017 14:56:37 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <28BC5100-F5FA-432E-8A40-E5AC7E49E3E6@gmail.com>
References: <xmqq1skh6fyz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Nov 2017, at 02:17, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> * jc/editor-waiting-message (2017-11-17) 1 commit
> - launch_editor(): indicate that Git waits for user input
>=20
> Git shows a message to tell the user that it is waiting for the
> user to finish editing when spawning an editor, in case the editor
> opens to a hidden window or somewhere obscure and the user gets
> lost.
>=20
> Will merge to 'next'.


Please take a look at v4 before you merge to 'next':
=
https://public-inbox.org/git/20171129143752.60553-1-lars.schneider@autodes=
k.com/

Thanks,
Lars

