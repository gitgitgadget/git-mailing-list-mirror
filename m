Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 085B8207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbcJDFSu (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:18:50 -0400
Received: from mx3-phx2.redhat.com ([209.132.183.24]:33717 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbcJDFSt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:18:49 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id u945Imsn028723;
        Tue, 4 Oct 2016 01:18:48 -0400
Date:   Tue, 4 Oct 2016 01:18:47 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <597741871.671633.1475558327029.JavaMail.zimbra@redhat.com>
In-Reply-To: <CACNzp2mANqmciMzvCahM_+=RnZYtU1SK9DRS2BmQru1fZY_wUQ@mail.gmail.com>
References: <88486231.114620.1475474318974.JavaMail.zimbra@redhat.com> <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com> <CACNzp2mANqmciMzvCahM_+=RnZYtU1SK9DRS2BmQru1fZY_wUQ@mail.gmail.com>
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: f4frcK+313v46QZgc1bBHixTtBtMaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anatoly,


| Sent: Monday, October 3, 2016 5:18:44 PM
| 
| Hi Josef,
| 
| 
| On Mon, Oct 3, 2016 at 8:36 AM, Josef Ridky <jridky@redhat.com> wrote:
| > In several projects, we are using git mergetool for comparing files from
| > different folders.
| > Unfortunately, when we have opened three files  for comparing using meld
| > tool (e.q. Old_version -- Result -- New_version),
| > we can see only name of temporary files created by mergetool in the labels
| > (e.g. foo_REMOTE -- foo_BASE -- foo_LOCAL)
| > and users (and sometime even we) are confused, which of the files should
| > they edit and save.
| 
| `git mergetool` just creates temporary files (with some temporary
| names) and calls `meld` (or `vimdiff`, etc) with the file names as
| parameters. So why wouldn't you call `meld` with the file names you
| want?


Because files, that we want, are temporary files created by git mergetool and we are not able to change their name.

Regards

Josef

