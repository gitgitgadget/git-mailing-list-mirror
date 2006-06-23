From: Pavel Roskin <proski@gnu.org>
Subject: Re: Added macro support to qgit
Date: Fri, 23 Jun 2006 16:15:49 -0400
Message-ID: <1151093749.10112.11.camel@dv>
References: <e5bfff550606220704q568d8345o1420a0a3e29544e8@mail.gmail.com>
	 <1151024452.5205.46.camel@dv>
	 <e5bfff550606231044j4586ea65v191f86a869237b84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 22:16:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fts4L-0004Qr-3H
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 22:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWFWUPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbWFWUPx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 16:15:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:55463 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1752018AbWFWUPw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 16:15:52 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fts4F-0008Fn-Nw
	for git@vger.kernel.org; Fri, 23 Jun 2006 16:15:51 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fts4D-0002gU-Mg; Fri, 23 Jun 2006 16:15:49 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606231044j4586ea65v191f86a869237b84@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22437>

On Fri, 2006-06-23 at 19:44 +0200, Marco Costalba wrote:

> Or just "commands"? in any case I agree "macro" was not a good choice.

For a menubar entry, something short is preferred, so "Commands" or
"Actions" would be better than "external commands".  Emacs calls it
"Tools".  But for a menu entry and the dialog title, "external commands"
would be better.

> The bug is qgit lets you write the first foo bar, before you press NEW
> button. It shouldn't. Also some buttons enable/disable policy could be
> good.

Definitely.

> > What happens to the arguments qgit is asking for if a multiline entry is
> > executed?  I understand they are prepended to the first line.  This is
> > not quite logical.  Wouldn't it be better to have a shell like notation
> > for them?

I meant appended, sorry.

> I thought of commands sequence as a quick way to run some simple
> commands as git pull, git push or similar without writing a bash
> script, i.e. no $1 for arguments. If you need something more complex
> the external script is supposed to be the proper way.

I think the checkbox controlling whether to ask for arguments allows
selection between "simple" and "complex" commands.

> Perhaps we could remove the external script single edit line and use
> only the multiline edit to let user insert commands or script.

I agree.

> > I see the macros are saved in the qgit configuration for the
> > user .qt/qgitrc, like this:

> Well, this file is really not meant to be view nor to be modified by
> hand, it is mainly a qgit 'private' thing stuff. Being qgit a GUI tool
> with a (nice ;-)  ) settings dialog, configuration file is mainly used
> for persistency, not for browsing/setup.

OK

> I hope to fix the external commands interface bugs this week-end.

I'm looking forward to testing it.

-- 
Regards,
Pavel Roskin
