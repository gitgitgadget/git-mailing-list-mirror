Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A8D200B9
	for <e@80x24.org>; Tue,  8 May 2018 13:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeEHNje convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 8 May 2018 09:39:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeEHNjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 09:39:32 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0LenJz-1eX4BV1NtP-00qmdh; Tue, 08 May 2018 15:39:26 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 7D9F064AAC5;
        Tue,  8 May 2018 13:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ULXQqVmazfN0; Tue,  8 May 2018 15:39:06 +0200 (CEST)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id AD48064A9A9;
        Tue,  8 May 2018 15:39:06 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Tue, 8 May 2018 15:39:06 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id D7DB5804D2; Tue,  8 May 2018 15:39:05 +0200 (CEST)
Date:   Tue, 8 May 2018 15:39:05 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
CC:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] gitk: add an option to run gitk on an item in the
 file list
Message-ID: <20180508133905.6jhhhp6l7avjkctl@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari>
 <20180508122256.nyv6ddcoifygfpk4@pflmari>
 <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com>
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 180508-4, 08.05.2018), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:m9mayQa2d+EeLC0mnHP+njhX7eNVwZtCHV/6Nhjo/vGgO/QlIJa
 rrKikzM7chQNafbigmWIUxELL+7mX4LEPE3Z1e7uBfCAkR9syuScNf+ps26/YOHDOjnE9uX
 /qxdyJR1kKmWRikAXXfslXBdtDzN/33EjF6LpQfR3RlXhD37wu1urXLDi6U1c6l+Qlpi/Bk
 LeJ5sskCL+CxXhzn+MscQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ij2o8EIMm8w=:CCLZ4/SX1Jm88RhYdIVjM9
 6Ern8J5oX+qdFu1UsAU9f03I8UA8pp0SnissKuNpDS2DEYhcdX4aMaarFwu4YtZda76CnFg35
 xL18GOxpzu7mR2Zk4Dg7zDgU6qUANqRz+o4i5tHXG64Y1nto4LZV7jZRNnH2uAEtgLe5Yq91W
 A7idCCKLTn1pIGkCdvfS8g/Q94iWohcmH3fTkKWzaksg6/s848QR34450vF0VgOUE6/8L18Kl
 sCiM7Een5Ucnn6G84aNWWFTnBQ1C4Ajaem+BbxpZ93QvAYGfRMl1LYWbBE8TaSfNx5XrKSaiN
 DhfWcHpD4eDrUGS+6soE4MbB/Unzwf5Nan8o+GcLFK8sZTj44lj70MukT1/75F85krIkzIIwa
 pgXFPxAknyErjDWfQUystZB9b+ogLoSzMlblCJ4IsNq7KD2n+B0vFk1dHYWBPymjARZl9uPek
 P1ZGhThvWMbM25hcRkLhpO+Mh94P7SqWdQrVr7Wkz+O537V6zFCtRTEb1DE1zbAbQNbwJT5UJ
 DyqYJSrHMVV0309Ywz3rHb9JHVwQv15h/ndlyDAYza99wLjn6SQukQTGGWr/jgz28dcgrHPr3
 ehTdlkuAwpizvx31pSLHFVIkEjyRZQj62AkbF8zaGjwbYdgDZiEvtJo8KYLgh5bVPaPMLYmVB
 MbrB9duJQfJ5YwPZveusCtWhD2tRMKUKg7kUDlRmNz9Tje4tZl6RvNR0HN78s+2NIz5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg, Tue, May 08, 2018 15:17:03 +0200:
> On Tue, May 8, 2018 at 2:22 PM, Alex Riesen <alexander.riesen@cetitec.com> wrote:
> > +proc flist_gitk {} {
> > +    global flist_menu_file findstring gdttype
> > +
> > +    set x [shellquote $flist_menu_file]
> 
> this needs to handle cdup, i.e., if gitk is run from a subdirectory,
> all paths needs to be prefixed with $cdup, like: [file join $cdup
> $flist_menu_file]

That, indeed, is easily done:

    set x [shellquote [file join $cdup $flist_menu_file]]
    if {[file isdirectory $flist_menu_file]} {
	exec sh -c "cd $x&&gitk" &
    } else {
	exec gitk -- $x &
    }


It just doesn't seem to work: gitk does not find any commits!
Maybe that's because the file panel lists only files for the current
subdirectory (without the path from the repo top-level)? E.g.

    mkdir tst
    cd tst
    git init
    mkdir a
    touch top-file a/sub-file
    git add -A ; git commit -m.
    cd a
    gitk

Gitk lists only sub-file.

Frankly, this listing limited to just a sub-directory confuses me a bit. Is
there anyway to get to display full repository without changing to the top
level?


---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren geprüft.
https://www.avast.com/antivirus

