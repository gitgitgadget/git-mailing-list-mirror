From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/5] de.po suggested updates
Date: Wed, 2 May 2012 15:49:22 +0200
Message-ID: <cover.1335966202.git.trast@student.ethz.ch>
References: <87d36n2f2r.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZw0-0004nd-7i
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab2EBNtb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:49:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27485 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2EBNta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:30 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:26 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:49:27 +0200
X-Mailer: git-send-email 1.7.10.625.g300dcf
In-Reply-To: <87d36n2f2r.fsf@thomas.inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196816>

I wrote:
> Of course now that it has been released, we'll also have to file patc=
hes
> in the true open source spirit.  Sigh.

So here goes.

[1/5] is actually intended for Junio to pick up, and makes a message
      translatable that somehow got away last time.

The rest are for Ralf.

[2/5] does away with the "bare"->"leer" issue that I used as an
      example earlier.  There's precedent in git-gui :-( This does
      raise the question if it's kosher to patch both git and git-gui
      at the same time, but if we want to keep the translations in
      sync it probably won't be the last such patch.

[3/5] collects all the "obvious" stuff

[4/5] and [5/5] gather the less-obvious stuff -- keep what you like.

Cheers,
Thomas

Thomas Rast (5):
  stash: make "saved" message translatable
  de.po: translate "bare" as "blo=C3=9F"
  de.po: hopefully uncontroversial fixes
  de.po: translate "bad" as "ung=C3=BCltig" ("invalid")
  de.po: collection of suggestions

 git-gui/po/de.po |    4 +-
 git-stash.sh     |    2 +-
 po/de.po         |  153 +++++++++++++++++++++++++---------------------=
--------
 3 files changed, 74 insertions(+), 85 deletions(-)

--=20
1.7.10.625.g300dcf
