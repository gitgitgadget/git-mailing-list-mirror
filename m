From: Junio C Hamano <junkio@cox.net>
Subject: GIT 1.3.0-rc3
Date: Sat, 08 Apr 2006 01:07:26 -0700
Message-ID: <7v1ww8fq2p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Apr 08 10:07:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FS8Tl-0002BM-VB
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 10:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWDHIH3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Apr 2006 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWDHIH3
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 04:07:29 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:16853 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751402AbWDHIH2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Apr 2006 04:07:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060408080727.RMKQ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Apr 2006 04:07:27 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18512>

I do not think there are any more remaining major issue for a
real 1.3.0, so here is hopefully the final round of rc.  Testing,
fixing and polishing are appreciated.

Changes since v1.3.0-rc2 are as follows:

* documentation (Francis Daly, Jon Loeliger, Marco Roeland)
* add regexp to pickaxe (Petr Baudis)
* add git-clean (Pavel Roskin)=20
* cvsimport fix (Johannes Schindelin)
* svnimport fix (Karl Hasselstr=F6m)
* imap-send updates (Mike McCormack)
* assorted build and porting fixes (Johannes Schindelin)
* gitk updates (Keith Packard, Mark Wooding, Paul Mackerras, Pavel Rosk=
in
  Rutger Nijlunsing, Stephen Rothwell)
* http-fetch can use PROPFIND in place of objects/info/packs (Nick Heng=
eveld)
* deltifier bounds safety (Nicolas Pitre)
* clone fix
* fix blame, broken by recent revision walker updates
* use built-in-xdiff in combine-diff
* use built-in-xdiff in blame
* support -S in blame
* diff_flush() memory leak fix when NO_OUTPUT
* make human-date parsing friendlier to our European friends.
* optimize thin-pack generation by pack-objects
