Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F97D1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 17:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdFGRAF (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 13:00:05 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38874 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdFGRAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 13:00:04 -0400
Received: by mail-it0-f51.google.com with SMTP id r63so9401282itc.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=kDqVn1NUxYM6DUIQ5vy81eu/mFmLqu/SgmY0a7iNTpk=;
        b=Thrim3rePwKsITS1j72vNHHRbS5y1xgpy8F4LQ4540CBsop9WeSDgG6O0B1/75AHCz
         gukNTvf13cxaN1C/5cZFH8ccpi60gkTkVBRqcNNTk1XqaYiNtSP9QUekG1qCbNRlJzS5
         2kys4xG/J1y3MHBn/GdTw4M1B13qo145XkBFhDQ2QPO4RSxtDJKZY7iV5bt6XmzvRHvc
         dc83Qy9XqVvFa7atTedh4zWFEnWVMVupJLSCSo/jiFXRfISTQPkXpdvwKZYQgTCp0+9T
         D0BeoLP/pZRZhaK3t/jNnYB7r5pOEHwMLAR/1aIbX7qBJYgHt4pirL7jGQUtB+pW0wBN
         y9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=kDqVn1NUxYM6DUIQ5vy81eu/mFmLqu/SgmY0a7iNTpk=;
        b=nwCFiu7UN2VnRAKs9srh6ehRUmNdW25bcB+wWrCEKNqydM4X/l6wMdf+VQUGPFOmB3
         MJ0oPdy/0t5uFzglJWky6/ku3iTB7b67mDm94cZ8dBynxy7pIvkib+fGIkZkwM0Q8aQF
         zbMp0yxlX/NlUmp8Ktezu76vmbCRDNrQLstClNsJyLzVR+JNUF9+ALMVsfKddtjMXiJC
         vNyh60r1Y1vlT7SXwDihdBitJwb96HBVx76Y972RMYwja1Og62U6TaVg8dxTCviI20n/
         hSKgfbrXA6TsXkeaxd5hKYwygYzd25pYUjy/LHjEqgpqCyw7pCgSI9wLpescV3jOWhzb
         SjDw==
X-Gm-Message-State: AODbwcCapcMu4c9k/gwArUx1uChAOmH+o+Wg+OMRrlzk/ZtcpKyV8wTC
        Tp04fI1QmVB+xXkc+cS1AoItPxGmUhbPGmk=
X-Received: by 10.36.175.8 with SMTP id t8mr792894ite.87.1496854802928; Wed,
 07 Jun 2017 10:00:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.135.7 with HTTP; Wed, 7 Jun 2017 10:00:02 -0700 (PDT)
In-Reply-To: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
References: <CAKvHMgTBmdKrz-i9-uBFtx08pegjuY2=jKQE21pi=MabTuicrw@mail.gmail.com>
From:   Liam Breck <liam@networkimprov.net>
Date:   Wed, 7 Jun 2017 10:00:02 -0700
X-Google-Sender-Auth: T8Jma9aa_IRL11kgOIpOPDweQ74
Message-ID: <CAKvHMgSgOyDhffPm=-QEQNzoCoPtmWbV_R7JDtBFTHQ-sL3Wug@mail.gmail.com>
Subject: Re: send-email: Net::SMTP::SSL failure
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 10:47 PM, Liam Breck <liam@networkimprov.net> wrote:
>
> This is configured to send via a gmail account
> git send-email --to-cover --cc-cover <patch-list>
>
> I See
> Attempt to reload IO/Socket/SSL.pm aborted.
> Compilation failed in require at
> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
> BEGIN failed--compilation aborted at
> /usr/share/perl5/vendor_perl/Net/SMTP/SSL.pm line 6.
> Compilation failed in require at /usr/lib/git-core/git-send-email line 1386.
> fatal: 'send-email' appears to be a git command, but we were not
> able to execute it. Maybe git-send-email is broken?
>
> Net/SMTP/SSL.pm v1.04
>
> perl v5.26.0
>
> Seen in git 2.11.1, 2.12.2, 2.13.0, 2.13.1 on Arch Linux

Also fails with perl 5.24.1 & 5.24.0

Last working config was git 2.9.3 on perl 5.24.1

The relevant code from git-send-email is:

            require Net::SMTP;
            $smtp_domain ||= maildomain();
            $smtp_server_port ||= 25;
            $smtp ||= Net::SMTP->new($smtp_server,
                         Hello => $smtp_domain,
                         Debug => $debug_net_smtp,
                         Port => $smtp_server_port);
            if ($smtp_encryption eq 'tls' && $smtp) {
                require Net::SMTP::SSL;
                $smtp->command('STARTTLS');

I really wish git bundled its non-core perl libs...
.
