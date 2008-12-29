From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: user manual question
Date: Mon, 29 Dec 2008 18:20:58 +0100
Message-ID: <200812291820.58642.markus.heidelberg@web.de>
References: <gj7mmo$fvk$4@ger.gmane.org> <slrnglg90m.olt.sitaramc@sitaramc.homelinux.net> <gjauel$94s$4@ger.gmane.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Zorba" <cr@altmore.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 18:22:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHLok-0000Xw-Q9
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 18:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbYL2RUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 12:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYL2RUv
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 12:20:51 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:55625 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYL2RUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 12:20:50 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id D2070F85CC65;
	Mon, 29 Dec 2008 18:20:48 +0100 (CET)
Received: from [91.19.66.120] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LHLnM-00010p-00; Mon, 29 Dec 2008 18:20:48 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <gjauel$94s$4@ger.gmane.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18u9btipTVXrS9weE56CY2q1Q27uuimypGjjWmg
	xjmGNZ1yHgQ5Ghc2wy7K7cWD4uhMhWTF6ta5YQxUSGSpqCZDFr
	/MbXYr/1c72aUybW5OVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104116>

Zorba, 29.12.2008:
> so a detached HEAD is just a HEAD that is not sitting on a tip ?

You can also get a detached HEAD with "git checkout origin/master",
although your HEAD points to a tip. But it's a remote tip and since you
can't work on remote branches, you now are on a detached HEAD (no
branch).

> i.e. if I do $ git reset --hard HEAD^
> 
> ...pointing HEAD to the previous committ
> 
> this is a detached HEAD

No, this isn't. "git reset <commit>" modifies your current head (local
branch), now HEAD still points to the tip, but the tip is one commit
older. A detached HEAD you can get with "git checkout HEAD^".
