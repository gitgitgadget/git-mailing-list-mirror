From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git under OSX leopard?
Date: Wed, 26 Mar 2008 11:10:17 -0700
Message-ID: <867ifp5pbq.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 19:34:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeaR1-0001pI-5l
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 19:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757359AbYCZScd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757206AbYCZScd
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 14:32:33 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:9673 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbYCZScc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 14:32:32 -0400
X-Greylist: delayed 1334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2008 14:32:32 EDT
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CC7311DE262; Wed, 26 Mar 2008 11:10:17 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.3.9; tzolkin = 2 Muluc; haab = 17 Cumku
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78296>


I'm trying to build git on leopard for the first time.  Getting this
error (after git clean -d -f and no unusual flags):

    LINK git-daemon
/usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/gcc/i686-apple-darwin8/4.0.1/../../../libcurl.dylib load command 8 unknown cmd field
/usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/gcc/i686-apple-darwin8/4.0.1/../../../libSystem.dylib unknown flags (type) of section 6 (__TEXT,__literal16) in load command 0
/usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/libSystem.B.dylib unknown flags (type) of section 6 (__TEXT,__literal16) in load command 0
/usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/libgcc_s.1.dylib load command 8 unknown cmd field
collect2: ld returned 1 exit status
make: *** [git-daemon] Error 1

Same thing builds fine on tiger.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
