X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deleting binary file
Date: Thu, 09 Nov 2006 10:52:17 +0100
Organization: At home
Message-ID: <eiutmq$ncp$1@sea.gmane.org>
References: <1d592d70611090147p6f10f921s740e3cc19cb67c09@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 9 Nov 2006 09:52:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31187>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6ZU-0005yy-GY for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754826AbWKIJvl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 04:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbWKIJvl
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:51:41 -0500
Received: from main.gmane.org ([80.91.229.2]:37587 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754826AbWKIJvk (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:51:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gi6ZJ-0005wh-FC for git@vger.kernel.org; Thu, 09 Nov 2006 10:51:33 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 10:51:33 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 09 Nov 2006
 10:51:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Kirill Shutemov wrote:

> Why can't I delete binary file via patch?
> 
>$ git-init-db
> defaulting to local storage area
>$ cp /bin/sh .
>$ git-add sh
>$ git-commit -m 'test'
> Committing initial tree efa3b1f9fdc4cdb8aab5bf869f580664a52ac04c
>$ git-rm sh
> rm 'sh'
>$ rm sh
>$ git-commit -m 'test'
>$ git-format-patch HEAD^

What happens if you use --binary option here?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

