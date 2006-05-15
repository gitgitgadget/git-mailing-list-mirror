From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 14:52:36 -0700
Message-ID: <20060515215236.GA31164@h4x0r5.com>
References: <1147660345772-git-send-email-normalperson@yhbt.net> <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net> <20060515092704.GB6855@localdomain> <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net> <20060515210110.GR32076@h4x0r5.com> <7vhd3rgfey.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 23:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffl0i-0003DZ-3I
	for gcvg-git@gmane.org; Mon, 15 May 2006 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWEOVxt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWEOVxt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 17:53:49 -0400
Received: from h4x0r5.com ([70.85.31.202]:43793 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932330AbWEOVxt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 17:53:49 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FfkzV-0000Y5-1d; Mon, 15 May 2006 14:52:37 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd3rgfey.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20088>

On Mon, May 15, 2006 at 02:13:25PM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > I think, in practice, that /usr/lib/sendmail will exist anywhere you hve
> > something running on port 25, at least on unixy machines.  In my
> > searches at an old job, that appeared to be the canonical place to call
> > sendmail from, and every MTA appears to provide an appropriate binary
> > there.
> >
> > So, I'm not overly worried about it.
> 
> exim, postfix and friends?

At least as packaged by Debian and Ubuntu, exim and postfix both fit
that rule.

It's just that there is no other canonical name for the binary that
provides the functionality, so everyone steals the name.

> I used to know somebody who port-forwarded 25/tcp to central
> smtp server from smaller machines in her intranet installation,
> but I would say that is rare.  I am not worried about it either;
> I just wanted to make sure _somebody_ thought the potential
> issues through and agreed with the change the patch makes.

Fair enough.
