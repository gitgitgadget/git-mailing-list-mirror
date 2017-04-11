Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C4920970
	for <e@80x24.org>; Tue, 11 Apr 2017 21:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbdDKVfU (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 17:35:20 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36059 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752252AbdDKVfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 17:35:18 -0400
Received: by mail-qt0-f177.google.com with SMTP id v3so8793042qtd.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=YKCkaFHubMAnLsp2KczaxEg2D01xB/OVaaKm9/bWPzE=;
        b=JgJv2S1qdtV/hPYAWQv2/YmB8zVtRRvvAQhewvuSsD/QBn/vYaRzrscHBVxYitAdoF
         70Lz/nwqTF7nHrQ8E2OLYHsUueLFb+H26RbKRzAsEpf2N5W64p+q+lDiaX9MZhk0dra/
         ddvNj2di1nuHzThKRXnkPEN+5ypU/zHd98l4BzeijA5cCp4jXG/d3kFxL610hmK85v98
         /f+CXV6SH3ENYTTgXhXZAwRrYYfYWl1ZSv+eOcmCeDsTK1jtYyE/u/6PtNfrBSN6GYvy
         5SpjY0KQe88VYwckr/iKuN9GZp2c3a8gncbR8Eh6yyxXnqjqW8dgz+zw6/3zHjgIvfqV
         euQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=YKCkaFHubMAnLsp2KczaxEg2D01xB/OVaaKm9/bWPzE=;
        b=KPl6E8/Bd9Mt8DaNIgj/6FszlFtDKkA14Cbb4aSuZGTEnjdFkvU5FfnQWQLpKNqYCO
         UTmBA/6hnxlfI0YEpn4d4PQOiK0Y3H5VeHZoR8TWiH+bAQDRGz/+j8TDPdX8sik3pQvx
         V7QdWQh7SOOrELbrHsAQ7azUYZibQ19iGSVpwrFvja4hk6w8w2EXrQDF2Dr2sm4VjwlP
         +o0jT3I3e/JT5MnJUt48g6hgRP3HiKI7f9aCT7P2n2m3AeOOWO4yMf8n/rAUs2akCf6x
         RERhU+G91sokJbEOOhYqxG+GJJlglsNQyTNYWfx+q+Vc4F30JhM9DytCOK5w6sQHPqXY
         x/gQ==
X-Gm-Message-State: AFeK/H2s77c/1cvPuMN9bePKyy12f9TP0xRmMZGrMNbsyPXvnfKm+w3oORfqkzQEZnVs9pnLF4H0BEBWkr9xBg==
X-Received: by 10.200.34.212 with SMTP id g20mr61965958qta.97.1491946517886;
 Tue, 11 Apr 2017 14:35:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.32.164 with HTTP; Tue, 11 Apr 2017 14:35:17 -0700 (PDT)
In-Reply-To: <20170410182209.GA18358@dcvr>
References: <CAG_DJYk3D=sPm6rhGRD_wF4dnJqSU_M+c=NWP4Q5ExBap_-kPw@mail.gmail.com>
 <20170410182209.GA18358@dcvr>
From:   Julian Goacher <julian.goacher@gmail.com>
Date:   Tue, 11 Apr 2017 22:35:17 +0100
Message-ID: <CAG_DJY=3Q1hcGnD72hwhdHxVReD4g7JZou=cm32_WECoJf+5nA@mail.gmail.com>
Subject: Re: Modifying a bare repo directly
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the replies; is there anything that needs to be known about
concurrent updates on a repo when using plumbing commands?

On 10 April 2017 at 19:22, Eric Wong <e@80x24.org> wrote:
> Julian Goacher <julian.goacher@gmail.com> wrote:
>> Is it possible to modify a bare repo directly? e.g. is it possible to
>> insert a file into a bare repo without first cloning a non-bare copy?
>> I'm thinking along the lines of a command or sequence of commands that
>> modifies the file index and then copies the file blob into /objects,
>> but in a situation where the new file exists separately from the
>> target repo.
>
> Yes.  You can use the commands =C3=86var and Jeff talked about as
> (those are probably the easiest).  "git fast-import" is also
> great to avoid using an index entirely; it can be much faster
> for mass modifications.
