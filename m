Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A351F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 15:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfDWPVi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 11:21:38 -0400
Received: from sella4.gpi.it ([89.190.163.252]:36638 "EHLO sella4.gpi.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727745AbfDWPVh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 11:21:37 -0400
Received: from prdzimgpi03.gpi.it (prdmta.gpi.it [192.168.40.36])
        by sella4.gpi.it (Postfix) with ESMTPS id 15053100069;
        Tue, 23 Apr 2019 17:21:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by prdzimgpi03.gpi.it (Postfix) with ESMTP id 02B044373899;
        Tue, 23 Apr 2019 17:21:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at prdzimgpi03.gpi.it
Received: from prdzimgpi03.gpi.it ([127.0.0.1])
        by localhost (prdzimgpi03.gpi.it [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aqhGeVh8FHcB; Tue, 23 Apr 2019 17:21:28 +0200 (CEST)
Received: from prdzimgpi02.gpi.it (prdzimgpi02.gpi.it [10.192.1.151])
        by prdzimgpi03.gpi.it (Postfix) with ESMTP id D2977437387F;
        Tue, 23 Apr 2019 17:21:28 +0200 (CEST)
Date:   Tue, 23 Apr 2019 17:21:28 +0200 (CEST)
From:   Nicola Farina <nicola.farina@gpi.it>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git <git@vger.kernel.org>
Message-ID: <679633591.38274316.1556032888730.JavaMail.zimbra@gpi.it>
In-Reply-To: <bba4ef95-7ec4-e755-23da-28c34abda8dc@iee.org>
References: <1509193182.25902858.1554893159368.JavaMail.zimbra@gpi.it> <bba4ef95-7ec4-e755-23da-28c34abda8dc@iee.org>
Subject: Re: Git subtree error on windows 10 with 2.21 version
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - GC73 (Win)/8.8.8_GA_1703)
X-Authenticated-User: nicola.farina@gpi.it
Thread-Topic: Git subtree error on windows 10 with 2.21 version
Thread-Index: azLKB1zSBqzjYsjnkYjlmjH0P6yqCg==
X-GPI-MailScanner-Information: Please contact sat@gpi.it for more information
X-GPI-MailScanner-ID: 15053100069.ACC12
X-GPI-MailScanner: Found to be clean
X-GPI-MailScanner-MCPCheck: 
X-GPI-MailScanner-SpamCheck: non spam, SpamAssassin (not cached,
        punteggio=-2.9, necessario 5, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-GPI-MailScanner-From: nicola.farina@gpi.it
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Philip

Thanks for answering.
I will try to post an issue.
The 408 line is simply this:

			cat

(btw cat command alone seems to work in my pc)

the 636 is more complex:

		parents=$(git rev-parse "$rev^@")

it is inside the process_split_commit ()  function

Thanks again
Bye
Nicola

----- Messaggio originale -----
Da: "Philip Oakley" <philipoakley@iee.org>
A: "Farina Nicola" <nicola.farina@gpi.it>, "git" <git@vger.kernel.org>
Inviato: Sabato, 20 aprile 2019 15:21:48
Oggetto: Re: Git subtree error on windows 10 with 2.21 version

Hi Nicola, 

On 10/04/2019 11:45, Nicola Farina wrote: 
> Hi 
> 
> After upgrading to 2.21 issuing this subtree command: 
> 
> git subtree push --prefix ouverture Shared-Ouverture master 
> 
> I get these errors: 
> 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 408: /usr/bin/cat: No such file or directory 
> C:/Program Files/Git/mingw64/libexec/git-core\git-subtree: line 636: /mingw64/libexec/git-core/git: No such file or directory 
> 
> I have installed git choosing the option "use git with bash only" 
> 
> thanks for any suggestions/help 
> Nicola 
I don't have any solution at the moment, but given it's Git-for-Windows 
it is worth also logging it as an issue at 
https://github.com/git-for-windows/git/issues and searching for 
additional clues on the GitHub site (including closed items) 

Also what are the commands at those lines in the code? 
-- 
Philip 

