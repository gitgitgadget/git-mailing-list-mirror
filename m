X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitweb.cgi and git instaweb
Date: Fri, 27 Oct 2006 00:19:59 +0530
Message-ID: <ehr00n$vbe$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 18:51:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.131.106
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30257>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdAJr-0002g2-7w for gcvg-git@gmane.org; Thu, 26 Oct
 2006 20:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423707AbWJZSvI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWJZSvI
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 14:51:08 -0400
Received: from main.gmane.org ([80.91.229.2]:8931 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423707AbWJZSvF (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 14:51:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GdAJC-0002YL-1T for git@vger.kernel.org; Thu, 26 Oct 2006 20:50:30 +0200
Received: from 59.92.131.106 ([59.92.131.106]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26
 Oct 2006 20:50:30 +0200
Received: from aneesh.kumar by 59.92.131.106 with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006 20:50:30
 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I am getting errors as below with git instaweb.


kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ git instaweb
2006-10-27 00:12:56: (log.c.75) server started
kvaneesh@satan:/home/opensource/vanilla/linux-2.6-git$ [Fri Oct 27 00:12:57 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
[Fri Oct 27 00:13:21 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
[Fri Oct 27 00:13:37 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
[Fri Oct 27 00:13:58 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
[Fri Oct 27 00:14:08 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
[Fri Oct 27 00:14:08 2006] gitweb.cgi: Use of uninitialized value in open at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 1118.
fatal: ambiguous argument '': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
[Fri Oct 27 00:14:16 2006] gitweb.cgi: "our" variable $stylesheet masks earlier declaration in same scope at /home/opensource/vanilla/linux-2.6-git/.git/gitweb/gitweb.cgi line 59.
