Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF1E1F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 10:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbcI0KkZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 06:40:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:52336 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753884AbcI0KkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 06:40:23 -0400
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lwnem-1arYA02NmC-016Nfq for <git@vger.kernel.org>;
 Tue, 27 Sep 2016 12:40:20 +0200
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     git@vger.kernel.org
Subject: question about git rev-list --max-count=n
Date:   Tue, 27 Sep 2016 12:40:19 +0200
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201609271240.19759.sweet_f_a@gmx.de>
X-Provags-ID: V03:K0:k1+dWRlNhmRNxSWGKpCwbS0THVXKc5/0UL1A6EGcs/pEknD9sOK
 5c5Pa9y7KtpPRfUjEv8QnpYyyKd/J6suqLG0u46lTzhXGc0Uoiw13xCGDGomq8l7W2QEgq4
 dD/zB0p53H4DUUQ/3KxxerBiNNnKlbFRHjLok2hvWHKfZrHfnOBTQt2PBluHwBG2llgz1DW
 Blb6afVwCRF+E3YKDc/Mw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V1JTboj7G7U=:0Im4pmIWOmM//QAj9Bkas3
 aHinHWBq6AZmZzIX+vPREINfDrcQZ6q/x726Ljrfc7mXTpXC48giuVOhuliCI61HA2HbG8ynw
 /flJ5zU7g8w16otA7pjbVKUfV+V7LZPvcBOkdAzJvN2Vk9Imq43ZoXky2lGpuefgI0iXvQ2W/
 Olcy0M9kL+Kg8tsEXt/cltRbc+xpMj5zc7UtgS7SseWdt/SUuUHyKT7hzgt40xLMvPzpsMLuU
 9wzLB+MPNRVLiMIh9v/cjC6BeRIRpyjVtuTKxVW9s+om+dBUis9zu8Qsadazi3qj2bhqt4Fia
 WmIeZ62JOfc/j8uHFI/yzn42TCfu2gzkUCMJ6jLY4Q6XRwfwPstmYaEe0fqZEKn9t85uYzJRV
 MBwuXmDJhMheZNTn7YdjTK/1nVgeQrZRnkbxVnkjKEbDPyHCjCXi/pryI3qTPIjzkGB0oo5Py
 D+4ujtfmk+Z9bOSK4VJYsuJ8xFO+aOBRlgDP9w8754jVcAhFwV1pLhDl2M9G7MEReHoMPYClz
 7TVXbmKmR0UhDVsL0jHa1SzpFkaYpkMu9zH7c62J3mZn9x3wXkrm9ebE9qYbffOmhQkmYW9r9
 P+O8Da6Tq1FoUqRHQ18Lsuallrg7BVLeJjgg2+3asLcXHQ3rYwF9Cs77bke0Z7vohs0bStCkT
 gRFT3H1w1ZRO2WMR4C7GbPpN2t4ELB1BpLvb8r3gLvwI4yIPbjBNpJc8pFH3nPh4THwVcPtVN
 k/K6Nylu+B+hhTs5GD75ENJbcfoBaTmgrwQQS8LngB7YJuR5BrcIO/1kaZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git rev-list --max-count=n

seems to always list the _last_ (newest) n commits. Is there any 
functionality to list the _first_ n commits?

I've tried to add --reverse hoping that this would do it but it does 
not.

The manual could be a bit more clear about that:
    --max-count=<number>   Limit the number of commits to output.


If it really would only limit the _output_ (like head -n), then 
IMO --reverse should do what I want.


Regarding my initial question. Maybe we could support
   --max-count=-n
to list the first n commits.

cu,
Rudi
  
