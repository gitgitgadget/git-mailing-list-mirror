Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72A31FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 10:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcF1K1e (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 06:27:34 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43577 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752770AbcF1K04 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 06:26:56 -0400
X-AuditID: 12074412-487ff700000008c6-28-577250d76cea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4D.AD.02246.7D052775; Tue, 28 Jun 2016 06:26:33 -0400 (EDT)
Received: from [192.168.69.130] (p508EAE14.dip0.t-ipconnect.de [80.142.174.20])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5SAQSRr009112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jun 2016 06:26:29 -0400
Subject: Re: [PATCH v1] git-p4: place temporary refs used for branch import
 under ref/git-p4-tmp
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
Cc:	luke@diamand.org, vitor.hda@gmail.com
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <577250D4.3010106@alum.mit.edu>
Date:	Tue, 28 Jun 2016 12:26:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
MIME-Version: 1.0
In-Reply-To: <1467012398-7357-1-git-send-email-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqHszoCjcYMJieYuuK91MFo8fLmG1
	OD7rGrvFwmdXmBxYPB5c2cLosXPWXXaPz5vkApijuG2SEkvKgjPT8/TtErgz1l9pYy3YyVqx
	pfsVewPjNpYuRk4OCQETiVvTWtm6GLk4hAS2Mkqse/6cCSQhJHCeSWLzTTcQW1ggSeLu57+M
	ILaIgKHEgcvP2CFq3CX+H9wLVs8soCnx8+4JsKFsAroSi3qaweK8AtoSPSuXsYLYLAKqEs13
	u8FsUYEQifPrtrJC1AhKnJz5BKyXU8BDYvGtH1Az9SR2XP/FCmHLS2x/O4d5AiP/LCQts5CU
	zUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSLgK7WBcf1LuEKMA
	B6MSD++OusJwIdbEsuLK3EOMkhxMSqK8CxiKwoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8F7w
	B8rxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwigLjUkiwKDU9tSIt
	M6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFJHxxcCYBEnxAO0VB2nnLS5IzAWKQrSeYjTmWPDj
	9lomjiP7761lEmLJy89LlRLnzQM5UQCkNKM0D24RLFG9YhQH+luYlx1kIA8wycHNewW0iglo
	FWt1PsiqkkSElFQD4/67jeLMkyUPtiqrxeYvnmcy8/xJN7e8bOE/fHl5rtM3p2y6e1zl4+Gq
	xTWXpyw1WPdgmt4fx6mxP5Z/e/WCp/zb5vmLp1zo1bunUnT0Q4jExPwj2bdqOz8f+hs91+2g
	vujZX3n37kz+IdX9cEm2QfNpy4MirUs38qTVVm3LqIlYkfrQ9kLqPTMlluKMREMt5qLiRACI
	EpiVLwMAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 06/27/2016 09:26 AM, larsxschneider@gmail.com wrote:
> Git-P4 used to place temporary refs under "git-p4-tmp". Since 3da1f37
> Git checks that all refs are placed under "ref". Instruct Git-P4 to
> place temporary refs under "ref/git-p4-tmp". There are no backwards
> compatibility considerations as these refs are transient.
> 
> All refs under "ref" are shared across all worktrees. This is not
> desired for temporary Git-P4 refs and will be adressed in a later patch.

Thanks for working on this, Lars! Your change looks about what I would
expect, and hits the three places in the source where the string
`git-p4-tmp` appears, so it seems like a very plausible fix.

Michael

