From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Tue, 13 Nov 2012 21:45:00 +0100
Message-ID: <50A2B14C.9040608@web.de>
References: <20121113175205.GA26960@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>, mlevedahl@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 13 21:45:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYNMT-0002vK-Cf
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 21:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab2KMUpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 15:45:18 -0500
Received: from mout.web.de ([212.227.17.11]:62238 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777Ab2KMUpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 15:45:17 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0M57ja-1TNr7K3qk2-00ygXt; Tue, 13 Nov 2012 21:45:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121113175205.GA26960@sigill.intra.peff.net>
X-Provags-ID: V02:K0:wsgjqt17bxhmxKi8FKRIabFWZdo0T1uw0BUL6hae9bX
 bY3C/vOey9uEYJ4N0EhqFAClrD7Mb0GJQCCHab262Sj8dWhboU
 rcDAjl20WZE2sN+7sLum9QeTu1lHz2xqkrei8AGiGyl8f3xf/d
 4T3UrLJtdRVOrfSlCukHsXFDq67iQ3mMOWfLZX82+vSK/j27jD
 LtR1BxNDSa45DYbmgLU5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209671>

> * ml/cygwin-mingw-headers (2012-11-12) 1 commit
>  - Update cygwin.c for new mingw-64 win32 api headers
> 
>  Make git work on newer cygwin.
> 
>  Will merge to 'next'.

(Sorry for late answer, I managed to test the original patch minutes before Peff merged it to pu)
(And thanks for maintaining git)

Is everybody using cygwin happy with this?

I managed to compile on a fresh installed cygwin,
but failed to compile under 1.7.7, see below.
Is there a way we can achieve to compile git both under "old" and "new" cygwin 1.7 ?
Or is this not worth the effort?
/Torsten



    CC compat/cygwin.o
In file included from compat/../git-compat-util.h:90,
                 from compat/cygwin.c:9:
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:103:2: warning: #warning "fd_set and associated macros have been defined in sys/types.      This may cause runtime problems with W32 sockets"
In file included from /usr/include/sys/socket.h:16,
                 from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/cygwin/socket.h:29: error: redefinition of `struct sockaddr'
/usr/include/cygwin/socket.h:41: error: redefinition of `struct sockaddr_storage'
In file included from /usr/include/sys/socket.h:16,
                 from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/cygwin/socket.h:59: error: redefinition of `struct linger'
In file included from compat/../git-compat-util.h:131,
                 from compat/cygwin.c:9:
/usr/include/sys/socket.h:30: error: conflicting types for 'accept'
/usr/lib/gcc/i686-pc-cygwin/3.4.4/../../../../include/w32api/winsock2.h:536: error: previous declaration of 'accept' was here
