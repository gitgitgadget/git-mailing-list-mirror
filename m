From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH] Document check option to git diff.
Date: Fri, 26 Jan 2007 20:06:11 -0600
Message-ID: <17850.45971.918929.314082@lisa.zopyra.com>
References: <1169833372823-git-send-email-rael@zopyra.com>
	<7vodoltkqt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 03:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAcxO-0000Z5-4m
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 03:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbXA0CGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbXA0CGO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 21:06:14 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61436 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbXA0CGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 21:06:14 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0R26Ct13456;
	Fri, 26 Jan 2007 20:06:12 -0600
In-Reply-To: <7vodoltkqt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37913>

On Friday, January 26, 2007 at 15:46:02 (-0800) Junio C Hamano writes:
>...
>Thanks.  It's nice to see somebody new getting more and more
>comfortable with git.

I, and my colleagues, are grateful for all the work put into it.

>Also I fear that 'valid' is a bit too strong a word here.  ...
>                     ....  How about rewording it like this?
>
>	Look for and warn about changes that introduce trailing
>        whitespaces at the end of the line or an indent that
>        uses a whitespace before a tab.

I was indeed too strong in wording it as "valid": yet another example
of haste-induced waste.

I believe that an accurate and concise statement would be:

    Warn if changes introduce trailing whitespace
    or an indent that uses a space before a tab.

I think it should be explicitly limited to "space" and not
"whitespace" before the tab, as "whitespace" really includes tab.

Do I really need to say "trailing whitespace at the end of the line"?
That seems overly verbose: trailing whitespace is, I think, understood
to trail at the end of the line.

I'll re-do the patch when I hear back, probably tomorrow.

Also: I suppose I am wondering about the motivation for this switch.
It seems to reflect the aesthetics of the git project.  Whitespace at
the end of a line is meaningless and wasteful, so I understand and
sympathize with the judgment that this is undesirable.  Spaces
preceding tabs are somewhat murkier: two tabs, a space, and text pass
the check, but a tab, space, tab and text do not.  Why is this bad?

I'm sure there is a better way to categorize these violations other
than "funny".  Should we not say "wasteful and inelegant, and
therefore anathema to any decent, self-respecting person"?


Bill
