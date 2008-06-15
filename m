From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 15:53:04 +0200
Message-ID: <200806151553.04563.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
 <vpqej6ylx99.fsf@bauges.imag.fr> <200806151533.11742.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7shK-0006Op-G5
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559AbYFONyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757557AbYFONyQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:54:16 -0400
Received: from smtp.getmail.no ([84.208.20.33]:55749 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757552AbYFONyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:54:16 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I00L21BYDPX00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 15:54:13 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00HGMBWG3420@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 15:53:04 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I0096PBWGTS10@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 15:53:04 +0200 (CEST)
In-reply-to: <200806151533.11742.jnareb@gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85093>

On Sunday 15 June 2008, Jakub Narebski wrote:
> Or simply remove 'curl' from 'Requires:' header, and check if rpmbuild
> would pick up libcurl dependency, and if resulting RPM has libcurl as
> requirement.
>
> [...]
>
> As you can see rpmbuild picks up dependency on libcurl.
>
>
> From what I remember using automatically picked depndencies is
> preferred solution, even if I cannot find it in "Maximum RPM" book.

So the conclusion is that v1 of the patch is ok, IIUC.


Thanks,

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
