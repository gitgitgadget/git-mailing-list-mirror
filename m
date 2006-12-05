X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] git-explain
Date: Tue, 05 Dec 2006 14:34:11 -0300
Message-ID: <200612051734.kB5HYBUs016133@laptop13.inf.utfsm.cl>
References: <peff@peff.net>
NNTP-Posting-Date: Tue, 5 Dec 2006 17:35:25 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Jeff King <peff@peff.net> 
   of "Tue, 05 Dec 2006 02:26:22 CDT." <20061205072622.GA21839@coredump.intra.peff.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 05 Dec 2006 14:34:14 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33359>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GreCO-0003hC-KY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 18:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968503AbWLERfM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 12:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968505AbWLERfM
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 12:35:12 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:54691 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S968503AbWLERfK (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 12:35:10 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kB5HYEi9030509
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Tue, 5
 Dec 2006 14:34:14 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kB5HYBUs016133; Tue, 5
 Dec 2006 14:34:12 -0300
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> wrote:

[...]

> As long as the safety valves don't come up _routinely_ in certain
> workflows, it seems OK to bypass them with a '-f' force switch. I
> suspect the best way to figure out if such workflows are in use is to
> put in the safety valves and see who complains; otherwise we're stuck
> with brainstorming workflows and deciding whether they make sense.

Problem is that nobody reads the manuals, next to nobody complains, and
when it doesn't work out via road A you try plan B. A might have been
exactly right, but it is blocked, and you'll never know if it is because of
fundamental reasons or by decree.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
