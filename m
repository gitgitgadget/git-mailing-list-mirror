Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.5 required=5.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5250020179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbcFQR4I (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:56:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:35026 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318AbcFQR4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:56:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bDxzx-0002Il-Gr
	for git@vger.kernel.org; Fri, 17 Jun 2016 19:56:05 +0200
Received: from bl13-157-91.dsl.telepac.pt ([85.246.157.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 19:56:05 +0200
Received: from vascomalmeida by bl13-157-91.dsl.telepac.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 19:56:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
Date:	Fri, 17 Jun 2016 17:55:38 +0000 (UTC)
Message-ID: <loom.20160617T194406-197@post.gmane.org>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.246.157.91 (Mozilla/5.0 (X11; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster <at> pobox.com> writes:
> * va/i18n-even-more (2016-06-07) 38 commits
>  - i18n: branch: mark comment when editing branch description for translation
>  - i18n: unmark die messages for translation
>  - i18n: submodule: escape shell variables inside eval_gettext
>  - i18n: submodule: join strings marked for translation
>  - i18n: init-db: join message pieces
[snip]
>  - i18n: builtin/remote.c: fix mark for translation
>  - Merge branch 'jc/t2300-setup' into HEAD

Patch "i18n: init-db: join message pieces" breaks test
t0204-gettext-reencode-sanity.sh because it changes message id used in
Icelandic translation used on that test.
Please, don't merge this series, I'm going to send a re-roll (v5).

Discussion: http://mid.gmane.org/1562644.BnkjqA6nsN@linux-omuo

