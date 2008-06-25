From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 13:56:47 -0400
Message-ID: <20080625135647.wiohgih5hc0scgw0@intranet.digizenstudio.com>
References: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5uqS9FEDjCcuF>
	<willow-jeske-01l5xqJDFEDjCftd>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 19:58:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZFs-000342-Hb
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 19:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYFYR5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 13:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYFYR5I
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 13:57:08 -0400
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:53095
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752189AbYFYR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 13:57:07 -0400
Received: (qmail 7043 invoked from network); 25 Jun 2008 17:56:49 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 25 Jun 2008 17:56:48 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 5245010008B;
	Wed, 25 Jun 2008 17:56:48 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id INqktRjV62gN; Wed, 25 Jun 2008 13:56:47 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id A0FBF100A22; Wed, 25 Jun 2008 13:56:47 -0400 (EDT)
Received: from mailrelay1.private.geico.com (mailrelay1.private.geico.com
	[205.143.204.206]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Wed, 25 Jun 2008 13:56:47 -0400
In-Reply-To: <willow-jeske-01l5xqJDFEDjCftd>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86312>



Quoting David Jeske <jeske@google.com>:

> - add "checkout" to the git-gui history right-click menu, and make the
> danger of
> "reset --hard" more obvious and require a confirmation dialog (the gui
> equivilant of -f)

Is that really necessary?  The way it works now, when I choose "reset  
foo branch to here", a dialog prompts me to pick from the three reset  
modes, with 'Mixed' being the default. So I'd have to explicitly pick  
'Hard', which has a message "discards ALL local changes" right next to  
it.  If people are so conditioned to ignore that, I doubt it'll take  
very long for them to be conditioned to just automatically confirm the  
confirmation dialog.

The same applies to the command line as well I guess - if having to  
manually type "--hard" does not make one stop and think about what  
they are doing, I can hardly see how "--hard --force" would do any  
better.

Cheers.
-- 
Jing Xue
