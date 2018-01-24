Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F12C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 04:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932537AbeAXEt7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 23:49:59 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:35538 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeAXEt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 23:49:58 -0500
Received: by mail-io0-f176.google.com with SMTP id m11so3446032iob.2
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 20:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Pcwo2sh32jlRDyfng2jfuMyA3b8DdMSUN8rBciQTECg=;
        b=jc6XksRZ8t/I2v/wi2nrRchcezjS+OEyZvOWPEQtptQABTvQQ5ZJ7tDbJYykIAWSL3
         NXwHqtpuz0VeFKgUNp6/Ay+gCpdeerbfuXPr/Medmq17CrLjmF0K7XtiQ0nZMk8dvr4E
         pM7Wd9qF+BClN4bjmvxb5sQlmcO11Z/1+Ol4VgbsL+inL49YVdSAxwQiDIKsMQDVwOtC
         rn0KkIJwC0a/hUy0FYzbslWGHSfRDKhRZhZVBaGPqLkzaTJorJSbBuHktBUaFQCfelxo
         ybmBexR8om3vZ4KL++bvs3yZXiBi19Za/bV7AvVmLuWc3LlKkhnhiVbHdCmvQKObs03g
         q0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Pcwo2sh32jlRDyfng2jfuMyA3b8DdMSUN8rBciQTECg=;
        b=AAgyBnrareVBgzXEgt1E1UdzxiqMEWmoizITnvrkFjH6eSjjywg//E3duMCRY7xVFL
         Md+6T1hdvlbpxDTvXSwDLCRrhZgPw8bTZW7/Ia4he23i2aBfjsWw3dPfmMf1JpRKPn3z
         wMwiVNQ7wsE4Opc7azSQrt/3+mfcKTGzNB1c7Mu8t2wsqs5uKxNjPvdCqcZXmtXnapzo
         0mMTnQMPjKbC/Kq/lLFifwl6uhgzVfPsY38jj/bNaOmS7QUTgdDeTcGjvcXo/PQcgUu4
         +oE8mRCCD5jWsyuhIz8lWNUET/xQjIuk4A4kcagbMPGoWLTN663YmBZ7rZ6vfGdVvyM+
         V76Q==
X-Gm-Message-State: AKwxytckjxmYxH33JJ4S8VEghHEqWDMxxsYfJZ06UDNP+D/bPKyEA/Tk
        6GflqYhRNJWmyP6Tj0jSQy8OlOV7nNpGjv18KyjFcg==
X-Google-Smtp-Source: AH8x224z7tVFN708vm+HjYYRhUcWPoQ90PJXmDbYC+rr4iU579WiuOPtnlUxEvvMVippPyzn8ktDAShEgBvt2fFmIJs=
X-Received: by 10.107.128.232 with SMTP id k101mr7445037ioi.152.1516769397704;
 Tue, 23 Jan 2018 20:49:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.116.5 with HTTP; Tue, 23 Jan 2018 20:49:56 -0800 (PST)
From:   Aleksey Yaroslavcev <a.yaroslavcev@gmail.com>
Date:   Wed, 24 Jan 2018 09:49:56 +0500
Message-ID: <CAHnnmh6QCnHTycbMDLjfFYoXW4dErTZoTHsPrkYdhZKnXcHHYQ@mail.gmail.com>
Subject: Problem with git and proxy server with authentication
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
(sory for my english - it's not native for me)

I use proxy-server with authentication.
I have two instances of PortableGit: version 2.10.0.windows.1 and
2.16.1.windows.1
I added proxy settings in ~/.gitconfig.

If I try to pull my repository with version 2.16.1.windows.1 , I get
error message:
"fatal: unable to access
'https://aleksey_yaroslavcev@bitbucket.org/aleksey_yaroslavcev/testgitflow.git/':
Proxy CONNECT aborted"

But pulling with version 2.10.0.windows.1 working fine with the same
settings in ~/.gitconfig.

I decided to figure out what the problem is and found out the
following. There is a difference in the way how git making connection
through proxy. See the attached screenshots from WireShark.

In old version:
1. creating connection to proxy
2. trying to connect without authentication
3. proxy saying "407 Authentication Required" and requesting
termination of connection(FIN flag in TCP packet)
4. reseting conecction(RST flag in TCP packet)
5. creating another connection
6. trying to connect with authentication
7. Bingo!

In new version:
1. creating connection to proxy
2. trying to connect without authentication
3. proxy saying "407 Authentication Required" and requesting
termination of connection (FIN flag in TCP packet)
4. trying to connect with authentication in the same connection but
proxy is resetting connection (RST flag in TCP packet)
