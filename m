Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.9 required=3.0 tests=AWL,BAYES_20,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_SBL,RP_MATCHES_RCVD,STOX_REPLY_TYPE,
	STOX_REPLY_TYPE_WITHOUT_QUOTES,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 9423 invoked by uid 107); 4 Oct 2009 08:38:35 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 04:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZJDIbw (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbZJDIbv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 04:31:51 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:38705 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbZJDIbu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 04:31:50 -0400
Received: by bwz6 with SMTP id 6so1883434bwz.37
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 01:31:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=Y5gJZUjq6FDaDeNB3JAeyx8DLF3s4TmDnKT1sehHlfA=;
        b=piw3InYPzg4C7+sSjn9EG1WqIwjBpyRFYqt8oGnbQHDLxYHUMCbg6Al4smRe0CHYQm
         CY8mmldscEq7vtbK0PBe4vf/QOxFXGT1gEl5t3QYazEtXte5sQhcQTzm6fVCAh4hiR4M
         I6DtOGiL3D3TnXaxYmVOxhGVaETWWwwv1r1uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=F7GbfIgethblgC2Y3jColD6MwfkZ8T6w013EYmJ2Vi0i6kDmQneVobzy0Bd5aPbHHf
         u0gPFHj4grytVFjdLZqYQPuYkdtWh0C/ovOBq+lN1tfO8eOAs8YXor9ks1OzbPPLm5fW
         b8T6jH7sIpIaQA5sFrzlFToFVH6WtkT/y6fxQ=
Received: by 10.204.156.24 with SMTP id u24mr2830314bkw.172.1254645073452;
        Sun, 04 Oct 2009 01:31:13 -0700 (PDT)
Received: from teddy ([81.180.162.194])
        by mx.google.com with ESMTPS id d13sm4629404fka.22.2009.10.04.01.31.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 01:31:12 -0700 (PDT)
Message-ID: <8E72DAAF9F8E4024BB819F3F83CCFC79@teddy>
From:	=?utf-8?B?T2N0YXZpYW4gUsOixZ9uacWjxIM=?= <orasnita@gmail.com>
To:	<git@vger.kernel.org>
Subject: previous references
Date:	Sun, 4 Oct 2009 11:31:10 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5843
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Are the following commands specifying the same reference?

prompt> git log -1 HEAD^^^ ... log entry ... 
prompt> git log -1 HEAD^~2 ... log entry ... 
prompt> git log -1 HEAD~1^^ ... log entry ... 
prompt> git log -1 HEAD~3 ... log entry ... 

Thank you.

Octavian

