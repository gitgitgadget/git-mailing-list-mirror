From: layer <layer@known.net>
Subject: git branch -a prefixes origin/ branches with remotes/
Date: Wed, 31 Mar 2010 10:26:27 -0700
Message-ID: <18137.1270056387@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 19:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx1m5-00035u-4S
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798Ab0CaRcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 13:32:09 -0400
Received: from relay.known.net ([173.13.135.57]:43349 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504Ab0CaRcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:32:08 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2010 13:32:08 EDT
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.21) id 000000088310; Wed, 31 Mar 2010 10:26:27 -0700
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143685>

In git 1.6.6.1 & 1.6.3.3, "git branch -a" output is like this

* master
  remotes/origin/foo
  ...

instead of like this for 1.6.1.3

* master
  origin/foo
  ...


Is this a feature or bug?  I searched the mailing list archives and
announcements couldn't find any reference to this change.

This is important to me because I use the output of "git branch -a" in
scripts.

Thanks.

Kevin
