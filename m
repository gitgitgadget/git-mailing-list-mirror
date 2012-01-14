From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Zsh completion regression
Date: Sat, 14 Jan 2012 22:36:38 +0100
Message-ID: <1kdvsvw.10asu1tpmtz3qM%lists@haller-berlin.de>
References: <20120114132343.GW30469@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: szeder@ira.uka.de (=?ISO-8859-1?Q?SZEDER_G=E1bor?=),
	Matthieu.Moy@grenoble-inp.fr (Matthieu Moy)
X-From: git-owner@vger.kernel.org Sat Jan 14 22:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmBHd-0003y1-Vw
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 22:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756808Ab2ANVgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 16:36:47 -0500
Received: from server90.greatnet.de ([83.133.96.186]:42295 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2ANVgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 16:36:41 -0500
Received: from [192.168.0.42] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id 3D1282A01D1;
	Sat, 14 Jan 2012 22:34:48 +0100 (CET)
In-Reply-To: <20120114132343.GW30469@goldbirke>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.7.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188582>

SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> However.
>=20
> While playing around with zsh, I noticed that git completion works
> without even sourcing git's bash completion script.  As it turned out=
,
> zsh ships its own git completion script[1], and from my cursory tests
> it seems to be quite capable: it supports commands, aliases, options,
> refs, ref1..ref2, config variables, ...  and I also saw a __git_ps1()
> equivalent for zsh.
>=20
> So, is there any reason why you are still using git's bash completion
> under zsh (which has some quirks and lacks some features) instead of
> zsh's own?  Perhaps it would make sense to point zsh users to zsh's
> git completion and drop zsh compatibility from git's bash completion.
> We did similar with vim config files: git included a vim syntax
> highlight config file for commit messages under contrib/vim/, but
> eventually we dropped it after vim started shipping more capable
> git-specific config files (for git config files, rebase instruction
> sheets, etc.).

Last time I compared the two, the bash completion script was a lot more
complete and powerful. The zsh script had a few annoying limitations fo=
r
things that I use every day, and that worked with the bash script, so I
switched to that. Unfortunately I forgot the details, it's a while ago.


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
