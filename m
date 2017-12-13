Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39741F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbdLMSqd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 13 Dec 2017 13:46:33 -0500
Received: from aibo.runbox.com ([91.220.196.211]:56206 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753151AbdLMSqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:46:31 -0500
Received: from [10.9.9.129] (helo=rmmprod07.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1ePC33-0000rF-4B; Wed, 13 Dec 2017 19:46:29 +0100
Received: from mail by rmmprod07.runbox with local (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1ePC33-000710-2u; Wed, 13 Dec 2017 19:46:29 +0100
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Received: from [Authenticated user (258406)] by runbox.com with http
 (RMM6); Wed, 13 Dec 2017 18:46:28 GMT
From:   "David A. Wheeler" <dwheeler@dwheeler.com>
To:     "Junio C Hamano" <gitster@pobox.com>
CC:     "Jacob Keller" <jacob.keller@gmail.com>,
        "git" <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
Date:   Wed, 13 Dec 2017 13:46:28 -0500 (EST)
X-Mailer: RMM6
In-Reply-To: <xmqq8te6y30t.fsf@gitster.mtv.corp.google.com>
Message-Id: <E1ePC33-000710-2u@rmmprod07.runbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Dec 2017 09:02:42 -0800, Junio C Hamano <gitster@pobox.com> wrote:
> .. But that is not the only thing the index does.  When "git merge"
> finds conflicting changes, it adds the contents for common, our and
> their variants to the index for the path.  This is quite different
> from how you use the index "as staging area"; the index is being
> used as the "merging area".  When "git clean" wants to see which
> paths it finds on the filesystem are not of interest, it consults
> the index, which acts as the list of paths that are of interest.

If the phrase "staging area" is consistently used *instead* of index,
there's no problem. E.g., "git clean consults the staging area"
conveys exactly the same information as "git clean consults the index"
when index == staging area.

The term "index" has too many *other* meanings.

--- David A. Wheeler
