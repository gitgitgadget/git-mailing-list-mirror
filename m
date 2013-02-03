From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Feb 2013, #01; Fri, 1)
Date: Sun, 3 Feb 2013 13:02:37 +0000
Message-ID: <20130203130237.GS1342@serenity.lan>
References: <7vwqur8z4s.fsf@alter.siamese.dyndns.org>
 <7vlib69cjh.fsf@alter.siamese.dyndns.org>
 <CAJDDKr6bPjKwe3NitvGCec2LyesY3yL=UtN85Bsox-bGWN=qeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 14:03:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1zDw-00073d-KM
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 14:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3BCNCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 08:02:47 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:34566 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3BCNCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 08:02:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 796796064E2;
	Sun,  3 Feb 2013 13:02:45 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8A0uA+mVNkz; Sun,  3 Feb 2013 13:02:44 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 0B0A06064E3;
	Sun,  3 Feb 2013 13:02:39 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr6bPjKwe3NitvGCec2LyesY3yL=UtN85Bsox-bGWN=qeA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215307>

On Sun, Feb 03, 2013 at 04:13:22AM -0800, David Aguilar wrote:
> On Sat, Feb 2, 2013 at 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > Regarding these two topics....
> >
> >> * da/mergetool-docs (2013-01-30) 7 commits
> >>  - doc: generate a list of valid merge tools
> >>  - mergetool--lib: list user configured tools in '--tool-help'
> >>  - fixup! doc: generate a list of valid merge tools
> >>  - fixup! mergetool--lib: add functions for finding available tools
> >>  - mergetool--lib: add functions for finding available tools
> >>  - mergetool--lib: improve the help text in guess_merge_tool()
> >>  - mergetool--lib: simplify command expressions
> >>  (this branch uses jk/mergetool.)
> >>
> >>  Build on top of the clean-up done by jk/mergetool and automatically
> >>  generate the list of mergetool and difftool backends the build
> >>  supports to be included in the documentation.
> >>
> >>  Will merge to 'next', after squashing the fixup! commits from John
> >>  Keeping.
> >>
> >>
> >> * jk/mergetool (2013-01-28) 8 commits
> >>  - mergetools: simplify how we handle "vim" and "defaults"
> >>  - mergetool--lib: don't call "exit" in setup_tool
> >>  - mergetool--lib: improve show_tool_help() output
> >>  - mergetools/vim: remove redundant diff command
> >>  - git-difftool: use git-mergetool--lib for "--tool-help"
> >>  - git-mergetool: don't hardcode 'mergetool' in show_tool_help
> >>  - git-mergetool: remove redundant assignment
> >>  - git-mergetool: move show_tool_help to mergetool--lib
> >>  (this branch is used by da/mergetool-docs.)
> >>
> >>  Cleans up mergetool/difftool combo.
> >>
> >>  This is looking ready for 'next'.
> >
> > Do the tips of these two topics look reasonable to both of you, or
> > are there anything you sent but I missed?
> 
> It looks good to go.  The additional "|| :" in the makefile is a nice
> touchup that made it more robust too.

Looks good to me as well.


John
