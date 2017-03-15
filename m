Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6379020323
	for <e@80x24.org>; Wed, 15 Mar 2017 09:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbdCOJeA (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 05:34:00 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34902 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbdCOJd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 05:33:58 -0400
Received: by mail-ua0-f172.google.com with SMTP id q7so5912328uaf.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=af9oJtk+SYnpqh83Mcx5tNNwwdx8Ee7OE61kHf0Gg/0=;
        b=VMlHuPWtgx9cntVp5M6WeSqts4ktg8tK3f2CcvX4TUKEP3aAyDVDJXPeZRjRGHeELy
         3tbhtzcDS53i+FS/h7eU0DqwmxmhdS3o+28bmA20LjBeyp4xD/bScIu2PRrymbV5jKdo
         yeRzCUh1IZS6oLuU+63yOZxrjfwDx1ZKTifuIDeDLm0uFNGGiIsA4liHV7EuL0h6tqx1
         M9wrsdx5kz2HmIorASeFsF2xn5AG6IRlOmTdNR9GJIR7DqDkN/g6UQHXrRVm99Z0pWBp
         H2JdMZUAJOa+2C0VK1LGk5g4R1ASU1/6qmcSWlFa6AEN1tvZBhjOxuYSPn1xzfTFl31R
         XBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=af9oJtk+SYnpqh83Mcx5tNNwwdx8Ee7OE61kHf0Gg/0=;
        b=V0oU0uuUsx2GX2ZuSdh0PQz2ksmsovMsrcYKpMj52hpSyamDNA2TO/aaolcaO2bXym
         U1ujbPTrOqCw3L13cGFWHTmdWHQwVKAnjcTjQiyCupb8Zw7sF0qmr/3WnSmy8HiyB0Uj
         cWxlpnR62TSekIZVuNsDOs+WwvGGfYyV0hbaDlpIV0bEMbiF8utPXzdwsF19HgW8ojvr
         JurZ0pufCxETMqWIBj0udlAaSxkDkwOOEVUpRWfy31bN+DUqL5IMfT5iT0XFFqJ3iDYO
         AeNDUYc6bU/mr3wxrHBnFiuP0xG9du7W3h22GIAh/WEQ8PUA+LTppnj5r197hBw9hDEz
         QnOQ==
X-Gm-Message-State: AFeK/H0EH1Je87d5U9JGTLyJsgQXhZAuhDbxbi8XqMQCj1iHxef+tk1AyHQdQTAWYmtlrB8uFz9NEW3Diz0uRQ==
X-Received: by 10.176.0.240 with SMTP id 103mr866195uaj.114.1489570436836;
 Wed, 15 Mar 2017 02:33:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.87.218 with HTTP; Wed, 15 Mar 2017 02:33:56 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Wed, 15 Mar 2017 15:03:56 +0530
Message-ID: <CAME+mvW1x6fnGKt1_auGOp+wFYFR=Y_Qhxfd50E7KFe6t+X4kw@mail.gmail.com>
Subject: GSoC Project | Submodules related work
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        bmwill@google.com, me@vtolstov.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

I am Prathamesh. I am studying Computer Science and Engineering at IIT
Kharagpur. I am interested to participate in Google Summer of Code 2017
under Git organization. I attempted "Avoid pipes in git related commands
for test suite" as my microproject[1].

As a part of GSoC, I would like to work on git submodules. The projects I
have looked up are:
        1. "git -C sub add ." might behave just like "git add sub"
        2. Teach "git -C <submodule-path> status" in an unpopulated
           submodule to report the submodule being unpopulated, do not
           fall back to the superproject.
        3. Teach "git log -- <path/into/submodule/and/further>" to behave
           like "git -C <path/into/submodule> log -- <and/further>"

I went through the series of mail (related to projects 1 and 2)[2] for
getting a better picture of the projects. I think as the projects are
quite interrelated together, these may make a complete GSoC project.

Also the conclusions which I was able to make from the mails[2] are:

1. We are catching commands typed by the user in an unpopulated or
   even an uninitialized submodule.

2. We first check if we are present in the superproject's root dir.
   If .git dir is present we check for the presence of .gitmodules file,
   from which we can check the path give is inside some submodule.
   *When .git file containing just a .gitlink is present then, I am not
   sure but even in this case the root folder contains .gitmodules
   file in the case of submodules(Please correct me here, if I'm going
   wrong), then we may still carry the same procedure as above.

3. Once we can detect whether the $cwd is in a submodule, we can output
   "The submodule 'sub' is not initialized. To init ..." for all the
   commands which doesn't initialize and populate the submodule.

4. As similar detection could be used in the third project listed above,
   hence I even wished to include it.

What are your suggestions about these projects? Also, will it be
rational to consider it as one complete project for GSoC?
I think this might interfere with Valery's proposal[3] of shell to C
conversion of submodule related codes. What do you all think?
If it does interfere, then can we both work out on something common?

Thanks,
Prathamesh

[1]: https://public-inbox.org/git/20170313065148.10707-1-pc44800@gmail.com/T/#u
[2]: https://public-inbox.org/git/CAGZ79kYW1zS3-9AYPaiUfBGTFygyg1ZVd3YyOctp3gihfEpHeg@mail.gmail.com/T/#u
[3]: https://public-inbox.org/git/20170310211348.18887-1-me@vtolstov.org/T/#u
