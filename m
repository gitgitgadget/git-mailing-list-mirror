X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: git-*arch* in git-arch rpm
Date: Tue, 24 Oct 2006 20:02:11 +0000
Message-ID: <20061024200211.17221.qmail@9f622d681978b5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 20:02:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30008>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcSTB-0002yh-Qg for gcvg-git@gmane.org; Tue, 24 Oct
 2006 22:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161218AbWJXUBu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 16:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbWJXUBu
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 16:01:50 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:53408 "HELO
 a.mx.smarden.org") by vger.kernel.org with SMTP id S1161218AbWJXUBu (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 16:01:50 -0400
Received: (qmail 17222 invoked by uid 1000); 24 Oct 2006 20:02:11 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi, there're two programs in the git-arch rpm that shouldn't be there:

 $ rpm -qlp git-arch-1.4.3.2-1.i386.rpm 
 /usr/bin/git-archimport
 /usr/bin/git-archive
 /usr/bin/git-upload-archive
 /usr/share/doc/git-arch-1.4.3.2
 /usr/share/doc/git-arch-1.4.3.2/git-archimport.html
 /usr/share/doc/git-arch-1.4.3.2/git-archimport.txt
 /usr/share/doc/git-arch-1.4.3.2/git-archive.html
 /usr/share/doc/git-arch-1.4.3.2/git-archive.txt
 /usr/share/doc/git-arch-1.4.3.2/git-upload-archive.html
 /usr/share/doc/git-arch-1.4.3.2/git-upload-archive.txt
 /usr/share/man/man1/git-archimport.1.gz
 /usr/share/man/man1/git-archive.1.gz
 /usr/share/man/man1/git-upload-archive.1.gz
 $ 

