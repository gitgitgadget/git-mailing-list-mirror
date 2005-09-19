From: Peter Williams <pwil3058@bigpond.net.au>
Subject: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 12:15:04 +1000
Message-ID: <432E1F28.9060909@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 04:16:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHBBf-0003b1-Oq
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 04:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVISCPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 22:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVISCPJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 22:15:09 -0400
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:24393 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932293AbVISCPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 22:15:07 -0400
Received: from [192.168.0.4] (really [147.10.133.38])
          by omta04ps.mx.bigpond.com with ESMTP
          id <20050919021505.SGPJ5303.omta04ps.mx.bigpond.com@[192.168.0.4]>;
          Mon, 19 Sep 2005 02:15:05 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Sep 2005 02:15:05 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8828>

When I tried to install GIT 0.99.7 from the rpm package (on a Fedora 
Core 4 system) I got the following error message:

error: Failed dependencies:
         perl(String::ShellQuote) is needed by git-core-0.99.7-1.i386

So I installed String::ShellQuote from CPAN and tried again with the 
same result.  So I then rebuilt the rpm on my system and still got the 
same error message.  So I've installed the rpm using the --nodeps option 
but would like to test whether it is successfully finding 
String::ShellQuote.  Which command(s) would exercise this perl package?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
