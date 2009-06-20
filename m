From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Feature suggestion: git grep --blame
Date: Sat, 20 Jun 2009 20:19:10 +0200
Message-ID: <4A3D281E.4070500@lsrfire.ath.cx>
References: <B13F8D3F-E69B-49BA-9B81-27DF19E33A43@endpoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	pi song <pi.songs@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Christensen <david@endpoint.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 20:19:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI5A8-00076w-Jo
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 20:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbZFTST0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jun 2009 14:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbZFTSTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 14:19:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:58617 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002AbZFTSTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 14:19:25 -0400
Received: from [10.0.1.101] (p57B7D007.dip.t-dialin.net [87.183.208.7])
	by india601.server4you.de (Postfix) with ESMTPSA id A5E5B2F8040;
	Sat, 20 Jun 2009 20:19:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <B13F8D3F-E69B-49BA-9B81-27DF19E33A43@endpoint.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121949>

David Christensen schrieb:
> Hey folks,
>=20
> It's occurred to me on several occasions that a useful output option =
for
> `git grep` would be to prefix lines with the same commit/author/date
> annotation that `git blame` shows when viewing an individual file.  I
> didn't find anything myself with a quick google search so I was
> wondering if anyone a) has a recipe for this either with a trivial
> command alias (I couldn't come up with one myself), b) know if this h=
as
> been done/attempted before, or c) have a reason why this is a really
> stupid idea? :-)

This is a very good idea -- so good, in fact, that Pi Song sent patches
to implement it a quarter ago.  There were a few issues which prevented
them from being merged unchanged.  Junio merged an initial cleanup patc=
h
into pu instead ("blame.c: start libifying the blame infrastructure",
97926c6c).  Work on the remaining parts seems to have stalled, though.
Pi Song?

Ren=E9
