From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/2] Add "-m" and "-F" options to "git notes edit"
Date: Fri, 15 May 2009 02:11:44 +0200
Message-ID: <200905150211.44431.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 02:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4l1q-0003Qs-7Z
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 02:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbZEOALs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 20:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754367AbZEOALr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 20:11:47 -0400
Received: from mx.getmail.no ([84.208.15.66]:61776 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753563AbZEOALr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 20:11:47 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJN00D52SJLEQ40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 15 May 2009 02:11:45 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KJN00M2ISJK9JH0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 15 May 2009 02:11:45 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.14.235538
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119238>

Hi,

(This is a resend of an earlier series which got positive feedback
from Dscho, but which has yet to show up in 'pu'.)

The following 2-patch series teaches "git notes edit" to support the
"-m <msg>" and "-F <file>" options (inspired by git-tag and git-commit).

The first patch does some minor bugfixes and cleanups in preparation for
the second patch, which adds the options with associated documentation
and selftests.

This series is based on top of the "js/notes" topic in a recent "pu".

Johan Herland (2):
  Minor cleanup and bugfixing in git-notes.sh
  Teach "-m <msg>" and "-F <file>" to "git notes edit"

 Documentation/git-notes.txt |   12 +++++++-
 git-notes.sh                |   71 ++++++++++++++++++++++++++++++++----------
 t/t3301-notes.sh            |   57 ++++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+), 18 deletions(-)


Have fun! :)

...Johan

