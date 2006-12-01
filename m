X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Diffs from CVS keyword expansion
Date: Fri, 1 Dec 2006 08:06:03 +0100
Message-ID: <17775.54363.376000.140259@lapjr.intranet.kiel.bmiag.de>
References: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 07:06:31 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <9e4733910611301956l6f64b01ftee46971a18e3467b@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32856>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq2Ta-00031J-8C for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759264AbWLAHGX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759267AbWLAHGX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:06:23 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:29326 "EHLO
 meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1759264AbWLAHGW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 02:06:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 meriadoc.bmiag.de (Postfix) with ESMTP id 5281F3AECF; Fri,  1 Dec 2006
 08:06:19 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1]) by localhost (meriadoc
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 03742-05; Fri, 1 Dec
 2006 08:06:19 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de
 [10.130.2.1]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) by meriadoc.bmiag.de (Postfix) with
 ESMTP id 589553AECC; Fri,  1 Dec 2006 08:06:16 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id C61483AE94; Fri,  1
 Dec 2006 08:06:16 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1]) by localhost
 (eotheod [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 09280-07; Fri,
 1 Dec 2006 08:06:13 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 2C6F93AE8F; Fri,  1
 Dec 2006 08:06:10 +0100 (CET)
To: "Jon Smirl" <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Jon Smirl writes:
 > Anyone have a nice script for suppressing diffs caused by CVS keyword
 > expansion when someone checked the kernel sources into CVS?

I usually just say (with GNU diff)

  diff -I $$ ...

which is crude, but should be enough to get rid of the hunks listed by
you.

You might also want -x CVS if you have the metadata files.
