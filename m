Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F0F2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 04:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdKVEfo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 21 Nov 2017 23:35:44 -0500
Received: from dmz-mailsec-scanner-2.mit.edu ([18.9.25.13]:43278 "EHLO
        dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751434AbdKVEfn (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2017 23:35:43 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Nov 2017 23:35:43 EST
X-AuditID: 1209190d-2f9ff70000001e50-a1-5a14fd71a65b
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by dmz-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DB.35.07760.17DF41A5; Tue, 21 Nov 2017 23:30:42 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
        by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id vAM4UT9N000942;
        Tue, 21 Nov 2017 23:30:31 -0500
Received: from localhost (MASS-TOOLPIKE.MIT.EDU [18.9.64.17])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id vAM4URQ2019052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 21 Nov 2017 23:30:28 -0500
Date:   Tue, 21 Nov 2017 23:30:27 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Documentation: allow overriding timestamps of
 generated asciidoc
In-Reply-To: <20171122011531.GQ3429@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1711212317440.27951@mass-toolpike.mit.edu>
References: <20171121232935.GM3429@aiede.mtv.corp.google.com> <20171121233432.GN3429@aiede.mtv.corp.google.com> <20171122005433.kwv4bin6y65xuxm5@genre.crustytoothpaste.net> <20171122011531.GQ3429@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42IRYrdT1y36KxJlsPY+o0XXlW4mi4beK8wW
        b28uYbRom/mDyYHFY/nNv0weO2fdZfe4eEnZ4/MmuQCWKC6blNSczLLUIn27BK6Mz0vPshf8
        Zq/o2TOTuYHxOlsXIyeHhICJxP41newgtpDAYiaJhfuquxi5gOyNjBKvZx9khnB2MUl0fFsA
        VsUioC2xY1oDmM0moCbx4ehXVhBbREBD4vmnb2BTmQXKJbbt7gGrERaIllh3/BVQnIODU8BO
        4twkJ5Awr4C7xIzFPxkh5t9jlJjy8SlYr6iArsShf3/YIIoEJU7OfMICMVNd4sCni4wQtrbE
        /ZttbBMYBWYhKZuFpGwWkrIFjMyrGGVTcqt0cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcx
        goKZU5J3B+O/u16HGAU4GJV4eGckiUQJsSaWFVfmHmKU5GBSEuUNXg4U4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMLrHgOU401JrKxKLcqHSUlzsCiJ824L2hUpJJCeWJKanZpakFoEk5Xh4FCS
        4OX4A9QoWJSanlqRlplTgpBm4uAEGc4DNNwJpIa3uCAxtzgzHSJ/ilGX49nM1w3MQix5+Xmp
        UuK8yiBFAiBFGaV5cHPASYjTQfAVozjQW8K8m0CqeIAJDG7SK6AlTEBLfh4XBllSkoiQkmpg
        5NT+oqGz+XZ7XtjJMElDNx/TWOd7k3w4nfm+ub8t4ue5Padl8oJJxz/taJyyPfzyjdVec3fM
        M0+4dyrP03ivoP69uFpHbYlZIYdTN2n/1tgw5cLGTVmPj2eUerE5bDln+khg4qMXVfsle7tK
        31y33WBZEfaZ6eD07Ot73qt3e93YLXJzf5fiPiWW4oxEQy3mouJEAI2VbLMdAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 21 Nov 2017, Jonathan Nieder wrote:
> http://asciidoc.org/CHANGELOG.html is stale but asciidoc still seems
> to be getting changes at https://github.com/asciidoc/asciidoc.  I
> wonder how difficult it would be to add any required SOURCE_DATE_EPOCH
> support there.

In fact I already did (https://github.com/asciidoc/asciidoc/pull/106), 
which is why I’d been holding off on trying to upstream this Git patch.  
The trouble was, the AsciiDoc developers had not been cutting new releases 
“because nobody knows how” 
(https://github.com/asciidoc/asciidoc/issues/103#issuecomment-322077321). 
However, it looks like AsciiDoc 8.6.10 was recently tagged and Debian got 
a 8.6.10-1 package yesterday, so I guess that trouble has been quietly 
resolved.

That should make this Git patch unnecessary.  (You’re of course still 
welcome to take it if you think build reproducibility with old AsciiDoc 
versions is worthwhile.)

Anders
