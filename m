Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908CCC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1B6024A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 15:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbhESP5M convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 May 2021 11:57:12 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:25833 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346802AbhESP5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 11:57:11 -0400
Date:   Wed, 19 May 2021 15:55:46 +0000
Authentication-Results: mail1.protonmail.ch; dkim=none
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   James Hughes <james@pyrosoftsolutions.co.uk>
Reply-To: James Hughes <james@pyrosoftsolutions.co.uk>
Subject: Fw: Tabs vs Spaces - Handle like CLRF?
Message-ID: <GJHGZLcAwaihWwWmzAt8bdOKWi8JiupQxVUXCs1FwKTOmn2yvWEjI8DDTmDaBA48lzz4pGQ-JmwmHKSrEU2NCpdyxXW-ExqZcgxKEmL-454=@pyrosoftsolutions.co.uk>
In-Reply-To: <2AzjQ7QDayLsqCbYQzwoZhJvvWKVAlBXStsOtYN03i41hVJcbYou0Je8Sxqec8UB0j0ZAfhKosA_IymlTez2X1J-voxUfG65EA-Zm0YWU10=@pyrosoftsolutions.co.uk>
References: <2AzjQ7QDayLsqCbYQzwoZhJvvWKVAlBXStsOtYN03i41hVJcbYou0Je8Sxqec8UB0j0ZAfhKosA_IymlTez2X1J-voxUfG65EA-Zm0YWU10=@pyrosoftsolutions.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We have the ability to automagically handle CLRF issues when we commit and check-out to handle different dev environments.

A lot of us will also hold religious beliefs as to which is the correct way to indent, tabs or spaces.

Since it's simple a whitespacing issue, is there any reason we couldn't handle this in a similar way to CLRF? Give devs the choice to commit with tabs/spaces as per their organisations requirements and then convert to their preference on checkout?

All the best,

James

