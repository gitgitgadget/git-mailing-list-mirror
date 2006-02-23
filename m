From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.2.3
Date: Wed, 22 Feb 2006 17:59:09 -0800
Message-ID: <7vlkw2kf82.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 02:59:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC5lN-0000AO-Lz
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 02:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWBWB7N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 20:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWBWB7N
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 20:59:13 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52697 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbWBWB7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 20:59:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223015637.QDOJ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Feb 2006 20:56:37 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16630>

The latest maintenance release GIT 1.2.3 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.3.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.3-1.$arch.rpm	(RPM)


This contains some documentation updates, and a fix for the
"empty ident not allowed" problem that bit too many people.

Breaking the tradition, this is _not_ a pure bugfix release,
however.  It contains backports of the much talked about "reuse
data from existing pack" optimization from the master branch.

Hopefully this would help downloading from the kernel.org
servers over git native protocol.

----------------------------------------------------------------

Changes since v1.2.2 are as follows:

Carl Worth:
      git-add: Add support for --, documentation, and test.
      git-push: Update documentation to describe the no-refspec behavior.

Junio C Hamano:
      format-patch: pretty-print timestamp correctly.
      detect broken alternates.
      pack-objects: reuse data from existing packs.
      pack-objects: finishing touches.
      git-repack: allow passing a couple of flags to pack-objects.
      pack-objects: avoid delta chains that are too long.
      Make "empty ident" error message a bit more helpful.
      Delay "empty ident" errors until they really matter.
      Keep Porcelainish from failing by broken ident after making changes.
      pack-objects eye-candy: finishing touches.
      git-fetch: follow tag only when tracking remote branch.

Nicolas Pitre:
      nicer eye candies for pack-objects
      also adds progress when actually writing a pack
