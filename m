Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E9D1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 20:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbeIKBcW (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 21:32:22 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:49778
        "EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbeIKBcW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Sep 2018 21:32:22 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id zSv7ftYoXeCBnzSv9fFbTn; Mon, 10 Sep 2018 13:36:32 -0700
Date:   Mon, 10 Sep 2018 23:36:28 +0300
From:   Max Kirillov <max@max630.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Max Kirillov <max@max630.net>,
        Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180910203628.GF20545@jessie.local>
References: <20180908001940.GB225427@aiede.svl.corp.google.com>
 <20180908054224.21856-1-max@max630.net>
 <20180910051748.GA55941@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910051748.GA55941@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfHEWDfPWJGEezKxKzOwTUbqj6nr6uSBZLWAHpGY72IMPeS2Fl9aGXZsEqfIPCTmEMM5oYTs5XKJf44A7HPbZTi5Vl6mm30foyzemDFrm05wISdgOkx4y
 IQy3KXGfScB9/0v+RJCnzwiVjRc1FZUbk4XEByJVy6veE4GqYWXQV5lmq3zEtMLgbaexryDktvQt/NT9F59VymwYOVUIcs6YEYRVRgI1qqfhVQw8DZWkn1VR
 5CtwRtaDtgvT1yRXPGZvGYHFkjM31ke+s75vHXrr+1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 10:17:48PM -0700, Jonathan Nieder wrote:
> From: Max Kirillov <max@max630.net>
> Subject: http-backend test: make empty CONTENT_LENGTH test more realistic

Thank you, yes, this is what should have left
