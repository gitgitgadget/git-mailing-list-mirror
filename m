Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 3886 invoked by uid 107); 9 Feb 2009 17:50:16 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 09 Feb 2009 12:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZBIRtw (ORCPT <rfc822;peff@peff.net>);
	Mon, 9 Feb 2009 12:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbZBIRtw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 12:49:52 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:45356 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZBIRtv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 12:49:51 -0500
Received: by ewy14 with SMTP id 14so2672394ewy.13
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 09:49:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=QYbXPJv8UtUFHszhUeqNFNPp9wxKZxvqk4UTk6Bxk04=;
        b=Xh+C7l3XJhfr6htu/4ho43K3Z30eCmyT05fk0cNNvH+Z3aF3gTC07EnoI5Rih7depN
         XkSCemm4sZEoZk4oWjFxNSWwCwjQennNqXI+Ivycn0yRsMJHXYP1BH+Zmh1xEPKLPUTi
         UTgEeH3MVFNcmIz1PRZnexcj+Jybf15yQkTzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OYfOHrOYuOOoNRmD/DKPM/1p9r/A2e1Voq12VvoLpCs3xVZADosLh07SKuOsm1+hGT
         UOd8phrTDWuiQnJJHgdxdUwkJbnbuNMtb+vSOFJQ7htep+4BQkd9qBMJctJX+NAaA7dw
         QI81w3ktUYIWm7x3GkFTw68Kibu0fS8rZFLk4=
Received: by 10.210.27.20 with SMTP id a20mr4005343eba.166.1234201789182;
        Mon, 09 Feb 2009 09:49:49 -0800 (PST)
Received: from localhost (nat.ct.ingv.it [193.206.223.100])
        by mx.google.com with ESMTPS id 7sm4505782eyb.38.2009.02.09.09.49.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 09:49:48 -0800 (PST)
From:	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:	git@vger.kernel.org
Cc:	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	bill lam <cbill.lam@gmail.com>
Subject: Re: tool and worktree
Date:	Mon,  9 Feb 2009 18:49:41 +0100
Message-Id: <1234201781-5537-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 1.6.2.rc0.173.g5e148
In-Reply-To: <20090209161907.GA953@neumann>
References: <20090209161907.GA953@neumann>
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sunday 08 February 2009 20:25, Shawn O. Pearce wrote:
> bill lam <cbill.lam@gmail.com> wrote:
>> I track /etc using a config
>> 
>> [core]
>> 	repositoryformatversion = 0
>> 	filemode = true
>> 	bare = false
>> 	worktree = /etc
>> 	logAllRefUpdates = true
>> 	excludesfile =
>> 
>> But that can not be handled by tools,
>> 
>> git gui : cannot use funny .git directory .
> 
> If someone sends patches for git-gui, maybe.  This use case of
> different repository and worktree isn't very common for git-gui
> so it doesn't support it.

I came across the same problem. I also sent a tentative patchset to
solve the problem about 12 hours ago:

http://thread.gmane.org/gmane.comp.version-control.git/109035

-- 
Giuseppe "Oblomov" Bilotta
