X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-cvsimport feature request
Date: Tue, 12 Dec 2006 19:42:21 +0700
Message-ID: <fcaeb9bf0612120442v4cd03a5fq44625fafed4217b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:42:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IUZsE4QSXdMsChorBPamPV86GPlz6pLYH0MaYfQEzOKckcK9VYrXoLth4TcWwmGVdaxAZV7M8yAD4YPVwaK55yru7AFGXB0lT2unJ7JHnoQMNLxMCiXCXyk3us5p+YrVtGtEWlnAh38WCApqL2Mk1r8CcLWbj3ch2DoxIBq3008=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34093>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6xr-0002AL-Nx for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751259AbWLLMmX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWLLMmX
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:42:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:17700 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751259AbWLLMmW (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:42:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1650635uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:42:22 -0800 (PST)
Received: by 10.78.171.13 with SMTP id t13mr2518426hue.1165927341779; Tue, 12
 Dec 2006 04:42:21 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Tue, 12 Dec 2006 04:42:21 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Well it's not really a feature but just for convenience. I suggest
after git-cvsimport successfully imports from CVS, it creates cvsup
alias with given arguments. Later if I want to update from CVS, I only
need to "git cvsup" instead of typing the the same command with full
of arguments again.
-- 
