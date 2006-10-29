X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
From: "Ryan Anderson" <rda@google.com>
Subject: Re: [PATCH 1/2] git-send-email: Document support for local sendmail instead of SMTP server
Date: Sun, 29 Oct 2006 13:34:27 -0700
Message-ID: <87dcb0bd0610291234j587ebadcxf61e2f61777435c6@mail.gmail.com>
References: <11621502993406-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:34:48 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=vILkGQkIfw2vHxh5EMlrtIVCMjJnZYLOu4kTcGepovUXSnzdTmpFHyyA7Hc5ycCcD
	zRrKxqSxL5CDzRZwDdJFA==
In-Reply-To: <11621502993406-git-send-email-vsu@altlinux.ru>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30455>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHMb-0006ht-S7 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030191AbWJ2Uef (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030190AbWJ2Uef
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:34:35 -0500
Received: from smtp-out.google.com ([216.239.45.12]:51130 "EHLO
 smtp-out.google.com") by vger.kernel.org with ESMTP id S1030189AbWJ2Uee
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:34:34 -0500
Received: from zps76.corp.google.com (zps76.corp.google.com [172.25.146.76])
 by smtp-out.google.com with ESMTP id k9TKYUKm018273 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:34:30 -0800
Received: from nz-out-0102.google.com (nzfl1.prod.google.com [10.36.188.1])
 by zps76.corp.google.com with ESMTP id k9TKYSOR032116 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:34:28 -0800
Received: by nz-out-0102.google.com with SMTP id l1so1035201nzf for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:34:28 -0800 (PST)
Received: by 10.65.180.7 with SMTP id h7mr3258570qbp; Sun, 29 Oct 2006
 12:34:27 -0800 (PST)
Received: by 10.64.84.12 with HTTP; Sun, 29 Oct 2006 12:34:27 -0800 (PST)
To: "Sergey Vlasov" <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

On 10/29/06, Sergey Vlasov <vsu@altlinux.ru> wrote:
> Fix the --smtp-server option description to match reality.
>
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Acked-by: Ryan Anderson <rda@google.com> (or ryan@michonline.com,
