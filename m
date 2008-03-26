From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git under OSX leopard?
Date: Wed, 26 Mar 2008 12:53:25 -0700
Message-ID: <86d4ph45ze.fsf@blue.stonehenge.com>
References: <867ifp5pbq.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JebhI-0003od-OC
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 20:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYCZTx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 15:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbYCZTx1
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 15:53:27 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:22472 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbYCZTx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 15:53:26 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B07401DE347; Wed, 26 Mar 2008 12:53:25 -0700 (PDT)
x-mayan-date: Long count = 12.19.15.3.9; tzolkin = 2 Muluc; haab = 17 Cumku
In-Reply-To: <867ifp5pbq.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Wed, 26 Mar 2008 11:10:17 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78302>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal> I'm trying to build git on leopard for the first time.  Getting this
Randal> error (after git clean -d -f and no unusual flags):

Randal>     LINK git-daemon
Randal> /usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/gcc/i686-apple-darwin8/4.0.1/../../../libcurl.dylib load command 8 unknown cmd field
Randal> /usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/gcc/i686-apple-darwin8/4.0.1/../../../libSystem.dylib unknown flags (type) of section 6 (__TEXT,__literal16) in load command 0
Randal> /usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/libSystem.B.dylib unknown flags (type) of section 6 (__TEXT,__literal16) in load command 0
Randal> /usr/libexec/gcc/i686-apple-darwin8/4.0.1/ld: /usr/lib/libgcc_s.1.dylib load command 8 unknown cmd field
Randal> collect2: ld returned 1 exit status
Randal> make: *** [git-daemon] Error 1

Randal> Same thing builds fine on tiger.

Wow.  I upgraded XCode, thinking that was the problem, and now
I get even more nowhere:

GIT_VERSION = 1.5.5.rc1.12.g660b9
    * new build flags or prefix
    CC daemon.o
/usr/libexec/gcc/i686-apple-darwin8/4.0.1/as: assembler (/usr/bin/../libexec/gcc/darwin/i386/as or /usr/bin/../local/libexec/gcc/darwin/i386/as) for architecture i386 not installed
Installed assemblers are:
/usr/bin/../libexec/gcc/darwin/ppc64/as for architecture ppc64
/usr/bin/../libexec/gcc/darwin/x86_64/as for architecture x86_64
make: *** [daemon.o] Error 1

Help!

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
