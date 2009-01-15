From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git-difftool
Date: Thu, 15 Jan 2009 23:26:46 +0100
Message-ID: <200901152326.47332.markus.heidelberg@web.de>
References: <20081226013021.GA15414@gmail.com> <vpq63kxofi3.fsf@bauges.imag.fr> <402731c90901020939k1a8ae795oc4cbfd0ced992aab@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:29:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNah5-0004mQ-AW
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934348AbZAOW0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 17:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935731AbZAOW0R
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:26:17 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:37599 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935725AbZAOW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:26:13 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 8AE5EFBC293C;
	Thu, 15 Jan 2009 23:26:12 +0100 (CET)
Received: from [89.59.96.34] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNafE-0003ME-00; Thu, 15 Jan 2009 23:26:12 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <402731c90901020939k1a8ae795oc4cbfd0ced992aab@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18ljElTqAPLWZMP2sakcTqdgtWFTutYWNm/2uQJ
	6iYbE7YFdoILfgdB5bn+U/sDwGVInn0Wsl2A7d0tyIZRed/6Ld
	gR457rvReljsPmNwbHAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105888>

David Aguilar, 02.01.2009:
> I now have a git-difftool wrapper script that basically just sets up
> the environment for git-difftool-helper.  git-difftool-helper does all
> of the merge tool configuration stuff ala
> http://www.kernel.org/pub/software/scm/git/docs/git-mergetool.html (it
> uses the same git config variables and thus works with existing custom
> commands).  If you drop them both into the same directory it should
> work as-is (it munges $PATH).
> 
> It's not a two-liner (they do all that git config stuff and handle
> more than just vimdiff) but it does use GIT_EXTERNAL_DIFF now, which
> makes the script infinitely more useful.  This is much nicer now since
> you can pass any 'git diff' options to git-difftool and it'll handle
> it correctly.
> 
> The usage is simpler now too:
> 
> usage: git difftool [--no-prompt] [--tool=tool] ["git diff" options]

Now isn't this something for contrib, David?

Markus
