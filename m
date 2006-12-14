X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 20:52:08 -0300
Message-ID: <200612142352.kBENq8Ie002603@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Thu, 14 Dec 2006 23:52:53 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Wed, 13 Dec 2006 15:31:12 -0800." <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 14 Dec 2006 20:52:08 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34443>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0Na-0004Ne-DP for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752004AbWLNXwY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWLNXwY
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:52:24 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33155 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752004AbWLNXwX (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:52:23 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kBENq79G030757 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 14 Dec 2006 20:52:08 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBENq8Ie002603; Thu, 14
 Dec 2006 20:52:08 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:

[...]

> In general the principle ought to be not to say anything if the
> command does exactly what it was told to do successfully, unless
> the operation is expected to take longer than other normal
> commands in the git suite, or something that is rarely used.

Nodz. Just hoary Unix tradition.

> Perhaps under "[user] expert" control.

Nope. You'd be surprised what kind of people consider themselves
"experts"... I'd prefer adding -v/--verbose flags to all commands (if
nothing else, for symmetry's sake), have a '[default] --verbose' controlling
this across the board (perhaps also '[default "command"] --verbose'), with
'[default]' setting default switches.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
