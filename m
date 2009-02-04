From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: What is not in git.git
Date: Thu, 05 Feb 2009 05:49:18 +0900
Message-ID: <20090205054918.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ecashin@coraid.com, arjen@yaph.org,
	joey@kitenet.net, benny.kra@googlemail.com, pw@padd.com,
	simon@lst.de, jidanni@jidanni.org, dirker@gmail.com,
	hoxu@users.sf.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 21:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUoi7-0006Kq-5E
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 21:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbZBDUtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 15:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758095AbZBDUtf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 15:49:35 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55904 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036AbZBDUtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 15:49:33 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id F31AAC86BB;
	Wed,  4 Feb 2009 14:49:32 -0600 (CST)
Received: from 7071.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id DD1BYAB2RYFB; Wed, 04 Feb 2009 14:49:32 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=oSrotxoA0M0RbSaui9J1jYDdrPJtOTrc8ORn/LB0g/Bc5uHeGe7e+CuFi7tcEwtM1njxtPZJMSkwpM0BbvMFPYBdrjiJ8w9AbDS9YubBeuVGxNLGnb38dXKg+ngE+/IK/MyLli/zODZIVxw6vAfH5jDAxOQ7y54DUwJiEXu8Y80=;
  h=From:To:cc:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108430>

You keep mentioning 1.6.2 and I take it as a hint that the project is
approaching the pre release freeze. There are some patches sent to the
list that are not in git.git, and I am wondering what their statuses ar=
e.

 1. From: ecashin@coraid.com
    Subject: [PATCH] git-describe documentation: --match pattern is glo=
b
    Date: Thu, 22 Jan 2009 11:21:53 -0500
    Message-ID: <dfa634dbd8def9e205bbe219217179ca@coraid.com>

    I thought this was correct, but was missing a sign-off. Perhaps it =
was
    dropped on the floor because it was sent in a wrong format that is
    harder to apply?

 2. From: Arjen Laarhoven <arjen@yaph.org>
    Subject: [PATCH 2/2] git-log: Follow file copies with 'git log --fo=
llow -C -C'
    Date: Thu, 22 Jan 2009 17:37:25 +0100
    Message-ID: <1232642245-94405-2-git-send-email-arjen@yaph.org>

    Junio seemed to like the patch but asked a question; I did not see =
a
    response nor updated patch (sorry, I do not read C and cannot comme=
nt
    on the correctness of the patch).

 3. From: Joey Hess <joey@kitenet.net>
    Subject: [PATCH] gitweb: support the rel=3Dvcs microformat
    Date: Tue, 6 Jan 2009 23:25:18 -0500
    Message-ID: <20090107042518.GB24735@gnu.kitenet.net>

    A few exchanges of review comments and responses, and then this top=
ic
    went dark.

    From: Benjamin Kramer <benny.kra@googlemail.com>
    Subject: [PATCH] Makefile: Use libc strlcpy on OSX
    Date: Sat, 24 Jan 2009 16:41:30 +0100
    Message-ID: <7f978c810901240741k201f954dx1c0470186094ae24@mail.gmai=
l.com>

    My reading of the thread is that the only remaining issue was to li=
mit
    the change to specific versions, and I think people who use OSX can=
 help
    polish this topic to completion.

 4. From: Pete Wyckoff <pw@padd.com>
    Subject: [PATCH] git-p4: avoid syncing duplicate changes
    Date: Wed, 28 Jan 2009 08:45:40 -0800
    Message-ID: <20090128164540.GA2137@padd.com>

    Nobody commented on this as far as I can tell. Do people not care
    about p4? Simon Hausmann seem to be the most recent active contribu=
tor
    and perhaps he can comment on this patch.

 5. From: jidanni@jidanni.org
    Subject: [PATCH] Documentation/git-show-branch.txt: compact -g
    Date: Tue,  6 Jan 2009 11:14:02 +0800
    Message-Id: <1231211642-14463-1-git-send-email-jidanni@jidanni.org>

    I couldn't figure out what "compact -g" meant but other than that I
    think this patch is correct. Perhaps Junio has the author in his ma=
il
    ignore list?

 6. From: Alexander Potashev <aspotashev@gmail.com>
    Subject: [PATCH] Replace deprecated dashed git commands in usage
    Date: Sun,  4 Jan 2009 21:39:27 +0300
    Message-ID: <1231094367-8831-1-git-send-email-aspotashev@gmail.com>

    This should have been in 1.6.0 already but it is still not.
    Forgotten?

 7. From: Dirk H=C3=B6rner <dirker@gmail.com>
    Subject: [PATCH] git-cvsimport: add support for cvs pserver passwor=
d scrambling.
    Date: Fri, 28 Nov 2008 20:06:40 +0200
    Message-ID: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>

    I think Johannes Schindelin commented but then nothing happened to
    this patch. Is there any more work necessary for its inclusion?

 8. From: Heikki Hokkanen <hoxu@users.sf.net>
    Subject: [PATCH] git show-ref: add --remotes option.
    Date: Mon, 13 Oct 2008 22:23:47 +0300
    Message-ID: <48F3A043.5070406@users.sf.net>

    I saw no comments but it is consistent with how git-rev-list allows
    you say branches and tags. Is there anything wrong with the patch?

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
