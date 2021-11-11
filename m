Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BBC433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C076610A0
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 22:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhKKWMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 17:12:33 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43656 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKKWMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 17:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636668582; x=1668204582;
  h=mime-version:subject:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to;
  bh=30IIsjOY/sV24cXxTwX32PwpcJolci64+IwoHLhwxW0=;
  b=uJtssMT1wogHvqm01MAFMdyh0yd032U3Xp/w+Y5VuDRjnS/Qf+7LSIyR
   VyOVgUcryCH9MLYvvhZMNwcVKUCkCawMyi9+GYGOlimCyOGvI9Bog4G/E
   uPg1e8BG5KkYxM3u9Y7ZYoUr+VAg/VEQcOoBe48lmbMYrW92UFc6H9Ixb
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 11 Nov 2021 14:09:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 14:09:42 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 14:09:41 -0800
Received: from smtpclient.apple (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 11 Nov
 2021 14:09:40 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v2] protocol-v2.txt: align delim-pkt spec with usage
From:   Nasser Grainawi <quic_nasserg@quicinc.com>
In-Reply-To: <20211111220048.1702896-1-calvinwan@google.com>
Date:   Thu, 11 Nov 2021 15:09:39 -0700
CC:     <git@vger.kernel.org>, <gitster@pobox.com>,
        Ivan Frade <ifrade@google.com>
Content-Transfer-Encoding: quoted-printable
Message-ID: <CD28B0FE-B378-45C6-9DD9-FC79C84040B8@quicinc.com>
References: <20211027193501.556540-1-calvinwan@google.com>
 <20211111220048.1702896-1-calvinwan@google.com>
To:     Calvin Wan <calvinwan@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Nov 11, 2021, at 3:00 PM, Calvin Wan <calvinwan@google.com> wrote:
>=20
> The current protocol EBNF allows command-request to end with the
> capability list, if no command specific arguments follow, but the
> protocol requires that after the capability list, there must be a
> delim-pkt regardless of the number of command specific arguments.  =
Fixed
> the EBNF to match. Both JGit and libgit2's implementation has the
> delim-pkt as mandatory. JGit's code is not publicly linkable, but

Why is JGit not linkable? Isn=E2=80=99t it =
https://git.eclipse.org/r/plugins/gitiles/jgit/jgit/+/refs/heads/master/or=
g.eclipse.jgit/src/org/eclipse/jgit/transport/ProtocolV2Parser.java ?=
