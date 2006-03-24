From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 19:06:40 -0500
Message-ID: <20060324000640.GK26071@mythryan2.michonline.com>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <20060323210215.GH26071@mythryan2.michonline.com> <7vacbg4t48.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 01:07:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMZpt-0007yz-Jj
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWCXAHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 19:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbWCXAHY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 19:07:24 -0500
Received: from mail.autoweb.net ([198.172.237.26]:58521 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1422741AbWCXAHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 19:07:23 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FMZpp-0008HS-R4; Thu, 23 Mar 2006 19:07:23 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FMZpp-0006oS-FC; Thu, 23 Mar 2006 19:07:21 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FMZpU-0006dr-V0; Thu, 23 Mar 2006 19:07:00 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacbg4t48.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17888>

On Thu, Mar 23, 2006 at 03:51:51PM -0800, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > Git has taken a very pragmatic approach, in that the goal has been "What
> > is the smallest number of concepts we can create that let us solve the
> > problem, even if we occassionally have to make some tradeoffs?"
> > (Thinking of rename detection there, mostly.)
> 
> I do not see it as a tradeoff not to record renames.  It _is_ a
> feature.

Oh, I don't disagree.

What I was getting at was that not recording renames means we've traded
off a little bit of speed and maybe accuracy, when we care about
renames, for a simpler, better implementation.

It's a tradeoff, but one that was very much the right decision, IMO.

-- 

Ryan Anderson
  sometimes Pug Majere
