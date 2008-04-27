From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Problem with send-email and readline.pm
Date: Sun, 27 Apr 2008 11:04:53 -0400
Message-ID: <95D4B41B-2D89-47CF-85A1-ED00D2439884@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 17:05:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq8Rm-0006SU-FX
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 17:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbYD0PE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYD0PE4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 11:04:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:34730 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbYD0PE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 11:04:56 -0400
Received: from [192.168.1.7] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 398601FFC39B
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 15:04:51 +0000 (UTC)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80448>

Every time I try to use `git send-email`, I get a pile of errors  
inside readline.pm.  Can someone figure out why this is happening?  I  
do not get errors when I use cpan, which also uses readline.pm AFAIK.

$ git send-email 000*
0001-Use-perl-instead-of-tac.patch
0002-rebase-i-Use-in-expr-command-instead-of-match.patch
0003-Fix-t3404-assumption-that-wc-l-does-not-use-white.patch
substr outside of string at /Library/Perl/5.8.8/Term/ReadLine/ 
readline.pm line 1976.
Use of uninitialized value in length at /Library/Perl/5.8.8/Term/ 
ReadLine/readline.pm line 1785.
Use of uninitialized value in length at /Library/Perl/5.8.8/Term/ 
ReadLine/readline.pm line 1791.
Use of uninitialized value in substr at /Library/Perl/5.8.8/Term/ 
ReadLine/readline.pm line 1802.
Who should the emails appear to be from? [Brian Gernhardt <benji@silverinsanity.com 
 >] Use of uninitialized value in length at /Library/Perl/5.8.8/Term/ 
ReadLine/readline.pm line 2046.
