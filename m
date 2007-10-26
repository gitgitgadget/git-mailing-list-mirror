From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: How to run git-gui always in English?
Date: Fri, 26 Oct 2007 09:00:32 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710260857210.3542@perkele.intern.softwolves.pp.se>
References: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 10:00:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlK7i-000392-Cy
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 10:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbXJZIAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 04:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbXJZIAm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 04:00:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36550 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXJZIAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 04:00:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JQI0080XE93E300@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 26 Oct 2007 10:00:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQI00HHZE8TNW20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 26 Oct 2007 10:00:29 +0200 (CEST)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQI00ELWE8TFAA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 26 Oct 2007 10:00:29 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id 4567A2FC18; Fri,
 26 Oct 2007 10:00:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 428802FC0C; Fri, 26 Oct 2007 09:00:32 +0100 (CET)
In-reply-to: <CCAD0DE0-65D4-4FEC-B02F-658010FECD04@zib.de>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62402>

Steffen Prohaska:

> There are a lot of efforts going on to localize git-gui, including 
> technical terms like "push". Personally I don't understand what this 
> should be useful for. The command is called "git push"s. So, why should it 
> be named differently in the gui.

Not that I agree that "push" is a technical word, but perhaps you have a 
point. Why should there be such words in the GUI to start with? It's a GUI, 
trying to abstract away the command line. Why not have a button "Send" or a 
menu entry "Send changes to server", mimicing the "git push" command line 
option? Using command line names or showing protocol data directly in a 
user-oriented GUI is most often a bad idea.

Or perhaps what we need is an actual translation from "gitish" to English, 
which would have

msgid "Push"
msgstr "Send changes to server"

?

-- 
\\// Peter - http://www.softwolves.pp.se/
