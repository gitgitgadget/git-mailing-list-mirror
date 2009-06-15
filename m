From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Mon, 15 Jun 2009 23:13:19 +0200
Message-ID: <200906152313.20002.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <e5bfff550906130412v6e223511tf0e20c685b21c490@mail.gmail.com> <200906131333.57725.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGJUw-00074e-QW
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934800AbZFOVNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934785AbZFOVNS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:13:18 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:58601 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934780AbZFOVNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:13:16 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 722ED105B1476;
	Mon, 15 Jun 2009 23:13:18 +0200 (CEST)
Received: from [89.59.70.41] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MGJUU-0001JV-00; Mon, 15 Jun 2009 23:13:18 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200906131333.57725.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18J/WhcsYmFaCzp1SMNd/ua6eeoWKhgyAlkplEz
	FlLp2/XrxDvuHUqjoESZH0o/zURFNlDEWasBQWZkkwSbm3WKoA
	Zyhi2/BxJRE+vUde92bg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121623>

Markus Heidelberg, 13.06.2009:
> 
> I tested with the latest qgit.git and with QGit 2.2 from my
> distribution. All on Gentoo Linux.
> 
> I just built QGit 2.3, this has the same problems.
> 
> [...]
> 
> I will try to reproduce on Windows, probably after this weekend.

Some news, tested with the 4 commits in git.git around v1.6.3 as before:

It works correctly with QGit-2.3 installed from the Windows installer
(http://sourceforge.net/projects/qgit).

It works reversed when using a self-compiled qgit.
gcc: mingw-gcc 3.4.5
Qt: 4.4.1

Reversed means, git-format-patch is invoked like this:
    git format-patch v1.6.3..v1.6.3~3^
and doesn't produce patch files, instead of:
    git format-patch v1.6.3~3^..v1.6.3

The strange behaviour of getting only 2 patches on Linux, I couldn't
reproduce on Windows.

You use MSVC, don't you? Can you please try with mingw? It would be
really helpful, if you could reproduce it.

Markus
