Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C431F454
	for <e@80x24.org>; Mon,  4 Nov 2019 17:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfKDRfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 12:35:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:35367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfKDRfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 12:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572888935;
        bh=rwaP1rjlLhJ/1sT+bD0AbU8ZdCKjOS0W4jqOj7j3HDU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QdAaGeXLy81G+R07QgURcWCS45UW+G/qpiYYiI9ls/RR/bYb3o9lIq4eYDs4pmX/q
         f86UXz2qtzy6GnmkeYGg746NwSsPlqdMvw/fpj/aUvsNQn7xvOBVlgA/sdUFASKzQ7
         rzo5bVSkxfWz7pNGiX6yWBnke0eyYsTV2DFsHiKI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([89.14.244.142]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1idTpM05nv-00BuAJ; Mon, 04
 Nov 2019 18:35:35 +0100
Subject: Solved: Windows Git WebDav WorkDir
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
 <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
 <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
 <2883e199-bb7d-e323-d3eb-ed8da85cc54a@gmx.de>
 <AM0PR02MB3715C3E485FD1FB0F0FD9E7B9C7F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Message-ID: <b9ae055a-d3c8-c7a4-2724-b23edd643432@gmx.de>
Date:   Mon, 4 Nov 2019 18:35:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AM0PR02MB3715C3E485FD1FB0F0FD9E7B9C7F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:ksYBWbheA7yTC/b93ditZiyLzCocT38H/VjeJUH9WoyYcNUCUyZ
 1S64bZDPbq2TZGEaFvcBTzhNWjAvP/eqT9nHIRtwykWci5rQ7BfqL9/n9JVJnYgVAZtR3og
 TCxUBGpbqw8opHecbdj4l21YDzgzd+r0jbj2DttgY0OaEFC2ZOtoF9W6ulq5OtSfHObO2YA
 aihcfftOxWQ/jjue/PeHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ehd8uBC2Mvk=:zbr+FuYBGgu311RTyV1QX3
 Wpz9C4/r9jp+TqT5Nb2X9Hsh6t2gJFYBjXhsj/ejM53pFbgvjCSjGydbTPmvk9zOhmDSuQJ9E
 MZ2aZyRh097ukywDo9/bUlZmN7s8wD/fyz2iI6T3zwm/yiYu14P2w3wjk/aaMhFChcjIuN7A/
 aSK2RkBLvkSkZoaxo/FVxIaQ6dAkVgDHbJsi+gPq5brftMjrs/rB/bQ/nV159aB5eA5vjcgBI
 b+Y6nOZ9VGEC2Ii/932s7X/fI7e560Z+7YyFdQtyfQSOSPZzOvlkNQa08tcDSl2J7vbED7gNB
 BMaIr4g+qwG8aR+KWwQL+EqyX/K5wO14ugwLT3RcpNTEKFsnP9QruaVNHE6eQ4C1fUgVwFH+K
 ptTGtPVq5TPMY/dW8OsrlG0GXNtBPrKSYa7YcXGcmfW0sUzGnrCFhDQi7++caIjQZdHcnMTPC
 YN80zveCicqKRNsOaeewRXn5j2eSMFStK4YM/c2Ec19U+lISMS9y0Q51Y+T6YKAXT5uYvG/ZH
 c4+x30c/x281wPGBQs5MsUztQPSUGZydLzgFUeO1xQPQI6p32qoEjE+x53t8UAtGi4D9tHur4
 c3XU8uW4SCEs2mBfWZsP0ZU6m44jPje6xEKTJ3bdaPjnqrvkAQrrL10i6p/z7Es9lfpXdj0be
 D1L0+zIKjUl8o1A4Rzc2I5SjDdFY1B/WFLYNmVTOECC3tcqpl2sYqTQAStX31/2E7TPLjYj7R
 FgmHHEVkhczcYFVuizSvYQjFmqcIDCktnYT+qlYdsqgaEn/T0fvfLB/n8xVcYHCB4a4gg8wE/
 +13ztH729GNuQDaPuZ/onUHkrIyZs9fgxqxvgqyFwMa1F7x2sDh1i21zBVQV4J2BPji7NIQGP
 QGhXR7N7B6IBYsJvmz5gQ2mJVvD7aB/sw8Bm1oZG0PIK5R/4nszliCUyjl9MVWsIZNqtgk8CZ
 TBF/yI0wLr7XsPKfb0b3QVPVZIXKkic+BehTuko052qsu5QtADn0VhmYx6iXOJe9GaI8J/BCe
 0yprDEt55aEY5lDijl2P2MvvZLd62Qhsscq2qRmz8qz0VUknZEzPyZRQia47K+yapnAJDPNoF
 xYYmO0yU6nVCgs+tQbKudptpKI/Hev4Ku/uTzFfpOP3uPUIzlecwCimb2OCC6R7OLVcr9HDE+
 Lf/mll7iUecBmx2HROSf3aUCZQQfMEZUe8VNTnRoSvE5wVejuuVDoEfOqJTZTeJ41E96TfOnP
 vQuyhPr5lNtf6rmf0NfxNR6tmfcjGqgaA9AoBlzeCj7LAO4lCqyN/wQCEZdw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git config core.fscache false

seems to make the WebDav Worktree Dir working,

without the other suggested settings.


And I make a new worktree somewhere and move the .git file to directory
with existing source
and edit the gitdir file in .git/worktrees/xyz to the existing source
directory,
since I can't make a new worktree in a directory with existing source.


