X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: "Ryan Anderson" <rda@google.com>
Subject: Re: [PATCH 2/2] git-send-email: Read the default SMTP server from the GIT config file
Date: Sun, 29 Oct 2006 13:37:48 -0700
Message-ID: <87dcb0bd0610291237i1b4027a1p77bdcd84d38e05f4@mail.gmail.com>
References: <11621502993406-git-send-email-vsu@altlinux.ru>
	 <11621503001930-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:38:04 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=QKDjtME0tl1hT0aXy4YLM/DsqEhdqHrdjRJkeCgjPaupscoOD1F3PlzM4FRAyPUon
	j4ojY76oaZU8A1xntNojQ==
In-Reply-To: <11621503001930-git-send-email-vsu@altlinux.ru>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30457>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHPr-0007Ww-Hp for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965454AbWJ2Uh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965455AbWJ2Uh4
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:37:56 -0500
Received: from smtp-out.google.com ([216.239.45.12]:6843 "EHLO
 smtp-out.google.com") by vger.kernel.org with ESMTP id S965454AbWJ2Uh4 (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:37:56 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
 by smtp-out.google.com with ESMTP id k9TKbpLQ016344 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:37:51 -0800
Received: from nz-out-0102.google.com (nzcf1.prod.google.com [10.36.107.1])
 by zps37.corp.google.com with ESMTP id k9TKbmkp031311 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:37:49 -0800
Received: by nz-out-0102.google.com with SMTP id f1so1001571nzc for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:37:48 -0800 (PST)
Received: by 10.65.210.18 with SMTP id m18mr3311619qbq; Sun, 29 Oct 2006
 12:37:48 -0800 (PST)
Received: by 10.64.84.12 with HTTP; Sun, 29 Oct 2006 12:37:48 -0800 (PST)
To: "Sergey Vlasov" <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

On 10/29/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
> Make the default value for --smtp-server configurable through the
> 'sendemail.smtpserver' option in .git/config (or $HOME/.gitconfig).
>
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
