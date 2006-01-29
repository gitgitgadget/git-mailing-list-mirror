From: Marco Costalba <mcostalba@yahoo.it>
Subject: Possible git-rev-list bug
Date: Sun, 29 Jan 2006 10:41:51 +0100
Message-ID: <43DC8DDF.6080904@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 10:42:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F394U-0000Nw-SM
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 10:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWA2Jl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 04:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWA2Jl7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 04:41:59 -0500
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:52904 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750800AbWA2Jl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 04:41:58 -0500
Received: (qmail 82760 invoked from network); 29 Jan 2006 09:41:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=x6UQD4nCzLgrSNox2z9kISjOQJhfevCmBk9GcgcMMGfe/kvf4TeV7OHCnbyzGmIndyrYJpg4fbc38mJKiQsK4fUVvphaH2OOV3y6Pypo92FZqT3EC73inrCNcGkTPrPxLFgpHBcdLp02X2f9NDNBuwmzBNZoZd0WwurXo2Z574w=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.33.177 with plain)
  by smtp101.mail.sc5.yahoo.com with SMTP; 29 Jan 2006 09:41:54 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.4.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15209>

In today git archive:

$ git-rev-list --max-count=1 --parents addafaf92eeb86033da91323d0d3ad7a496dae83 -- rev-list.c
addafaf92eeb86033da91323d0d3ad7a496dae83 d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b 93b74bca86f59b8df410b6fd4803b88ee0f304bf d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b 
d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b 3815f423ae39bf774de3c268c6d3e3b72128a4e5

We have the same parent (d8f6b342ae200b2eb72e2f81afea7fe0d41aec0b) multiple times.

This behaviour causes a wrong graph in qgit and brakes gitk (try 'qgit rev-list.c'  or
'gitk rev-list.c' and click on first merge commit).


Please confirm if it's a rev-list bug or it's a 'feature' ;-) in the latter case I will fix qgit.


Marco

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
