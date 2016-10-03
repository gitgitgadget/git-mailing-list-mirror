Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15B4E20986
	for <e@80x24.org>; Mon,  3 Oct 2016 06:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbcJCGge (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 02:36:34 -0400
Received: from mx3-phx2.redhat.com ([209.132.183.24]:55276 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbcJCGgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 02:36:32 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id u936aWHS001968
        for <git@vger.kernel.org>; Mon, 3 Oct 2016 02:36:32 -0400
Date:   Mon, 3 Oct 2016 02:36:31 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     git@vger.kernel.org
Message-ID: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
In-Reply-To: <88486231.114620.1475474318974.JavaMail.zimbra@redhat.com>
Subject: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: A+voVj8tnKTYRSU9gTivl6CydTDZDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to request for implementing feature described in subject.

In several projects, we are using git mergetool for comparing files from different folders. 
Unfortunately, when we have opened three files  for comparing using meld tool (e.q. Old_version -- Result -- New_version), 
we can see only name of temporary files created by mergetool in the labels (e.g. foo_REMOTE -- foo_BASE -- foo_LOCAL) 
and users (and sometime even we) are confused, which of the files should they edit and save.

If you will be so kind and approve this feature request, you will help us to solve this unfortunate issue by the easiest way.

I have already prepared patch, which can be applied to resolve this request (see in attachment).


Best regards

Josef Ridky
Associate Software Engineer
Core Services Team
Red Hat Czech, s.r.o.

