Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDE41F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 12:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbdBDMQY (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 07:16:24 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:45229 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbdBDMQY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 07:16:24 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id ZzGPcNOrXcpskZzGPcDPFv; Sat, 04 Feb 2017 12:16:22 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=anyJmfQTAAAA:8 a=8niYkdW3nxWBxzSIflEA:9 a=QEXdDO2ut3YA:10
 a=1R2eHFOlrNcA:10 a=6kGIvZw6iX1k4Y-7sg4_:22 a=avl4LiGQNoF5OB0DmCJ7:22
 a=YJ_ntbLOlx1v6PCnmBeL:22
Message-ID: <E363F108ABEF45CB99C2C721A90B5EA2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Duy Nguyen" <pclouds@gmail.com>,
        "Jacob Keller" <jacob.e.keller@intel.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        "Jacob Keller" <jacob.keller@gmail.com>
References: <20170203202833.17666-1-jacob.e.keller@intel.com> <CACsJy8B2gyw7RQBh6Qfm5HxOyKWted-0ZeDfd2_U3MvWCO1HEA@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add an example of how to split a commit into two
Date:   Sat, 4 Feb 2017 12:16:22 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfCYfR39uA259Rc6sFDKAUzEyZw50ec28htYZA8fH8GOm4Uy36LUwBUKeGmdaRE7yaPzD3DAJo3jX/QG7EEKQe/HQ+DbX29Xu4+jqIzNibVY1jsJT9IGB
 olGJwwBCIcODyotKwH7xRw5RBBf+Y0tzRaW0ZRTX5FXOHEUG7FQVoKw8QqI1EuyPKHp3dBWPI6tnU/bJg+XXQ0oGGdo7RceBkgdKMrrsT0XPTxSr6TGrjMOL
 /h6u9iQYKfWqB4Hn52d6egXG6Jhl5t+YZZWmUWtFZVY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Duy Nguyen" <pclouds@gmail.com>
> On Sat, Feb 4, 2017 at 3:28 AM, Jacob Keller <jacob.e.keller@intel.com> 
> wrote:
>> +------------
>> +$ git reset HEAD^                           <1>
>
> It may be a good idea to add -N here, so that 'add -p' can pick up the
> new files if they are added in HEAD.

When looking at the man page for `reset` [1] it implies that `-N` requires 
`--mixed` also to be given. Is that correct? Or could the man page be 
clearer?

>
>> +$ git add -p                                <2>
> -- 
> Duy
>
Philip
[1] https://git-scm.com/docs/git-reset 

