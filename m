Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1160F1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeCXABm (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:01:42 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36555 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeCXABl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:01:41 -0400
Received: by mail-lf0-f48.google.com with SMTP id z143-v6so20628410lff.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZY7YyEnbpNdwFSO0xcYyZL/1T6ni7On7V0zs3p8sWEk=;
        b=QfOq4l7noJ0C+dPDndF2cNk8OJ512EaB6qX8gbnIFLHpzFWaAmcE2ryJHXPk1Q5j0J
         kV5KtZZVV6qtT4G/EUCtKrmHQLrcJd74HGZnqlOugCICQzzyknuWXng2FmbhP9X7Mo8r
         CUSTR8SCLZal0cXvqitItN2ZSkClvKX9DJIxPblcamaJVuhpTDOw6ftrEC40V7oQoBrG
         5rhlSKUARK/mducahn9r7IpDIVMTjRzTfx25R7/PcY7G4LXiO7K67n5+QGZjV9MZUQh+
         yEsrz0wK/TvbR8Ome/USDnkKTgX81cuSwSRFSp8DkQ/Qp2l7OBYE3gwPR+MMBLY6ci3j
         s4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZY7YyEnbpNdwFSO0xcYyZL/1T6ni7On7V0zs3p8sWEk=;
        b=tw2sc1MlLJoDmzyWj258OYWTurnzL4/VDyReWxCylrqdqi+qygpgrRLnA+9eDiSi+N
         oignJHvaARGTJuNVNxuhnwAKTzctD0dUK1csujTwd5Fjet3kKFXqkvxUskHxwMNv6Jg3
         ErjOnPd1eUZOMI6M1kiVIQkrrR27+h0uwkXtNEPVflkiO1h0ILxTmBrzu22NvA60RvNz
         EdNdMCEATQvZxN/nlhHxAgZlubaHA4rTMA6cv0RfFDLUCcQCJZDY8OF4Q1uYZJNROihs
         0/lUiAivHtiynuDfB0C9n6QjOxcEH2IEAcrOg0caixV2HdM3juR3bjjBIQdGyy1qo9Y7
         pH3Q==
X-Gm-Message-State: AElRT7HmztAOauQFN/2qZ7eDr/WsGtS6CXDDzVCXorFalbV7FmzB8KEK
        1bDfheLFbGYRunW4m/jQiQ8jr7BDDp3VrHVSf5Nuww==
X-Google-Smtp-Source: AG47ELugXpUHkeGE9fC7lNrsJ63S6JN06eqZLOsBaNme3I7eV+oHrQEF+ab1qODBx6i5sxY1I5fB4NSBnmRB7VZCyZc=
X-Received: by 2002:a19:ef08:: with SMTP id n8-v6mr19555058lfh.1.1521849700061;
 Fri, 23 Mar 2018 17:01:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 17:01:19
 -0700 (PDT)
In-Reply-To: <xmqq370qgzod.fsf@gitster-ct.c.googlers.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
 <e893a9d550f4d09baf0d21adedca841b96feae0d.1521839546.git.wink@saville.com>
 <xmqqpo3uh26k.fsf@gitster-ct.c.googlers.com> <CAKk8israKrrF4PBH4csLQDyrQXwap0oZ3FkihswR1DUf8nqrxQ@mail.gmail.com>
 <xmqq370qgzod.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 17:01:19 -0700
Message-ID: <CAKk8ispE3o6XA=1oZ+CtuLrZPB8cuCpC--ZPM9ifUja=aPJufw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 3/8] Indent function git_rebase__interactive
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I actually do not care if line-wrapping is done; it is perfectly
> fine to leave it for future clean-up and leave it outside the scope
> of this series.  If you are going to do as a part of the series,
> yes, I do prefer you limit yourself to those lines that are involved
> in the series in some other way.

Then lets leave the long lines alone for this series.
