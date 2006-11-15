X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Sometimes "Failed to find remote refs" means "try git-fetch --no-tags"
Date: Wed, 15 Nov 2006 18:13:42 -0300
Message-ID: <200611152113.kAFLDgZO005651@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Wed, 15 Nov 2006 21:14:27 +0000 (UTC)
Cc: "Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Tue, 14 Nov 2006 20:05:07 -0800." <7vvelhs6bw.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 15 Nov 2006 18:13:42 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31500>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkS5F-0001OU-Ix for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161697AbWKOVNx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161693AbWKOVNw
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:13:52 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64186 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1161697AbWKOVNw (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:13:52 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kAFLDgHF010861
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Wed, 15
 Nov 2006 18:13:42 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAFLDgZO005651; Wed, 15
 Nov 2006 18:13:42 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:

[...]

> However "fetch --no-tags" from http upstream is a band-aid to
> hide that the upstream repository has stale info/refs, and I do
> not think we would want to encourage the band-aid.  Rather, the
> message should say "yell loudly at the repository owner" ;-).

I'm seeing this gem here:

  [vonbrand@laptop13 git]$ git pull
  fatal: read error (Connection reset by peer)
  Fetch failure: git://git.kernel.org/pub/scm/git/git.git
  fatal: read error (Connection reset by peer)
  Failed to find remote refs
  No changes.

Who shall I yell at? ;-)

Seriously, this is broken. I get 4 different error messages, plus a
(reassuring?) "No changes". Yes, I know this is what I'll see if the
machine is overloaded.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
