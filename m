X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Generating docu in 1.4.3.3.g01929
Date: Fri, 27 Oct 2006 14:26:53 -0300
Message-ID: <200610271726.k9RHQr0F024712@laptop13.inf.utfsm.cl>
NNTP-Posting-Date: Fri, 27 Oct 2006 17:57:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 27 Oct 2006 14:26:53 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30338>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdVTw-0005Zr-0b for gcvg-git@gmane.org; Fri, 27 Oct
 2006 19:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752343AbWJ0R04 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 13:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbWJ0R04
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 13:26:56 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33684 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1752343AbWJ0R0z (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 13:26:55 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9RHQref025546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 14:26:53 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9RHQr0F024712 for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 14:26:53 -0300
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I'm getting lots of these after today's pull:

asciidoc -b docbook -d manpage -f asciidoc.conf git-daemon.txt
xmlto -m callouts.xsl man git-daemon.xml
error : unterminated entity reference                
error : unterminated entity reference                
error : unterminated entity reference             ...
error : unterminated entity reference                
error : unterminated entity reference                
Writing git-daemon.1 for refentry
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
