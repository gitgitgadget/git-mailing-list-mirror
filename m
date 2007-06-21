From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Wed, 20 Jun 2007 20:19:33 -0700
Message-ID: <4679EE45.2080605@midwinter.com>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave O'Neill <dmo@roaringpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 05:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1DCt-0007sx-G9
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 05:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXFUDTi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 23:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbXFUDTi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 23:19:38 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:35734
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1752786AbXFUDTh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 23:19:37 -0400
Received: (qmail 6524 invoked from network); 21 Jun 2007 03:19:37 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=I/FKuIjb9uP4Y9VQfcpGOjDSaSxpOddPPEHm2kuhfEF4rvoqnrk/KDITvpPgAS3x  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Jun 2007 03:19:37 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <1182392095394-git-send-email-dmo@roaringpenguin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50587>

Dave O'Neill wrote:
> SVK likes to begin all commit messages with a line of the format:
>    r12345@hostname: user | YYYY-MM-DD HH:MM:SS -ZZZZ
> which makes the import desperately ugly in git.  This adds a -k option to move
> this extra SVK commit line to the end of the commit message, rather than
> keeping it at the beginning.
>   

Any chance of applying this to git-svn instead? There has been talk of 
deprecating git-svnimport since git-svn now does everything 
git-svnimport does, and more. (If you believe that's not the case, 
please describe what you're doing with git-svnimport that you can't do 
with git-svn.)

-Steve
