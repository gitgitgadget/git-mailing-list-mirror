X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_ADSP_DISCARD,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Mon, 18 Dec 2006 15:19:33 +0100
Message-ID: <17798.41845.872000.413512@lapjr.intranet.kiel.bmiag.de>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
	<46a038f90612132155rc987a9cs6a4fa33dd4c882c6@mail.gmail.com>
	<0ML25U-1GvWC81sjR-0001UB@mrelayeu.kundenserver.de>
	<Pine.LNX.4.63.0612161227510.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<46a038f90612170221u4c3b5c2asef378d3d4e159ba7@mail.gmail.com>
	<906f26060612170633h50e3e974h3b84f1829e546278@mail.gmail.com>
	<17797.35177.550000.996862@lapjr.intranet.kiel.bmiag.de>
	<Pine.LNX.4.63.0612172027400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<906f26060612171736pab766b7t15a36d4d3fc7e85f@mail.gmail.com>
	<Pine.LNX.4.63.0612181435100.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 18 Dec 2006 23:30:48 +0000 (UTC)
Cc: Stefano Spinucci <virgo977virgo@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"Florian v. Savigny" <lorian@fsavigny.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612181435100.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34762>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwJLQ-00081x-7O for gcvg-git@gmane.org; Mon, 18 Dec
 2006 15:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754052AbWLROTr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 09:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754056AbWLROTr
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 09:19:47 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:38853 "EHLO
 meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1754052AbWLROTq (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 09:19:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 meriadoc.bmiag.de (Postfix) with ESMTP id 4F9D23AED8; Mon, 18 Dec 2006
 15:19:44 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1]) by localhost (meriadoc
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13611-07; Mon, 18 Dec
 2006 15:19:44 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de
 [10.130.2.1]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) by meriadoc.bmiag.de (Postfix) with
 ESMTP id 45E793AED2; Mon, 18 Dec 2006 15:19:42 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 745D73ADC8; Mon, 18
 Dec 2006 15:19:42 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1]) by localhost
 (eotheod [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 32379-06; Mon,
 18 Dec 2006 15:19:39 +0100 (CET)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182]) by
 eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 3558F3ADC6; Mon, 18
 Dec 2006 15:19:36 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin writes:
 > On Mon, 18 Dec 2006, Stefano Spinucci wrote:
 > > On 12/17/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
 > > > I am sure that there are more problems with it. BTW the problem stems from
 > > > Windows having _no_ equivalent to fork().
 > > 
 > > if you are sure that there are more problems with using MMAP, shouldn't 
 > > NO_MMAP be commented better in the Makefile and in INSTALL, pointing out 
 > > to use it always on cygwin ???
 > 
 > I argued for that a long time ago, but there were a couple "works-for-me"s 
 > and I just shut up.

It would be nice to have test cases documenting known failures. Then
people could decide whether these cases are important for their work,
since I don't think it's actually possible to loose data this way.

Personally I've been unsuccessful in trying to recreate failures, but
that is probably just an indication of my inability to use git
correctly:-)
