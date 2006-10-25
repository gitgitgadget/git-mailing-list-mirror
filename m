X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] xdiff: Match GNU diff behaviour when deciding hunk comment worthiness of lines
Date: Tue, 24 Oct 2006 22:33:28 -0300
Message-ID: <200610250133.k9P1XSVf006467@laptop13.inf.utfsm.cl>
References: <pasky@suse.cz>
NNTP-Posting-Date: Wed, 25 Oct 2006 01:33:51 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Petr Baudis <pasky@suse.cz> 
   of "Wed, 25 Oct 2006 02:28:55 +0200." <20061025002855.4738.1088.stgit@machine.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 24 Oct 2006 22:33:30 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30023>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcXeO-00062D-Cd for gcvg-git@gmane.org; Wed, 25 Oct
 2006 03:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422848AbWJYBdp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422852AbWJYBdp
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 21:33:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19382 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1422848AbWJYBdo (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 21:33:44 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 k9P1XTrC004736 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Tue, 24 Oct 2006 22:33:30 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9P1XSVf006467; Tue, 24
 Oct 2006 22:33:28 -0300
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> This removes the '#' and '(' tests and adds a '$' test instead although I
> have no idea what it is actually good for - but hey, if that's what GNU
> diff does...

$ starts a shell (or Perl) variable...

> Pasky only went and did as Junio sayeth.

Horst adds a guesse...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
