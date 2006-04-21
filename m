From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RESEND] [PATCH] fix gitk with lots of tags
Date: Fri, 21 Apr 2006 21:48:29 +1000
Message-ID: <17480.50829.466038.316769@cargo.ozlabs.ibm.com>
References: <20060406203637.GA15009@blackbean.org>
	<20060418180614.GA31543@blackbean.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 21 14:07:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWuPV-0002bQ-SX
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 14:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDUMGu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Apr 2006 08:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWDUMGt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Apr 2006 08:06:49 -0400
Received: from ozlabs.org ([203.10.76.45]:23707 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932095AbWDUMGt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Apr 2006 08:06:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id EF804679F8; Fri, 21 Apr 2006 22:06:44 +1000 (EST)
To: Jim Radford <radford@blackbean.org>
In-Reply-To: <20060418180614.GA31543@blackbean.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19019>

Jim Radford writes:

> I've gotten no reposnse from Paul on this patch[1].  If it seems ok to
> you, would you mind putting it in your queue for him?  I hate to see
> gitk die with "argument list too long" messages.  They're so 640k.

The reservation I have about this is that I need to be able to tell
the file/directory names from the tags/heads/SHA1 IDs.  After the pass
through git-rev-parse it's easy; I just take the things that match
^[a-f0-9]{40}$ as IDs and the rest as file/directory names or
switches.

Junio, did you tell me some time ago about a flag to git-rev-parse
that spits out just the file/directory names?  What was it again?

> [1] Maybe he judges people by the color of their IP address?

As in _black_bean.org? :)

>     Then again, he could just be busy.

Yeah.  Or just returned from international travel, or something like
that. :)

Paul.
