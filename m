Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE201F424
	for <e@80x24.org>; Thu, 21 Dec 2017 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752244AbdLUQxw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 11:53:52 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:58859 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbdLUQxv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 11:53:51 -0500
Received: from ms15nec.int.opaltelecom.net ([10.103.251.115])
        by smtp.talktalk.net with SMTP
        id S46PebqJSCbAZS46PeKFCF; Thu, 21 Dec 2017 16:53:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513875229;
        bh=P6dHCNfRsLNnK7k0AS0axLtP6u+HGE/kLCKVjFutpKE=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=jqHnUR0A1RPFdfmNOhDJ3HrhVEkSDpKGcxJTCDGW9OQokbXPPVCAFBPEa1xnydhSC
         SBbCkhdihk1qRQU+nEFuwa8OXzrPuK4422Qmy+AjIUaAivhBRdPMpzxE4c7Lw0EFuf
         4l+ptOtrXoTc+1cka76EWdtN8wfig/WB4CaCh/+s=
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=tnicxU7Iw+JYU+lE0AfxUQ==:117
 a=wcpVQE0W4qLcfTC1YB9uxQ==:17 a=9Ui_ZxslVaMA:10 a=IkcTkHD0fZMA:10
 a=ocR9PWop10UA:10 a=pGLkceISAAAA:8 a=evINK-nbAAAA:8 a=VwQbUJbxAAAA:8
 a=DEnLnnEnsJj8IsAKaLkA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=AjGcO6oz07-iQ99wixmX:22
Received: from (82.10.83.37) by webmail.talktalk.co.uk;  Thu, 21 Dec 2017 16:53:49 +0000
Message-ID: <25620501.1048091513875229038.JavaMail.defaultUser@defaultHost>
Date:   Thu, 21 Dec 2017 16:53:49 +0000 (GMT)
From:   "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
To:     <kaartic.sivaraam@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <1513794792.9785.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
         <20171213114621.30250-1-phillip.wood@talktalk.net> <1513794792.9785.2.camel@gmail.com>
X-Originating-IP: 82.10.83.37
X-Username: phillip.wood@talktalk.net
X-CMAE-Envelope: MS4wfHsT1vDxMFtlNtL08X85SCCFQKA+svlFw5CFUZd1zVPQ1dRJBvwAUywrHOD2dZJh7mtBFKzjL2olmIydBRDXlfj+tBZ4Vvm5FIZ1Vksv+GQ7MPDVFKh3
 qWlOcJCqz8sIFEJV5blf3AvcMxya6igutdeRXF7cPRTMoAxIcePWFEYpo6DtsOfAtfuwq58VtuTaGqlLl6pB6OPANWDIfMIaLPXs9091yjm1N2fd+9tfO4RY
 CbkgqaGv3NzIRSF9vXSVI9Dp7y4gtGqPTQJDVBFThB6+zLppuhhp8mTfiUex4Ukyo0Pw5jxPwxMOGgG8C5n/PA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>----Original Message----
>From: kaartic.sivaraam@gmail.com
>Date: 20/12/2017 18:33 
>To: "Phillip Wood"<phillip.wood@dunelm.org.uk>, "Git Mailing List"
<git@vger.kernel.org>
>Cc: "Johannes Schindelin"<Johannes.Schindelin@gmx.de>
>Subj: Error in `git&#39;: free(): invalid pointer (was Re: [PATCH] 
sequencer: improve config handling)
>
>I recently encountered that error when trying to do an interactive
>rebase after using filter-branch to remove a file completely in a
>repository. I bisected this issue which pointed at this patch. I'm not
>sure how it is related as I'm not too familiar with the sequencer 
code.
>I could help in case any specific information is needed. As a first
>step, I've posted the output of "strace /mnt/Source//Git/git rebase -i
>HEAD~10" below.
>


Hm, There is a problem with sequencer_remove_state() which does 

free(opts->gpg_sign)

however unless a gpg key was given on the commandline, opts->gpg is 
initialized to "" which is statically allocated. 

This untested diff should fix that, but I'm not sure if you're problem 
is related to it (I'm visiting relatives so don't have much time for 
working at the moment. also I'm on webmail so apologies if the patch is 
mangled)

Best Wishes

Phillip
>-- 8< --

diff --git a/sequencer.c b/sequencer.c
index 3bc487573..115ceba91 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -160,7 +160,7 @@ static int git_sequencer_config(const char *k, 
const char *v, void *cb)
        }
 
        if (!strcmp(k, "commit.gpgsign")) {
-               opts->gpg_sign = git_config_bool(k, v) ? "" : NULL;
+               opts->gpg_sign = git_config_bool(k, v) ? strdup("") : 
NULL;
                return 0;
        }



