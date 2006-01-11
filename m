From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.1.1
Date: Tue, 10 Jan 2006 20:43:58 -0800
Message-ID: <7v64or1ii9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 05:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwXqX-0008LV-Gt
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 05:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbWAKEoE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 23:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWAKEoE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 23:44:04 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:58559 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWAKEoB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 23:44:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111044311.DJWD3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 23:43:11 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14478>

The latest maintenance release GIT 1.1.1 is available at the usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.1.1.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.1.1-1.$arch.rpm	(RPM)

This is primarily to fix the build problems with RPM and tarball
releases.  I owe a big thanks to Peter Anvin for the fix.

----------------------------------------------------------------

Changes since v1.1.0 are as follows:

H. Peter Anvin:
      For release tarballs, include the proper version

Johannes Schindelin:
      glossary: explain "master" and "origin"

Junio C Hamano:
      GIT-VERSION-GEN: detect dirty tree and mark the version accordingly.
