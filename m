Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80171FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdALXNe convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 12 Jan 2017 18:13:34 -0500
Received: from mout02.posteo.de ([185.67.36.66]:57147 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbdALXNd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:13:33 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4539520A0B
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 00:13:31 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 3v01lZ62jdzyb2
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 00:13:30 +0100 (CET)
From:   Manuel Ullmann <ullman.alias@posteo.de>
To:     git@vger.kernel.org
Subject: Bug report: Documentation error in git-bisect man description
Date:   Fri, 13 Jan 2017 00:02:42 +0100
Message-ID: <87r347swz1.fsf@sonnengebleicht.fritz.box>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

there is a mistake in the git-bisect description.
The second paragraph of it says ‘the terms "old" and "new" can be used
in place of "good" and "bad"’. So from a logical point of view the
description part stating the usage syntax should be:

git bisect (bad|good) [<rev>]
git bisect (old|new) [<rev>...]

instead of

git bisect (bad|new) [<rev>]
git bisect (good|old) [<rev>...]

Checked man page version of 2.11.0, but it is in my local 2.10.2 git as well.

Best regards,
Manuel
