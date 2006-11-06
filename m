X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] git-pickaxe -C -C -C
Date: Mon, 06 Nov 2006 13:46:17 -0300
Message-ID: <200611061646.kA6GkHgi009592@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Mon, 6 Nov 2006 17:00:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Mon, 06 Nov 2006 01:08:10 -0800." <7vmz75djt1.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 06 Nov 2006 13:46:18 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31018>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh7cN-0006Wb-0l for gcvg-git@gmane.org; Mon, 06 Nov
 2006 17:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753402AbWKFQqb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 11:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbWKFQqb
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 11:46:31 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:2029 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1753402AbWKFQqa (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 11:46:30 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kA6GkINd012462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Mon, 6
 Nov 2006 13:46:18 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kA6GkHgi009592; Mon, 6
 Nov 2006 13:46:17 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Three -C options makes the command to look for copied lines from _any_
> existing file in the parent commit, not just changed files.

IMHO, this is horrible UI.

-C        is one thing
-C -C     is another
-C -C -C  is still another?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
