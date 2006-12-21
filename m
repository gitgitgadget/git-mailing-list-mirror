From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: specify charset for commits (Was: [PATCH] Fix documentation copy&paste typo)
Date: Thu, 21 Dec 2006 09:59:07 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061221085907.GA2244@cepheus>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061219141618.GA2539@cepheus> <7vac1jre1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJln-0000eu-7Z
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWLUI7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWLUI7N
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:59:13 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54393 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422884AbWLUI7M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 03:59:12 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxJle-0006Cb-Ng; Thu, 21 Dec 2006 09:59:10 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBL8x8A9005982;
	Thu, 21 Dec 2006 09:59:08 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBL8x7DX005981;
	Thu, 21 Dec 2006 09:59:07 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vac1jre1u.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35034>

Hello Junio,

Junio C Hamano wrote:
> Me, keyboard and Emacs screwed up and stored it in ISO-2022
> instead of UTF-8.  Sorry.
It's a pity, but too late to change.[1]

What do you think about a patch that makes git-commit-tree call iconv o=
n
its input to get it to UTF-8 (or any other charset).  Maybe it
makes sense to add another header to commit objects (e.g.
"charset UTF-8") if something in the commit object is non-ASCII?

In my eyes it would make sense to even force UTF-8 for commit logs (and
author, committer).  The downside is that it becomes impossible to stor=
e
arbitrary byte sequences in commit objects.  (IMHO not a real
limitation.)

Best regards
Uwe

[1] actually I think it's worse, because my iconv (from Debian's libc6
    version 2.3.6.ds1-8) was unable to convert it correctly to utf-8 fo=
r
    any encoding that starts with ISO-2022.

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dsin%28pi%2F2%29
