From: salmansheikh <salmanisheikh@gmail.com>
Subject: libz and RHEL 5.9 compile of Git
Date: Wed, 22 Jan 2014 07:59:52 -0800 (PST)
Message-ID: <1390406392415-7602374.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 16:59:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W60Dd-0004LM-15
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 16:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbaAVP7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 10:59:53 -0500
Received: from sam.nabble.com ([216.139.236.26]:37271 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbaAVP7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 10:59:52 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <salmanisheikh@gmail.com>)
	id 1W60DY-0005zi-Dt
	for git@vger.kernel.org; Wed, 22 Jan 2014 07:59:52 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240835>

Hello,

I have a RHEL system that I am not the admin of. I needed to install git and
got the source. Everything is okay until I got to this point below. I
downloaded and installed the latest libz (1.2.8) but i installed it under a
local directory under my user name (i.e. /home/ssheikh/local). The problem
is that git only looks in the locations below. I even have that directory in
my $LD_LIBRARY_PATH. So, how can I force make to use that version of libz
and not the old one that came with this RHEL 5.9 distro?

[ssheikh@gs-560g3080090e git-1.8.3.4]$ make
    LINK git-credential-store
/usr/bin/ld: skipping incompatible /lib/libz.so when searching for -lz
/usr/bin/ld: skipping incompatible /usr/lib/libz.so when searching for -lz
/usr/bin/ld: skipping incompatible /usr/lib/libz.a when searching for -lz
/usr/bin/ld: cannot find -lz
collect2: ld returned 1 exit status
make: *** [git-credential-store] Error 1




--
View this message in context: http://git.661346.n2.nabble.com/libz-and-RHEL-5-9-compile-of-Git-tp7602374.html
Sent from the git mailing list archive at Nabble.com.
