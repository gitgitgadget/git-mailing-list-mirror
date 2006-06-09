From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 16:45:17 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF410507957893@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:45:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonrH-0006AL-MN
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWFIUpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965200AbWFIUpS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:45:18 -0400
Received: from ahmler1.mail.eds.com ([192.85.154.71]:18377 "EHLO
	ahmler1.mail.eds.com") by vger.kernel.org with ESMTP
	id S965171AbWFIUpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:45:16 -0400
Received: from ahmlir3.mail.eds.com (ahmlir3-2.mail.eds.com [192.85.154.133])
	by ahmler1.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59Kj6oY023998;
	Fri, 9 Jun 2006 16:45:08 -0400
Received: from ahmlir3.mail.eds.com (localhost [127.0.0.1])
	by ahmlir3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59Kil29011432;
	Fri, 9 Jun 2006 16:44:47 -0400
Received: from usahm011.amer.corp.eds.com ([130.175.214.152])
	by ahmlir3.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59KilHf011427;
	Fri, 9 Jun 2006 16:44:47 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm011.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 16:45:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaMAnHvyauXV3EFS2uNP2aJhPW0IwAAxZaQ
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 09 Jun 2006 20:45:18.0647 (UTC) FILETIME=[9E603C70:01C68C05]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21555>

I'm fairly familiar with SSH, but I don't know how to do this.  I just
did some man commands, didn't see anything there.  Can you give me a
pointer?


Mark Post 

-----Original Message-----
From: Junio C Hamano [mailto:junkio@cox.net] 
Sent: Friday, June 09, 2006 4:19 PM
To: Post, Mark K
Cc: git@vger.kernel.org
Subject: Re: Git-daemon messing up permissions for gitweb

"Post, Mark K" <mark.post@eds.com> writes:

> Martin is using git over SSH.  I have git-shell in /etc/passwd for his
> account.

Ah, then umask git-shell gets from sshd is too restrictive.
Loosen it and you will be fine.
