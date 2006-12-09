X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sat, 9 Dec 2006 23:24:10 +0100
Message-ID: <200612092324.11057.jnareb@gmail.com>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net> <elfbq4$tka$1@sea.gmane.org> <Pine.LNX.4.64.0612091418410.12895@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 22:21:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y6vL1TN9KUfcDAE//YziEaHkhjJQGVvmpVJsXkijMG0TFh2OPLTxj0mGAK1xv1RWD1Dxpv1LuTs9ttgZbMb7DF6ELe5g4CQx2IoTwwOSIVfr3yeowU/aOzRHSpU4CDAkzlY24NvoVfvOxDNRObzB+z/73FNnzMP9lw/1r9xTT5w=
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612091418410.12895@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33843>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtAZw-0001Dc-9U for gcvg-git@gmane.org; Sat, 09 Dec
 2006 23:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758738AbWLIWVx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 17:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbWLIWVx
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 17:21:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:49122 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1758738AbWLIWVx (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 17:21:53 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1031921uga for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 14:21:52 -0800 (PST)
Received: by 10.67.21.11 with SMTP id y11mr7473620ugi.1165702912244; Sat, 09
 Dec 2006 14:21:52 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id l40sm3855043ugc.2006.12.09.14.21.51; Sat, 09 Dec
 2006 14:21:51 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 9 Dec 2006, Jakub Narebski wrote:
>> 
>> I'm a bit uncomfortable about removing documentation to existing
>> (if no-op) option. I'd rather it stay.
> 
> How about mentioning it at the very end, under a "HYSTERICAL RAISINS" 
> header. That way it's documented, and people still know to ignore it.

"HISTORICAL NOTES". Yes, that is good idea.

Although for git-commit the option --only helps to explain what 
"git commit <path>..." does. So perhaps it should stay where it was.
-- 
Jakub Narebski
