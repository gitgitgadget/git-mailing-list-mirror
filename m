X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Why perl-Git RPM doesn't come with Git.pm docs (with Git.3pm.gz)?
Date: Thu, 26 Oct 2006 12:07:32 +0200
Organization: At home
Message-ID: <ehq1bs$n0a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 26 Oct 2006 10:07:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30176>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd28v-0000XM-Gy for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423118AbWJZKHM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423126AbWJZKHM
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:07:12 -0400
Received: from main.gmane.org ([80.91.229.2]:24737 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423118AbWJZKHL (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:07:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd28i-0000VV-SP for git@vger.kernel.org; Thu, 26 Oct 2006 12:07:08 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 12:07:08 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 12:07:08 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have just installed git 1.4.3.3, compiling it from source rpm (SRPMS)
because I have Fedora Core 4 based distribution (Aurox 11.1) and i386 rpm
is built for Fedora Core 5 via rpmbuild --rebuild, and I do wonder why
perl-Git module has only
  /usr/lib/perl5/vendor_perl/5.8.6/Git.pm
in it, and doesn't have Git.pm documentation
  /usr/share/man/man3/Git.3pm.gz

I'm also curious wy I had to install perl-Error (Error module), if
I compiled git myself. Ahhh... I see, perl(Error) is in BuildRequires
in git.spec (BuildRequires?).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

