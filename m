X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: How to prepend data when formatting patches ?
Date: Thu, 30 Nov 2006 16:00:14 +0000
Message-ID: <tnx1wnk53ht.fsf@arm.com>
References: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 16:01:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com> (Francis
 Moreau's message of "Thu, 30 Nov 2006 15:16:22 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 30 Nov 2006 16:00:30.0260 (UTC) FILETIME=[A8C7CF40:01C71498]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32760>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoKl-0002rH-Ek for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030625AbWK3QAU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030636AbWK3QAU
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:00:20 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49318 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1030625AbWK3QAS (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006
 11:00:18 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kAUG0FYo012060;
 Thu, 30 Nov 2006 16:00:16 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Thu, 30 Nov 2006
 16:00:30 +0000
To: "Francis Moreau" <francis.moro@gmail.com>
Sender: git-owner@vger.kernel.org

"Francis Moreau" <francis.moro@gmail.com> wrote:
> I'd like to add to all patchs created by "git-format-patch" command
> the following line:
>
>         From: xxx.yyy <foo@crazy.com>

In the headers or in the message body? StGIT adds this line
automatically in the message body (and recently only if the sender is
different from the patch author but the templates are flexible and can
be changed).

-- 
