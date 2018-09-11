Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEBF1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 07:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIKMki (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 08:40:38 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36160 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeIKMki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 08:40:38 -0400
Received: by mail-io0-f182.google.com with SMTP id q5-v6so2805326iop.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 00:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sergei-haller-de.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=LAOGfJgb3w/07CuISrpQjLT0Jl1Nw/GbH2SmezLjj04=;
        b=IA1fMXx6+3A01VFZ3YbdloScGJK8HtZdsr/+qWd+7MVMVwZjMEat3WAjfsQRTlaHaE
         k+ju6pJLiUdBOotUgLcMuBEVK+iJ9Sd0WvP8wf4VEi2q/D/S6IVARY2J4d9527fI5mFI
         zMyIsNp2X/Vu+Ocin0J4kltslyyqZxMQbXfqKJCq5iHwwPskxYn2+g4QmGZ/ag3lRGmV
         dAXeh8a8/3Fx5fawp7zUZokknQJv1Inzl2P6+TYHYhsJGSWrn+L3hALh5cbncWzkW5OL
         o/zZpgxtJ33pWSbKMM0EMm/OkkpYN5o8Rks3P0TLQ94alzlKm5BlYM58CGIcWmh+ZPzo
         cH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=LAOGfJgb3w/07CuISrpQjLT0Jl1Nw/GbH2SmezLjj04=;
        b=JSiJvnsLMP2uGK77G79BJhtYdnMxQS/uvHB9hL0gqkICkJNidvXG89Ewg96MSkRFoM
         c2CFZLIWnzl6QP5a6CngyoHPwWLZ4L6n6vQuPNNS5vljp7aZe4UHgJnz+91PJlvg3Z0N
         3Jm6Dix3wWyPXfi4ZC5c0ZyLHZoDvw0jTlIFfKYdYYV2kpAdkYju0ZC1p5MMfLdXyUBn
         lgn2f15cOkC4YdMjBs287MgO/0YENrT8jib77KZQoYXoUwV8NtW7RwkAKxgDIWQ9qsVZ
         FnLEEZjLleC43HbufdlTu8EA7xtCjau3gwIdjB+BcfuG3f9rIsSbZUPkLSu4HAYmLlc/
         7JGg==
X-Gm-Message-State: APzg51BK+yf2ucSPPJQTjQIGF84RusKgtgx76+0dUCOiSC6EVM4gRJB3
        Qsw05CmkbXnLyF6xktoIriXkWurAYugjOdjR1ErFl+cy
X-Google-Smtp-Source: ANB0VdYBJWwXlyM5J1PCE9kKwDirrO80mnKRThhgFC0Tf/TdO5ThDhwqxGGuUIQWrjYxazMDYGDFMZf/Of6yb7q4E9U=
X-Received: by 2002:a6b:f919:: with SMTP id j25-v6mr18961331iog.280.1536651755712;
 Tue, 11 Sep 2018 00:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6666:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 00:42:35
 -0700 (PDT)
In-Reply-To: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
References: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
From:   Sergei Haller <sergei@sergei-haller.de>
Date:   Tue, 11 Sep 2018 09:42:35 +0200
Message-ID: <CAPO0KtU5YHtuTEzSAZ8sbtuUuZ_0EV4_LyQdWcDJgH6N05TN+g@mail.gmail.com>
Subject: Re: Multiple GIT Accounts & HTTPS Client Certificates - Config
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PS: while I was trying to send the mail to this mailing list, there is
some update from the stack overflow side:

* I am using sslBackend schannel
* the private key of my client certificate can be provided by using
the http.sslKey config option
* the private key is on a smart card, so there is no way I can copy it
over to a file and use the openssl backend (at least no way that I am
aware of :)

so basically this pins down to the fact that schannel implementation
is picking the wrong key.

Would be great if (one of) the following option was possible:

(a) schannel would ask interactively which certificate to use, if
there is more than one that matches the servers request
(b) key info (e.g. serial number or fingerprint) couldl be provided as
config option

not sure if (a) or (b) is already possible (in some nightly build or
some hidden option?)

I'd be eager to test if necessyry, but I probably wont be able to
build git (so would need some sort of nightly build or something)

PS: the recent realization makes me believe this is a window specific
problem. I think I have read somewhere
about a separate windows mailing list (but not sure where I saw it)


On Mon, Sep 10, 2018 at 10:09 AM, Sergei Haller <sergei@sergei-haller.de> wrote:
> Hi folks,
>
> my problem is basically the following: my git server (https) requires
> authentication using a clent x509 certificate.
>
> And I have multiple x509 certificates that match the server.
>
> when I access the https server using a browser, the browser asks which
> certificate to use and everything is fine.
>
> When I try to access the git server from the command line (git pull or
> similar), the git will pick one of the available
> certificates (randomly or alphabetically) and try to access the server with
> that client certificate. Ending in the situation
> that git picks the wrong certificate.
>
> I can workaround by deleting all client certificates from the windows
> certificate store except the "correct" one => then git
> command line will pick the correct certificate (the only one available) and
> everything works as expected.
>
> Workaround is a workaround, I need to use all of the certificates
> repeatedly for different repos and different other
> aplications (non-git), so I've been deliting and reinstalling the
> certificates all the time in the last weeks...
>
> How can I tell git cmd (per config option??) to use a particular client
> certificate for authenticating to the https server
> (I could provide fingerprint or serial number or sth like that)
>
> current environment: windows 10 and git version 2.18.0.windows.1
>
> Would be absolutely acceptable if git would ask interactively which client
> certificate to use (in case its not configurable)
>
> (I asked this question here before:
> https://stackoverflow.com/questions/51952568/multiple-git-accounts-https-client-certificates-config
> )
>
>
> Thanks!
>
>
>
> --
> sergei@sergei-haller.de
> .



-- 
sergei@sergei-haller.de
.
