X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Make logAllRefUpdates true by default
Date: Sun, 26 Nov 2006 20:05:15 -0300
Message-ID: <200611262305.kAQN5FoO016231@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Sun, 26 Nov 2006 23:07:04 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sun, 26 Nov 2006 12:12:59 -0800." <7vhcwmt19w.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 92:13:15 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 26 Nov 2006 20:06:12 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32369>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoT5F-0003TY-J1 for gcvg-git@gmane.org; Mon, 27 Nov
 2006 00:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753946AbWKZXGT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 18:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbWKZXGT
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 18:06:19 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19628 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1753872AbWKZXGS (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 18:06:18 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kAQN64Ha000570 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Sun, 26 Nov 2006 20:06:12 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAQN5FoO016231; Sun, 26
 Nov 2006 20:05:34 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:

[...]

> Having thought about all the above, I think the event to create
> distribution/synchronization point repositories are rare enough
> and the simplest and cleanest way might be to make it default
> and add a --without-reflog option to the command, and forget
> about the guessing.

Looks sanest. I hate stuff that tries to outguess me by being "smart" (part
of the reason I love Unixy systems).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
