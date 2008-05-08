From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Wed, 7 May 2008 19:17:09 -0700
Message-ID: <2F346570-C474-49A2-AB38-4D64792D1DB0@midwinter.com>
References: <20080508013956.GA24956@midwinter.com> <7v63tpd0fj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 04:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtvhq-0001L5-Vm
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 04:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756825AbYEHCRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 22:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbYEHCRM
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 22:17:12 -0400
Received: from tater.midwinter.com ([216.32.86.90]:49068 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbYEHCRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 22:17:10 -0400
Received: (qmail 27251 invoked from network); 8 May 2008 02:17:09 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=lOaetGTejG5SAvM1IzLXSEbCqJ1FJKvB9tOg6BzWF4Nhnt53RcbXjBcRCqI3xzDx  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 8 May 2008 02:17:09 -0000
In-Reply-To: <7v63tpd0fj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81500>

On May 7, 2008, at 6:55 PM, Junio C Hamano wrote:
> Being able to have a shared git-svn managed git repository that  
> mirrors
> svn is something people have asked often enough, but the recommended
> practice has always been for each to have his own copy.

Which is still sort of the case here -- it would be even better if you  
could share the revision map, but that's a bigger change. All this  
really does is let you skip talking to the svn server for update  
operations.

> Although I do not use git-svn heavily myself, I like this addition.   
> We
> would probably want to update the in-tree doc to cover a recommended
> pattern of interacting multiple git repositories with a single svn
> repository on the other side?

I'll write something up. This is still pretty new (it was an itch I  
had time to scratch today) so I honestly don't know yet what the  
optimal workflow is going to be. But at the very least I can document  
my setup as an example of something that works.

-Steve
