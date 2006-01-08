From: Marco Costalba <mcostalba@yahoo.it>
Subject: [ANNOUNCE] qgit-1.1rc1
Date: Sun, 08 Jan 2006 13:20:22 +0100
Message-ID: <43C10386.708@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jan 08 13:20:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvZXK-0005HQ-AG
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 13:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWAHMUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 07:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbWAHMUc
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 07:20:32 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:16062 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1752618AbWAHMUb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 07:20:31 -0500
Received: (qmail 34265 invoked from network); 8 Jan 2006 12:20:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=UTqAZKVJnQ+E9S6eKjUxfSDbYkuLdkyqpbqNmZGmNxBvIa6iq1OYRLb6lC3qtg79zXu55Aru+H/8iVFBJGeG6d3YnD92CSdI/SibWMtoMuOXh79e4/Pjxs1X2doXO5kEV6ifwuYx45JL2rebE+PL6sRlQV6y36usIbq9FNh8zCE=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.90.70 with plain)
  by smtp106.mail.sc5.yahoo.com with SMTP; 8 Jan 2006 12:20:28 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14317>

Hi everybody,

   this should be qgit-1.0.1 but due to some new and quite intrusive
changes I chose for 1.1rc1 although the final 1.1 is still far away.

Important bugs, found after 1.0 was out, are the broken link navigation
in commit description window and the broken filter by SHA sub string
in main view.

Among new features added, to note is support for file content copy
with annotation line headers automatically removed and support for
toggling between to list all files or just interesting ones in merge
revisions, the pruning algorithm is the same of gitk with only
implementation differences, so the results should be the same.

There is also a 20% speed up in start-up times (tested on my box with
different clock settings) due to a new double buffering data loader.

What I consider the coolest feature, although not visible ;-) , is the
introduction of an extended  exception system to resolve in a general,
and IMHO clean way, stability problems due to races.
See exception_manager.txt in base directory if interested.

Page with all the download links is, as usual,
http://digilander.libero.it/mcostalba/

You will found installation instructions and detailed change logs in
README and ChangeLog file respectively.


Marco
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
