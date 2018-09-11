Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D691F404
	for <e@80x24.org>; Tue, 11 Sep 2018 07:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbeIKM1y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 08:27:54 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:36181 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeIKM1y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 08:27:54 -0400
Received: by mail-it0-f48.google.com with SMTP id u13-v6so241435iti.1
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sergei-haller-de.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5TNvpBlRV5k4pzB/TThdpPBzLLGHKklNGUdARfdV+Fw=;
        b=T0o02SiT9IoWu2sX46tIk6lHVeLJHnXpovXTo8e/0eVqGPKXpomfw3ZQp7dCYL+q+U
         iFCUAgzoHKEkqlQIANli1X55zQNxuF3BwveBLGHJ1wVIe8mNg2padyYa4ydHKrvcNJdp
         YGxDqcTt81o9R6Cwu2keJLfcx0ax901tBD2F0zGzI3gGGESNEcUi9NQ7AjGGv1CAg97P
         2JfOD9x/2uqn1Cj7oWd6cyLmLWccVidJHIj1hnOGzgme5x0iko83bXmQFaKHsxbrRXSL
         dKK3B48jZirq4THedG1wGCgsrJZ+IFKXloSwqRps8cwBm375geu6WhdH4fe4E8dP9S/A
         ZmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5TNvpBlRV5k4pzB/TThdpPBzLLGHKklNGUdARfdV+Fw=;
        b=jfoFLCzH08yG34P+vAm6uguz9ieFAXzJCfXG/yEuMXKbWHn2X/0ZsWpRVl8pdkULvm
         2TBxf2vpzTP/X1liJweBMQppk4Sd9/XtNhlrtDdV7V6JTpzN4p1zR4LgzdJReIEpK1CU
         UTOJVDXG+pFJny1Q7kbK88s6YHvL4mQ4elp1oPyrPzT2ljGM5JwCndKTN9KTj6Hb8WZv
         dcjP8HORonv0kWfzhFLHJQZOrsAfkkHGTmBtrrxYzNXaY/pshWPEOPDn0WNa8iO49MYF
         hTxx1JvkSnuy6gf4OkHA5d1sZWH8xYCPiASyobKid5FI1pHszcNt3Rf+eK1mU8MxED/O
         6SIw==
X-Gm-Message-State: APzg51D69jbTTkOhl3t2nqZijBtSCfAp/V5gN12Kbw5RO7qkdjlcVHFj
        vjU0oqldUFjSM58alQepKN9ipuP9pDcizO7Mo0j5gzym
X-Google-Smtp-Source: ANB0VdZcPyy06cTwwDwVGzPTaBbb/2FEmiwiOrX/H1pGz2R/iFMXBDNjTWfbxEEVRZPuhWwNk12IqDNbmrkx4jdMArg=
X-Received: by 2002:a24:3d14:: with SMTP id n20-v6mr363914itn.15.1536650995770;
 Tue, 11 Sep 2018 00:29:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:6666:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 00:29:55
 -0700 (PDT)
In-Reply-To: <001901d4490a$528d7590$f7a860b0$@nexbridge.com>
References: <CAPO0KtU=do8nmJggP4-k1BingdseZUuRjWraGjuN01VoEYU=1Q@mail.gmail.com>
 <001901d4490a$528d7590$f7a860b0$@nexbridge.com>
From:   Sergei Haller <sergei@sergei-haller.de>
Date:   Tue, 11 Sep 2018 09:29:55 +0200
Message-ID: <CAPO0KtW8HGjdRcb7cStBqK1LA4f7jjxgXaDKOLhXpYAE_o+08w@mail.gmail.com>
Subject: Re: Multiple GIT Accounts & HTTPS Client Certificates - Config
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

no, using SSH is not an option. I have no control over the server
setup whatsoever.

Thx!

On Mon, Sep 10, 2018 at 3:29 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On September 10, 2018 4:09 AM, Sergei Haller wrote:
>> my problem is basically the following: my git server (https) requires
>> authentication using a clent x509 certificate.
>>
>> And I have multiple x509 certificates that match the server.
>>
>> when I access the https server using a browser, the browser asks which
>> certificate to use and everything is fine.
>>
>> When I try to access the git server from the command line (git pull or similar),
>> the git will pick one of the available certificates (randomly or alphabetically)
>> and try to access the server with that client certificate. Ending in the
>> situation that git picks the wrong certificate.
>>
>> I can workaround by deleting all client certificates from the windows
>> certificate store except the "correct" one => then git command line will pick
>> the correct certificate (the only one available) and everything works as
>> expected.
>>
>> Workaround is a workaround, I need to use all of the certificates repeatedly
>> for different repos and different other aplications (non-git), so I've been
>> deliting and reinstalling the certificates all the time in the last weeks...
>>
>> How can I tell git cmd (per config option??) to use a particular client
>> certificate for authenticating to the https server (I could provide fingerprint
>> or serial number or sth like that)
>>
>> current environment: windows 10 and git version 2.18.0.windows.1
>>
>> Would be absolutely acceptable if git would ask interactively which client
>> certificate to use (in case its not configurable)
>>
>> (I asked this question here before:
>> https://stackoverflow.com/questions/51952568/multiple-git-accounts-
>> https-client-certificates-config
>> )
>
> Would you consider using SSH to authenticate? You can control which private key you use based on your ~/.ssh/config entries, which are case sensitive. You can choose the SSH key to use by playing with the case of the host name, like:
>
> github.com
> Github.com
> gitHub.com
>
> even if your user is "git" in all cases above. It is a bit hacky but it is part of the SSH spec and is supported by git and EGit (as of 5.x).
>
> Cheers,
> Randall
>
> --
> Randall S. Becker
> Managing Director, Nexbridge Inc.
> LinkedIn.com/in/randallbecker
> +1.416.984.9826
>
>
>



-- 
sergei@sergei-haller.de
.
