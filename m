From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 16 May 2006 22:15:16 -0700
Message-ID: <20060517051505.GD31164@h4x0r5.com>
References: <Pine.LNX.4.64.0605161904260.16475@g5.osdl.org> <4973.1147836384@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 07:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgEOM-0004bC-E1
	for gcvg-git@gmane.org; Wed, 17 May 2006 07:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWEQFPz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 01:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWEQFPz
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 01:15:55 -0400
Received: from h4x0r5.com ([70.85.31.202]:4104 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932124AbWEQFPz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 01:15:55 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FgENT-0000ug-68; Tue, 16 May 2006 22:15:19 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
Content-Disposition: inline
In-Reply-To: <4973.1147836384@lotus.CS.Berkeley.EDU>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20162>

On Tue, May 16, 2006 at 08:26:24PM -0700, Jason Riedy wrote:
> Plus, alas, Perl modules and Python version drift can be a bit
> of a problem on the same semi-pristine (or unmaintained, or
> too-stable) systems, so shell isn't the only thing that needs to
> go.  And that'll take a good deal of effort.

The Perl used in core-git is pretty forgiving of older versions of Perl,
back to at least 5.6.  (Going back to 5.005.003 is rather painful,
however, to be honest.)

The only major tool I can think of that has embedded Perl in the shell
script is format-patch.  That could probably be redone in pure Perl if
it would help.
