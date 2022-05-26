Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B6CC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiEZOPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiEZOPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:15:17 -0400
Received: from silly.haxx.se (silly.haxx.se [159.253.31.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9151BC1ED0
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:15:14 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id D4DFC62063; Thu, 26 May 2022 16:15:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id D215E7D5B0;
        Thu, 26 May 2022 16:15:09 +0200 (CEST)
Date:   Thu, 26 May 2022 16:15:09 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
In-Reply-To: <xmqqa6b6j04b.fsf@gitster.g>
Message-ID: <1452491s-8415-9182-4015-q22sn63234p2@unkk.fr>
References: <cover.1651859773.git.git@grubix.eu> <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu> <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g> <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet> <xmqqr14jluu4.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet> <xmqqa6b7lrw6.fsf@gitster.g> <q274s3nn-pp38-4sn-53ro-o2q63447r341@unkk.fr> <xmqqa6b6j04b.fsf@gitster.g>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 May 2022, Junio C Hamano wrote:

> It always is nice to have the authority/expert readily answering our stupid 
> questions ;-)

I probably miss a few here and there, but I do keep an eye out for curl 
related subjects where I can help. After all, I'm git fan and user myself.

-- 

  / daniel.haxx.se
