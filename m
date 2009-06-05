From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [BUG?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 15:14:15 +0200
Message-ID: <200906051514.15876.robin.rosenberg.lists@dewire.com>
References: <20090605122444.GA11035@atjola.homenet>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 15:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCZFi-0004xq-C3
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 15:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZFENO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 09:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZFENOZ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 09:14:25 -0400
Received: from mail.dewire.com ([83.140.172.130]:10446 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226AbZFENOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 09:14:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E0F5D146D032;
	Fri,  5 Jun 2009 15:14:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jYvTTIapXFK; Fri,  5 Jun 2009 15:14:21 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.12])
	by dewire.com (Postfix) with ESMTP id 05555146D014;
	Fri,  5 Jun 2009 15:14:20 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090605122444.GA11035@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120770>

fredag 05 juni 2009 14:24:44 skrev Bj=F6rn Steinbrink:
> Hi,
>=20
> can't make any sense out of this at all:
>=20
> doener@atjola:git (master) $ git reset --hard HEAD@{1}
> HEAD is now at b11cf09 Merge branch 'da/pretty-tempname'
> doener@atjola:git (master) $ git update-ref refs/remotes/origin/maste=
r HEAD
>=20
> doener@atjola:git (master) $ git pull
> From git://git.kernel.org/pub/scm/git/git
>    b11cf09..6096d75  master     -> origin/master
> Updating b11cf09..6096d75
> Fast forward
>  Documentation/RelNotes-1.6.3.2.txt     |   12 +++++-------
>  Documentation/git.txt                  |    7 ++++++-
>  contrib/completion/git-completion.bash |   12 ++++++++++--
>  grep.c                                 |    6 +++++-
>  4 files changed, 26 insertions(+), 11 deletions(-)
>=20
> doener@atjola:git (master) $ git diff-index --name-only HEAD
> doener@atjola:git (master) $ git diff-index --name-only --cached HEAD
>=20
> *wait a minute, doing nothing*
>=20
> doener@atjola:git (master) $ git diff-index --name-only HEAD
> Documentation/RelNotes-1.6.3.2.txt
> Documentation/git.txt
> contrib/completion/git-completion.bash
> grep.c
>=20
> doener@atjola:git (master) $ git diff-index --name-only --cached HEAD
>=20
> doener@atjola:git (master) $ git diff-index --stat HEAD
>  0 files changed, 0 insertions(+), 0 deletions(-)
>=20
> doener@atjola:git (master) $ git diff-index --name-only HEAD
> Documentation/RelNotes-1.6.3.2.txt
> Documentation/git.txt
> contrib/completion/git-completion.bash
> grep.c
>=20
>=20
> Running "git status" seems to fix things.
>=20
> Bj=F6rn, confused

What file system and OS?

-- robin
