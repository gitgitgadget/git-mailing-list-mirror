From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Fri, 23 Mar 2007 11:33:14 -0400
Message-ID: <20070323153314.GA2364@fieldses.org>
References: <7v648u38ws.fsf@assigned-by-dhcp.cox.net> <eu0m6t$hln$1@sea.gmane.org> <20070323135930.GB24788@fieldses.org> <200703231523.58150.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUllY-0002Ml-LM
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbXCWPdQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Mar 2007 11:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934081AbXCWPdQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:33:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:35855 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167AbXCWPdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:33:15 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HUllS-0002Na-B6; Fri, 23 Mar 2007 11:33:14 -0400
Content-Disposition: inline
In-Reply-To: <200703231523.58150.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42942>

On Fri, Mar 23, 2007 at 03:23:55PM +0100, Jakub Narebski wrote:
> J. Bruce Fields wrote:
> > On Fri, Mar 23, 2007 at 02:57:38PM +0100, Jakub Narebski wrote:
> >> Junio C Hamano wrote:
> >>=20
> >>> +The commit message is formed by the title taken from the
> >>> +"Subject: ", a blank line and the body of the message up to
> >>> +where the patch begins. =A0Excess whitespaces at the end of the
> >>> +lines are automatically stripped.
> >>=20
> >> Does this mean that git-am cannot make a log message that doesn't
> >> follow git formatting commit message guidelines, namely short one-=
line
> >> description, then longer description and signoff?

Oh, sorry, I see--I misread "make" for "take" in the above!

> >=20
> > The input to git-am is email, not log messages.
>=20
> But that means that commit message which doesn't have empty line afte=
r
> first line cannot be send via git-send-email + git-am without changes=
,
> not be subject to git-rebase (which uses git-am machinery unless invo=
ked
> with --merge option) without changing commit message, isn't it?

Yup.

Doesn't seem like a big deal to me.  But then it'd also seem more
sensible to me if git-rebase worked directly with the original commits
rather than going through git-format-patch/git-am.  Maybe what I want i=
s
a git-cherry-pick that will accept a range.

--b.
