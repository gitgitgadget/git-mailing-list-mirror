Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBFEB203EA
	for <e@80x24.org>; Sun, 11 Dec 2016 14:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbcLKOvj (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 09:51:39 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:50341 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbcLKOvj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 09:51:39 -0500
Received: from PhilipOakley ([92.22.22.210])
        by smtp.talktalk.net with SMTP
        id G5TUc8SJEgKstG5TUcLhcZ; Sun, 11 Dec 2016 14:51:37 +0000
X-Originating-IP: [92.22.22.210]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=ml+yzTU89BnYyX12/wy+jA==:117
 a=ml+yzTU89BnYyX12/wy+jA==:17 a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8
 a=fQaStDAdELSubqCPqxoA:9 a=wPNLvfGTeEIA:10 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <913EC5FA0C2B4452AF027A84786F08BB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Klaus Ethgen" <Klaus@Ethgen.ch>, <git@vger.kernel.org>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch> <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net> <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org> <20161210093230.26q7fxcrs2cpll6g@ikki.ethgen.ch> <alpine.DEB.2.20.1612101918040.23160@virtualbox> <20161211110208.642unp7c2i653sav@ikki.ethgen.ch>
Subject: Re: [BUG] Colon in remote urls
Date:   Sun, 11 Dec 2016 14:51:36 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfBysRni2Me43OE8kEogDvONMKwbw/LU5bWf5ei3WqIV2yQDGsgCaBGqKqEO3PXivBDqh0zIWd0K44SWCLcqgMhC0gV1Rq5uSkwi3EsglX+V0N8hGL/VZ
 CwSlN9KMcac7mWn7YH/iUIQKXm9KjxQ72YRpF1p0+UruyQuElrgpsA4qvEvIR6OoliF2JAuJNgIrOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Klaus Ethgen" <Klaus@Ethgen.ch>
To: <git@vger.kernel.org>
> Am Sa den 10. Dez 2016 um 19:18 schrieb Johannes Schindelin:
>> On Sat, 10 Dec 2016, Klaus Ethgen wrote:
>> > Am Fr den  9. Dez 2016 um 22:32 schrieb Johannes Sixt:
>> > > There are too many systems out there that use a backslash in path 
>> > > names. I
>> > > don't think it is wise to use it also as the quoting character.
>> > Well, the minority, I believe. And only the minority where the command
>> > line git is used anywhere.
>>
>> Please provide evidence for such bold assumptions.
>
> How is it "bold" to see that the majority of widows users does not use
> or even like command line tools. And as git is command line tool (most
> of them), users does use third party tools instead of the original.
>
> I know companies where the "developers" doesn't even know of the
> existent of a git command line use. They look with owe when they see
> that I use a shell to use git.
>
Hasn't this drifted a little off topic. The issue was typeable characters in 
URLs and how that affects the accessibility of various paths.

We (Git) should be avoiding lock-in to particular systems where possible.

--

Philip

