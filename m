From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Allow update hooks to update refs on their own
Date: Wed, 28 Nov 2007 12:16:27 -0800
Message-ID: <C1321BD5-8F6B-47F9-9BDB-C2BF819D6F17@midwinter.com>
References: <7vmysy5h5k.fsf@gitster.siamese.dyndns.org> <20071128194159.GA25977@midwinter.com> <20071128194919.GC11396@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTKz-0007Yt-6i
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbXK1UQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 15:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbXK1UQ3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:16:29 -0500
Received: from tater.midwinter.com ([216.32.86.90]:56868 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751626AbXK1UQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 15:16:29 -0500
Received: (qmail 28456 invoked from network); 28 Nov 2007 20:16:28 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=pxnfk2JXwxFwJOJTcgIku/W+cD/D+kzecLCWdorT5rkw5bPJTNjRFp5fw2nLkgEN  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 28 Nov 2007 20:16:28 -0000
In-Reply-To: <20071128194919.GC11396@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66420>


On Nov 28, 2007, at 11:49 AM, Jeff King wrote:

> Hrm, this is going to have nasty conflicts with 'next', which already
> does the remote ref matching. I think the best way to implement this
> would probably be on top of the jk/send-pack topic in next, and add a
> new REF_STATUS_REMOTE_CHANGED status type.

Ah, yes, I see what you mean. Okay, please ignore my latest patch -- I  
will redo it on top of "next" later today/tonight.

Well, actually, I would still like opinions on one thing: What do  
people think of having git-push do a fetch if the remote side changes  
a ref to point to a revision that doesn't exist locally? Is there a  
situation where you'd ever want to *not* do that?

-Steve
