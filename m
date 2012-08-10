From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Installing GIT Server
Date: Fri, 10 Aug 2012 12:31:16 -0400
Message-ID: <0075195F-B1E6-4358-80F2-91F6A75445BF@kellerfarm.com>
References: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Neeraj Mathawan <NEERAJM@YAHOO.COM>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szt8b-0004eV-2E
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191Ab2HJRgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:36:36 -0400
Received: from leia.tchmachines.com ([208.76.86.38]:45939 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615Ab2HJRgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2012 13:36:35 -0400
X-Greylist: delayed 3917 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Aug 2012 13:36:35 EDT
Received: from d28-23-39-26.dim.wideopenwest.com ([23.28.26.39]:40604 helo=[192.168.0.198])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.77)
	(envelope-from <andrew@kellerfarm.com>)
	id 1Szs7D-00044K-Vo; Fri, 10 Aug 2012 12:31:12 -0400
In-Reply-To: <41E7B95B-70F0-4DCD-ADCE-213BCE4B2FAC@YAHOO.COM>
X-Mailer: Apple Mail (2.1084)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203237>

On Aug 10, 2012, at 11:17 AM, Neeraj Mathawan wrote:

> We have decided to use GIT for a huge government implementation, I am looking for some help with installation of GIT SERVER. 
> 
> Few questions:-
> 
> 1. What platform to choose - UNIX, MAC or Windows? We have lot of windows 2008 installations, and if there are no trade off's we would love to use Windows 2008 server and install the GIT server compoent there.
> 
> 2. Once that is done, the client machine mostly MAC OSX development machines...will they be able to connect using SSH or file share?
> 
> Can someone help me with this?

Unix, Linux, and Mac OS X all work equally well.  Haven't tried git-daemon on Windows, however I have noticed that Git in general is much slower on Windows and the default memory limit is low, which can cause problems with large repositories.  I'd guess that git-daemon might have similar problems.

In the past, I have had problems with programs with programs in general accessing shared resources on file shares.  I've had permission problems, update problems, and corruption problems when the network fails.  I have had much better success with SSH.

~ Andrew Keller
