Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6326E1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfFEPay (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 11:30:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:41969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfFEPay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 11:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559748651;
        bh=N6VxvfRh2mOg5p+CZSMu/jTUhqWFKz3fTQoJet4SnaE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PiiDC6QNANcGHDqubVkddkoQ5w8GvpE0/2sGnlRxpzevAVPjUItlf5r4MovAMDxsU
         ukgLPlE65pivG4anXQMN2bzQ1hwMU4osuc8ZmKLQnB5m+9+zyvGNNCR2T9L4Xzqzh8
         mV8vXjcneHVOp4lXuMahRaL0WTjfMHs2NX1j0ay4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([77.183.180.173]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M92ZJ-1hQYBK13k5-00CUTB; Wed, 05
 Jun 2019 17:30:51 +0200
Subject: Re: worktree add already exists
To:     Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <ad2ff81a-d75e-1ac4-07d0-c807a2ed9e36@gmx.de>
 <CAPig+cSsNQDe-3GLnmvA+EPior=RSPETJDjkCc7X1qi6gWSGDQ@mail.gmail.com>
 <CACsJy8CxSN90-EfTpkd6RUHFVp2iGjZXokpMqw7Tf0EMXT5LfQ@mail.gmail.com>
 <CAPig+cQ0po+cqdqohkVqFyk=aowtjuYGM2J=31pFu6ZuPeAUFA@mail.gmail.com>
 <CACsJy8DiueSPST64=iCZc=V6UtU61RXjJqhBHvG59BwFVSh3QA@mail.gmail.com>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Message-ID: <cd006427-03ad-4823-e872-96903cc96fd0@gmx.de>
Date:   Wed, 5 Jun 2019 17:30:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DiueSPST64=iCZc=V6UtU61RXjJqhBHvG59BwFVSh3QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UVIZ6dIMG2ukOqIGVsjZYv/60Sl2tm1Ahxk7TXGv2lQBJ7Yy9+V
 ZE2Mk3SsBCj2bePuiNUATjSoE9BUPhF7fNobyB2go59hkJarUopsmo9tMVskG0hQN3Xfmb/
 y5DnbtyfQI0lOiI+XSiwG08jnpzfXBQfpY6qkgtTZdWcThiEFKCJk9vgP17l8Fwfk45FKmq
 i5wxfuHzvUkiWmcSXGqTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kd/Cd8k5Aiw=:GXR7AkZdIQtJHCmdkRfCzw
 O7ufSQfD2eq5rNMI9He+7kyaF5IV9qJgdeK+ZBXPQ8qmX6Y3YcTquHZ1PgPHnqthmEPV2aS1o
 KVV8hCFnH+yH3TaUcJ7Ep0hVjNnC2gEkW4puJpGRD8aWCM8gogPVOjQt/p1M8y3P+y30HH8pE
 perYZGG7z6WlQg//LB1xS/QqtX8nmEcAzF5d6gGSw7f6vbhqltyW/L/FIcQbHw7dq/zqvNLmV
 FhdK5EDF7b7q948ZI6Vfc2Ec2YE1A6z+ozmSRhmXJ1ehB7sitFilIj7RP80AdG+uoevCU1GD2
 2BTOlILCGicTUKC8EtPjpSbgM0vJ6mqnBN09kQPBoiVhvyoljIYJ1UhkRqRpnAWAnLWWpfEQP
 MLIGen/e0qysUNklUDON7LI1lerDJnGB01QfTYI97z5Z9+mn3NY4AkMytgFuVJ6CN8oEumJzb
 nLbPG1vZdAX+IvuCeIlB8fZl9UVjblG3FRmjkz4LFAZIO5nObud9hqahgvF1Nfs25HWMAmsgm
 Q1dYNX1bqC9sx3FFGBOsP7TXFDgurQFtn+869prJbJwrCSUyPNQv34Oyj/DBFTvhL5XGa7Rce
 rQ+cSW6/ayWvyqruNJo14uKxcwR9EkLNY5Wd+8BjI9UHNZGtiAP4gIRfIKADQCY/0dmnLCXxM
 QWVAi5LDhv4Sp5P2gsue9oepvxi5yMzRdfTSw3x1ViSys5BBbp0/7HB3ZRdrPQ8FoWL1Pavdc
 Jv3BzE+vNTVdTU+M12E8lRREF1Nf+wqjidsBPyGCRwDR3WmBh1WFVAdAONJ1bpARw21YE25Yy
 cxSzKyoYg66lc8N/Dryaaq/02MsThMJUygQqeA1pMhL20Le7NUpQEsrC2+F/wLafchEoHolCE
 dPWlPb/gTqzNmF4ylJVT6fcrYO979ejktkprXhkc0aitXBveKrpQ/scLfrNbRg4rNvRiuoXqk
 UvPuZRSOr+rE509TiqYG4IR/Guo83GTfkBjnqQ9VIV7WvXAq+Yy1tciXpyPo0srZ4eywHK4NK
 Bw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.06.2019 um 12:17 schrieb Duy Nguyen:
> "worktree add --no-checkout --keep-worktree" is quite readable

worktree add --no-checkout -f (orce)

I've expected to work on an not empty directory


