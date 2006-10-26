X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Combined diff format documentation
Date: Wed, 25 Oct 2006 22:48:53 -0300
Message-ID: <200610260148.k9Q1mr99007511@laptop13.inf.utfsm.cl>
References: <junkio@cox.net>
NNTP-Posting-Date: Thu, 26 Oct 2006 02:07:47 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Wed, 25 Oct 2006 15:40:51 PDT." <7vejswkoi4.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.3 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 25 Oct 2006 23:07:24 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30129>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcuej-0000qc-GV for gcvg-git@gmane.org; Thu, 26 Oct
 2006 04:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965282AbWJZCHc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 22:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWJZCHc
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 22:07:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:8846 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S965282AbWJZCHb (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 22:07:31 -0400
Received: from laptop13.inf.utfsm.cl (pc-232-245-83-200.cm.vtr.net
 [200.83.245.232]) by inti.inf.utfsm.cl (8.13.7/8.13.1) with ESMTP id
 k9Q27OHn018994 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 25 Oct 2006 23:07:24 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9Q1mr99007511; Wed, 25
 Oct 2006 22:48:53 -0300
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

[...]

> > 5. Hunk header is also modified: in ordinary diff we have
> > ...
> >    It might be not obvoious that we have (number of parents + 1) '@'
> >    characters in chunk header for combined dif format.

> Correct.  This was done to prevent people from accidentally
> feeding it to "patch -p1".  In other words, we wanted to make it
> so obvious that it is _not_ a patch.

It isn't, really... perhaps it should be made /more/ obvious (not use @ but
e.g. &, ...)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
