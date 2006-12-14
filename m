X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 19:12:31 -0300
Message-ID: <200612142212.kBEMCVeu032626@laptop13.inf.utfsm.cl>
References: <spearce@spearce.org>
NNTP-Posting-Date: Thu, 14 Dec 2006 22:55:55 +0000 (UTC)
Cc: Geert Bosch <bosch@adacore.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2589 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 17:55:45 EST
In-Reply-To: Message from Shawn Pearce <spearce@spearce.org> 
   of "Thu, 14 Dec 2006 14:46:36 CDT." <20061214194636.GO1747@spearce.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Recipient e-mail whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 14 Dec 2006 19:12:35 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34423>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzUU-0005xF-Mc for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:55:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750726AbWLNWzr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWLNWzr
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:55:47 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:58829 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1750726AbWLNWzr (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:55:47 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kBEMCXPQ021267 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO) for <git@vger.kernel.org>; Thu, 14 Dec 2006 19:12:34 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBEMCVeu032626; Thu, 14
 Dec 2006 19:12:31 -0300
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:

[...]

> And yet I get good delta compression on a number of ZIP formatted
> files which don't get good additional zlib compression (<3%).

.zip is something like a tar of the compressed files, if the files inside
the archive don't change, the deltas will be small.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
