X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael K. Edwards" <medwards.linux@gmail.com>
Subject: Re: [PATCH] Make "git checkout <branch> <path>" work when <path> is a directory.
Date: Thu, 16 Nov 2006 22:18:57 -0800
Message-ID: <f2b55d220611162218t3a752829hf922613c17fe326d@mail.gmail.com>
References: <f2b55d220611162149m719079f3ubdaeac43fe9798cb@mail.gmail.com>
	 <7vlkmavcai.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 06:19:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sAp58Y0To69rTfwd09aNt4lpQYIBQyGOqdG+QmsPL8pJySNu4QisMpkA3UqEJkj7EYVM2nWryh762aAS8HXVstlosAicMl6e11/hb0HA5dSwGlQgzkWjPBrcnHM9STCgxsnJpMLBUCE8Ev24YlDMvvGeknyFAR1yNdmtjeOx+iU=
In-Reply-To: <7vlkmavcai.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31669>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkx4S-0004sW-05 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 07:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162389AbWKQGS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 01:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162392AbWKQGS7
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 01:18:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:5651 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1162391AbWKQGS6
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 01:18:58 -0500
Received: by wx-out-0506.google.com with SMTP id s7so845642wxc for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 22:18:58 -0800 (PST)
Received: by 10.90.52.18 with SMTP id z18mr1179846agz.1163744337857; Thu, 16
 Nov 2006 22:18:57 -0800 (PST)
Received: by 10.90.25.4 with HTTP; Thu, 16 Nov 2006 22:18:57 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Ah.  Missed that patch, which is indeed a superset of mine.  Looks
like you committed it on branch "next"; is that a personal
experimental branch, or the integration branch against which patches
should be generated?

Cheers,
