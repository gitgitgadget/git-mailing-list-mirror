X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: New improved formatting of chunk header in diff
Date: Wed, 8 Nov 2006 21:58:43 +0100
Message-ID: <200611082158.43652.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <200611081800.16001.jnareb@gmail.com> <7vfyctsmbm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 20:58:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pWPjDnBhnXQeIitezBrH6omXb5FO850YLqR04q0qtkirx5SVqx1nnAQLV/chwzLU668JlA7UK22HEGrNdk7fN6o9n5Imx01LD66pVkYRPmL+QsP1VstH0vngQTRxK2QT6SguhOa/7zw8QcnY5nsqxDTlAQcVB995EgBD0S1uF7A=
User-Agent: KMail/1.9.3
In-Reply-To: <7vfyctsmbm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31158>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhuUh-0008EZ-Lt for gcvg-git@gmane.org; Wed, 08 Nov
 2006 21:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423727AbWKHU54 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 15:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWKHU54
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 15:57:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:9381 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932763AbWKHU5z
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 15:57:55 -0500
Received: by ug-out-1314.google.com with SMTP id m3so23540ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 12:57:54 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr125780ugh.1163019474196; Wed, 08
 Nov 2006 12:57:54 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id 72sm7565990ugb.2006.11.08.12.57.53; Wed, 08 Nov
 2006 12:57:53 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> This regresses on hunks of form "@@ -n +m,l @@" and friends, so
> I dropped it for now.

O.K. This one introduced new feature, and wasn't needed for earlier 
accepted patch (output empty patches) to have sense. And it is rc1 
phase...

By the way, where I can find proper specifiction of unified diff format? 
Do I understand correctly that bot from and to ranges can be without 
number of lines part if it simplifies to 0?
-- 
Jakub Narebski
