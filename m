X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Documentation/git-commit.txt
Date: Sat, 09 Dec 2006 21:11:56 -0300
Message-ID: <200612100011.kBA0BuTo028252@laptop13.inf.utfsm.cl>
References: <alan@chandlerfamily.org.uk>
NNTP-Posting-Date: Sun, 10 Dec 2006 00:12:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Alan Chandler <alan@chandlerfamily.org.uk> 
   of "Fri, 08 Dec 2006 22:56:45 -0000." <200612082256.45456.alan@chandlerfamily.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 00:02:12 by milter-greylist-3.0rc7 (pincoya.inf.utfsm.cl [200.1.19.3]); Sat, 09 Dec 2006 21:11:56 -0300 (CLST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33853>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtCIb-0002ly-SA for gcvg-git@gmane.org; Sun, 10 Dec
 2006 01:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757734AbWLJAL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 19:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759846AbWLJAL7
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 19:11:59 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:1811 "EHLO
 pincoya.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1757734AbWLJAL6 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 19:11:58 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by pincoya.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id
 kBA0BuvJ003265 for <git@vger.kernel.org>; Sat, 9 Dec 2006 21:11:56 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBA0BuTo028252; Sat, 9
 Dec 2006 21:11:56 -0300
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> wrote:

[...]

> How about the following wording here
> 
> Instead of staging the content of each file immediately after changing 
> it, you can wait until you have completed all the changes you want to 
> make and then use the `-a` option to tell `git commit` to look for all 
> changes to the content it is tracking and commit it automatically. That 
                 ^^^^^^^
                 files
                 (or "files whose contents")

> is, this example ...

[Yes, git tracks the contents of files, but it also has a list of files
 whose contents it is tracking]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
