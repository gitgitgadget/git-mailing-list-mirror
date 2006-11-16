X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: Git can't merge two identical move file operation
Date: Thu, 16 Nov 2006 18:14:55 +0600
Message-ID: <200611161814.55755.litvinov2004@gmail.com>
References: <6e1787fe0611160226r2d51d980t6899f1a1018b5fe5@mail.gmail.com> <7v1wo3bp99.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 12:15:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.8
In-Reply-To: <7v1wo3bp99.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31576>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkg9A-0000H6-6s for gcvg-git@gmane.org; Thu, 16 Nov
 2006 13:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030655AbWKPMPF convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 07:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031184AbWKPMPF
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 07:15:05 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:24498 "EHLO gw.ac-sw.com") by
 vger.kernel.org with ESMTP id S1030655AbWKPMPD convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 07:15:03 -0500
Received: from localhost (localhost [127.0.0.1]) by gw.ac-sw.com (Postfix)
 with ESMTP id 77825BF3A; Thu, 16 Nov 2006 18:14:59 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1]) by localhost (gw.ac-sw.com
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 05503-08; Thu, 16 Nov
 2006 18:14:58 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69]) by gw.ac-sw.com
 (Postfix) with ESMTP id 7A2DCBF37; Thu, 16 Nov 2006 18:14:58 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534) id 76D948D9E6AF; Thu,
 16 Nov 2006 18:14:58 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1]) by lan.ac-sw.lcl (Postfix)
 with ESMTP id 0725A8D9E6AD; Thu, 16 Nov 2006 18:14:56 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Thursday 16 November 2006 17:32 Junio C Hamano =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB(a):
> Could you try an exactly the same sequence except to make the
> initial contents of the file 'a' a bit more meaningful (I
> typically use COPYING file in git.git repository for something
> like this), by replacing the above "echo 1 > a ..." line with:
>
> 	$ cat COPYING >a && git add a && git commit -a -m '1'
>
> and see if it still breaks?  You do not need to change the later
> modification to the file (i.e. "echo 2 >>a"), but only the above
> single line change.

Wow, that a magic ! It works !

