Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BCCD1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 05:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeK1Q4D (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 11:56:03 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:38072 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeK1Q4C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 11:56:02 -0500
Received: from frodo.localdomain ([83.162.234.136])
        by smtp-cloud9.xs4all.net with ESMTPA
        id Rsoqgu0oVfa12RsoxgePwJ; Wed, 28 Nov 2018 06:55:35 +0100
From:   "J.H. van de Water" <houder@xs4all.nl>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, incog@xs4all.nl
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is working (again)
Date:   Wed, 28 Nov 2018 06:55:28 +0100
Message-Id: <1543384528-4498-1-git-send-email-houder@xs4all.nl>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com>
References: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com>
X-CMAE-Envelope: MS4wfPNrzGZqavhSGUzZRUtKAXmihPr959ILGkvr9XNLUN1GS5l+xAcDvo7ycqEiY8Xq3qGoM6SAtaya9nLBchU1Zmwf2Rpgeb7dGwS0sGnFDHhLZR9hwfPd
 6VOhrQ0ieLnwogJjzdBKYr2zT6ZHuMoISq5TYNZdGZVADrc4ALNtlUM8IHn689mVcI37YpqIUmy7bIdmKSpIT1+1+4HdyBaG5vTrBoxkOzgJvSWFlZyz4ABb
 8DsV2Pokd0IGQkDr4DYnmSMbu4ORGKm3tnKO5IzNzqk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > me@work /cygdrive
> > $ ls
> > c  d
> >
> > So `/cygdrive` *is* a valid directory in Cygwin.
> 
> That supports the code that does not special case a path that begins
> with /cygdrive/ and simply treats it as a full path and freely use
> relative path, I guess.  Very good point.

Please read

    https://cygwin.com/cygwin-ug-net/using.html#cygdrive
    ( The cygdrive path prefix )

.... you can access arbitary drives on your system by using the cygdrive path
prefix. The default value for this prefix is /cygdrive ...
....

The cygdrive prefix is a >>> virtual directory <<< under which all drives on
a system are subsumed ...
....

The cygdrive prefix may be CHANGED in the fstab file as outlined above !!!!!
....

To simplify scripting, Cygwin also provides a /proc/cygdrive symlink, ...

=====
