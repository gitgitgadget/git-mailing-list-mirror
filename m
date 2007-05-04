From: Bryan Larsen <bryan@larsen.st>
Subject: Re: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 23:30:27 -0400
Message-ID: <463AA8D3.8080000@larsen.st>
References: <463A6930.8090603@larsen.st>	<7vfy6dzf25.fsf@assigned-by-dhcp.cox.net> <463A71D7.5060506@larsen.st> <7vy7k5xvt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 05:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjoTR-0002bA-Lw
	for gcvg-git@gmane.org; Fri, 04 May 2007 05:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767646AbXEDD2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 23:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767652AbXEDD2a
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 23:28:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:25891 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767561AbXEDD23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 23:28:29 -0400
Received: by nz-out-0506.google.com with SMTP id o1so741163nzf
        for <git@vger.kernel.org>; Thu, 03 May 2007 20:28:28 -0700 (PDT)
Received: by 10.64.250.7 with SMTP id x7mr4304321qbh.1178249308148;
        Thu, 03 May 2007 20:28:28 -0700 (PDT)
Received: from ?192.168.1.91? ( [206.248.190.98])
        by mx.google.com with ESMTP id e16sm2146265qba.2007.05.03.20.28.27;
        Thu, 03 May 2007 20:28:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <7vy7k5xvt4.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46128>


> 
> Are they any other issues on MacOS?  For example, gitweb.cgi is
> built by replacing the shebang with $(PERL_PATH); I presume that
> you already are successfully working around the whitespace in
> the pathname with your "env perl" on MacOS?
> 

I haven't used gitweb.cgi.  All the tests run, including the 
git-send-email test.  (t4200 patch was sent a couple of days ago).  I 
know there are several people using git very successfully from MacPorts.

The biggest problem in OS X has been that the BSD versions of standard 
programs such as xargs and sed are used instead of the GNU versions. 
There are currently no problems of that sort.

cheers,
Bryan
