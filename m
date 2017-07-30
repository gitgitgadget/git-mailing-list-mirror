Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 753F32089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbdG3LDW (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:03:22 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:38456 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3LDV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:03:21 -0400
Received: by mail-pg0-f43.google.com with SMTP id k190so62061021pgk.5
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=T4NFFy0tP0slaOV8EopD+yApnBnDHkcYMjncw8/P+4k=;
        b=oVLvdT66lmq7L40Ce2pWGtAzx5UzjcbWiwBXnXqTNNubg+R7y0VMmAkKud2N1WkvWp
         4RfKchglF0SX6Vwf4fTJZwh+sGVTMaae3sluin5n+cWairqtrCuZb6Ho1G897QC+1TQg
         EA9Tuavkw/iA6Cb36baNdx4XSBjt3haI6m12zoEe8Ll7HbKChfIO9L9BPHc4JIRa6Hid
         hghxRx1tFxu2ZPN45ZIJ+bDpHgA1f+swNjJS02jIKuMwV332Wgcs7QAsYzgMu0LkGiXX
         vTyqBzSbRzvEFPd7auAMU0/MXpCIgSbafQtIngriG7on0R/0JTiJXX99ToqbGwdOV27H
         9ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=T4NFFy0tP0slaOV8EopD+yApnBnDHkcYMjncw8/P+4k=;
        b=IP7O7dYlh+Z8PzbFZ1FiYmq/l7owWxjCKKAx4GxOQM3FsXDnslAb31bM0bfUh+xoey
         Ztq1BhGlQ6JJ2gfSWzgGVoHj+/ysmYvW1zXPpsfL+e/5xDAQxKe9nHc8AaQd61wf/aWM
         wJSh3nmaOn/vPNzkIMr0qVReaF/npc3aAbviiq4sF350aLAAfLrNmMGoy48TAfBVvrtT
         56GcRl40XWHc+RFEmhX22vJwr9+L0mTAn07ZjflEhDTKy+QkwJ9YEfJdtjLn60XwTTxw
         bV4wkGFvAITgc6WRdpS65J90tqR58XJTKiGTCJ9p58eYktOynYCEAr8i03Fjs4frq1No
         MeMg==
X-Gm-Message-State: AIVw113cX66IadeJQTNpIz0p4HbxVYRoqr8bZ3rpOSGOqlyMbAduACbd
        w6C6kyz7zqqQFw==
X-Received: by 10.98.1.19 with SMTP id 19mr12315813pfb.234.1501412601223;
        Sun, 30 Jul 2017 04:03:21 -0700 (PDT)
Received: from unique-pc ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.googlemail.com with ESMTPSA id h3sm47377718pfj.72.2017.07.30.04.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jul 2017 04:03:20 -0700 (PDT)
Message-ID: <1501412630.10533.5.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
In-Reply-To: <1501411669.10533.2.camel@gmail.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
         <20170725212110.GG13924@aiede.mtv.corp.google.com>
         <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
         <1501296270.2112.2.camel@gmail.com>
         <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
         <1501330390.2001.1.camel@gmail.com>
         <xmqqy3r7jkbb.fsf@gitster.mtv.corp.google.com>
         <1501411669.10533.2.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 30 Jul 2017 16:33:50 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-07-30 at 16:17 +0530, Kaartic Sivaraam wrote:
> On Sat, 2017-07-29 at 09:10 -0700, Junio C Hamano wrote:
> > We perhaps need to somehow make sure new users won't be led to the
> > misunderstanding.  Improving our documentation is a good first step.
> 
> That's something I could help with.
> 
I seem to be stuck a little with this. I'm not sure which other sub-
commands other than log and commit have similar behaviour as I'm aware
of "why" they behave that way. I tried a little but thought it was
better ask this one.

What could be the source of this issue? (I guess this may help identify
the possible commands if the source is common.)

Which documentation(s) could be candidates for the suggested change?
How about "Documentation/git.txt"?

-- 
Kaartic
