From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 13:55:49 -0400
Message-ID: <20060515175549.GD15165@fieldses.org>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com> <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net> <m1ejyv7077.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org> <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 19:56:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhIX-0002gS-Jh
	for gcvg-git@gmane.org; Mon, 15 May 2006 19:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWEORz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWEORz7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 13:55:59 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58077 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S965007AbWEORz6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 13:55:58 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FfhIM-0006qp-1A; Mon, 15 May 2006 13:55:50 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20073>

On Mon, May 15, 2006 at 10:29:20AM -0600, Eric W. Biederman wrote:
> Sure.  If it gets included in a tutorial is great, but existing
> users aren't likely to read through a tutorial if they think they
> know what is going on.
> 
> Having it documented in the man pages (i.e. the reference
> documentation) which is where people look to check up on the fine
> points of a command is more likely to matter.

Looks like the current git-log man page refers you to the git-rev-list
page for that, and the use of path names is documented there.

I think that's a pretty reasonable approach for reference
documentation, which should be concise.  Duplicating the git-rev-list
documentation (even some of it) to every man page to which it's relevant
would add a lot of text.

The current git-log man page is misleading, though--it suggests that
git-log accepts (and git-rev-list documents) only options, which might
discourage a reader from tracking down information about non-option
arguments.

I also agree about the tutorial--the "Keeping track of history" section
would be a good place to introduce this and git-grep with some fun
examples.  It's on my todo list, but may take a while, so maybe someone
else can beat me to it....

--b.
