From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Location of git config on Windows
Date: Sun, 17 Aug 2014 17:40:56 -0400
Organization: PD Inc
Message-ID: <C9491BC51199409292463C10D606F256@black>
References: <ygfvbpqooog.fsf@corbe.net>
Reply-To: "Daniel Corbe" <corbe@corbe.net>, <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Daniel Corbe'" <corbe@corbe.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 23:41:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ8CI-000222-JR
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 23:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbaHQVlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 17:41:01 -0400
Received: from mail.pdinc.us ([67.90.184.27]:53529 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbaHQVlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2014 17:41:00 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s7HLevLl005045;
	Sun, 17 Aug 2014 17:40:57 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <ygfvbpqooog.fsf@corbe.net>
Thread-Index: Ac+6WYcwicgoBRv5RmSL8LZ0mAOI7wACaUDw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255376>

> -----Original Message-----
> From: Daniel Corbe
> Sent: Sunday, August 17, 2014 16:18
> 
> 
> I installed git on my Windows machine while it was connected to my
> corporate network.  It picked up on that fact and used a 
> mapped drive to
> store its configuration file.  
> 
> As a result, I cannot currently use git when disconnected from my
> network.  It throws the following error message: fatal: 
> unable to access
> 'Z:\/.config/git/config': Invalid argument

As a workaround, use subst command to map the Z: to another path on your system.

Depending on your OS and your git usage patterns you may have to perform the operation twice at both non-privilged and priviliged prompts.

Ex: 

 subst z: c:\Users\corbed\cached-z-drive

> 
> Obviously this value is stored in the registry somewhere 
> because I made
> an attempt to uninstall and reinstall git with the same results.  
> 
> Can someone give me some guidance here?
> 

-Jason 

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
