From: Pavel Roskin <proski@gnu.org>
Subject: Please rename t/t6000-lib.sh - it gets run as test
Date: Fri, 08 Jul 2005 14:09:53 -0400
Message-ID: <1120846193.27711.6.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 20:10:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqxIU-0006XE-DK
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 20:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVGHSJy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 14:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVGHSJy
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 14:09:54 -0400
Received: from h-64-105-159-118.noclli.covad.net ([64.105.159.118]:40342 "HELO
	roinet.com") by vger.kernel.org with SMTP id S262364AbVGHSJx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 14:09:53 -0400
Received: (qmail 490 invoked from network); 8 Jul 2005 18:09:53 -0000
Received: from mtproxy.roinet.com (HELO dv) (192.168.1.1)
  by roinet.com with SMTP; 8 Jul 2005 18:09:53 -0000
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.3 (2.2.3-8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

t/t6000-lib.sh has a bad name - it matches the wildcard for tests and
gets run by "make test".  The only side effect is an empty file named
t/sed.script.  This is pretty benign, but let's fix it.

I suggest renaming t6000-lib.sh to t6000.lib.sh but I'll be happy with
any other name that doesn't match t[0-9][0-9][0-9][0-9]-*.sh

Alternatively, we could filter out *-lib.sh in t/Makefile, but I think
it would be more error prone.

-- 
Regards,
Pavel Roskin
