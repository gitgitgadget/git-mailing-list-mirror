From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 10:08:06 -0700
Message-ID: <20060530170805.GC32457@h4x0r5.com>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net> <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net> <7vu0782e33.fsf@assigned-by-dhcp.cox.net> <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com> <20060530152103.GB8931@trixie.casa.cgf.cx> <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Faylor <me@cgf.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 19:08:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl7hi-0003iy-12
	for gcvg-git@gmane.org; Tue, 30 May 2006 19:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWE3RIX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 13:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWE3RIX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 13:08:23 -0400
Received: from h4x0r5.com ([70.85.31.202]:43785 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932330AbWE3RIW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 13:08:22 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fl7hO-0005JK-4F; Tue, 30 May 2006 10:08:06 -0700
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21038>

On Tue, May 30, 2006 at 06:00:20PM +0200, Alex Riesen wrote:
> If you actually read the message, you'd probably notice ActiveState Perl.
> 
> I have no idea why have you taken my post as an attempt to insult cygwin;
> IF I had that in mind I'd dedicate a whole long post just to that.

FWIW, it was probably this:
	if test "$(uname -o)"= Cygwin; then

(I only mention becuase I was about to apply this, then I saw that line,
and now I'm confused, is this a fix for ActiveState, or Cygwin?)
