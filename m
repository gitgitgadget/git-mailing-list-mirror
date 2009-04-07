From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/3] remove static vars from "builtin-rev-list.c"
Date: Tue, 7 Apr 2009 06:50:12 +0200
Message-ID: <20090407065012.c6528241.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 06:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr3Is-0000UK-DB
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 06:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbZDGEvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 00:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbZDGEvV
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 00:51:21 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:40327 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbZDGEvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 00:51:21 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 814E24B0076;
	Tue,  7 Apr 2009 06:51:12 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id 800A34B002F;
	Tue,  7 Apr 2009 06:51:10 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115906>

This patch series removes all static variables from
"builtin-rev-list.c" except the usage string.

This cleans up the code and should please Dscho.

It also makes it possible to remove restrictions on using the
"sho_bisect_vars" function.


  list-objects: add "void *data" parameter to show functions
  rev-list: remove last static vars used in "show_commit"
  rev-list: add "int bisect_show_flags" in "struct rev_list_info"

 bisect.c               |    8 +++-
 bisect.h               |   18 ++++----
 builtin-pack-objects.c |    6 +-
 builtin-rev-list.c     |  109 ++++++++++++++++++++++++------------------------
 list-objects.c         |    9 ++--
 list-objects.h         |    6 +-
 upload-pack.c          |    6 +-
 7 files changed, 84 insertions(+), 78 deletions(-)

PS: Sorry but it looks like the script I used to send this series has some bugs.
First the date in the email are wrong, and then I have to resend this cover letter
because it did not appear on the mailing list.
