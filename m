From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] pretty: support multiline subjects with format:
Date: Sun, 28 Dec 2008 00:24:58 +0100
Message-ID: <200812280024.59096.markus.heidelberg@web.de>
References: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Dec 28 00:27:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGiYh-00051Y-O1
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 00:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYL0XZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Dec 2008 18:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbYL0XY7
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 18:24:59 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43719 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYL0XY7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 18:24:59 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 29E1DFB208AF;
	Sun, 28 Dec 2008 00:24:58 +0100 (CET)
Received: from [91.19.58.30] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LGiWf-0006LK-00; Sun, 28 Dec 2008 00:24:58 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <1230338961.8363.101.camel@ubuntu.ubuntu-domain>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1//twpY/unSyaauxtgmWr/gtWZD+UCuYhqmAL6L
	pG7BDqkGTlRcJnoRKXHO2wy9eaV+X+TJ6HKrryvEcrE5v8zqcK
	vMyH1bKhmg1BgMhUzGLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104031>

Hello,

I hope I got the In-Reply-To right, the message was sent before my
subscription to this list.

Ren=C3=A9 Scharfe, 27.12.2008:
> git log --pretty=3Dformat:%s (and tformat:) used to display the first
> line of the subject, unlike the other --pretty options, which would
> construct a subject line from all lines of the first paragraph of
> the commit message.

And that can be very annoying when working on repositories with a
history not formatted after the recommendations of git (empty line afte=
r
the summary). Then the output of commands like
"git log --pretty=3Doneline", "git format-patch" and "git show-branch"
is unreadable.

Sorry, I haven't tested your patch set, what is the output of
git-shortlog like now?

> For consistency and increased code reuse, change format: to do the
> same as the other options.

What's wrong with using the first line instead of the first paragraph
for the other pretty options and for cases where only a small subject
line is desired? A sentence would be broken into a small uncomplete par=
t
for the subject for example. What else?

Markus
