From: salmansheikh <salmanisheikh@gmail.com>
Subject: Re: libz and RHEL 5.9 compile of Git
Date: Wed, 22 Jan 2014 13:27:09 -0800 (PST)
Message-ID: <1390426029203-7602400.post@n2.nabble.com>
References: <1390406392415-7602374.post@n2.nabble.com> <52E02310.9090609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 22:27:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W65KN-0007w1-JO
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 22:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbaAVV1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 16:27:11 -0500
Received: from sam.nabble.com ([216.139.236.26]:36335 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737AbaAVV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 16:27:09 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <salmanisheikh@gmail.com>)
	id 1W65KH-0004Ac-6s
	for git@vger.kernel.org; Wed, 22 Jan 2014 13:27:09 -0800
In-Reply-To: <52E02310.9090609@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240862>

Got it working but then I had some issues with the perl portions of the
install and I subsequently thought I could eliminate those portions and
tried setting export NO_PERL=1 and that installed everything else...and got
pass this error but when I tried to checkout a git repository as follows, I
get some remote helper error. Is that related to the perl parts of the git? 

git clone https://github.com/m-labs/migen.git
Cloning into 'migen'...
fatal: Unable to find remote helper for 'https'


*******************
install -d -m 755 '/home/ssheikh/local/libexec/git-core'
install   git-credential-store git-daemon git-fast-import git-http-backend
git-imap-send git-sh-i18n--envsubst git-shell git-show-index git-upload-pack
git-remote-testsvn git-credential-cache git-credential-cache--daemon git-am
git-bisect git-difftool--helper git-filter-branch git-lost-found
git-merge-octopus git-merge-one-file git-merge-resolve git-mergetool
git-pull git-quiltimport git-rebase git-repack git-request-pull git-stash
git-submodule git-web--browse git-add--interactive git-difftool
git-archimport git-cvsexportcommit git-cvsimport git-cvsserver git-relink
git-send-email git-svn git-remote-testpy git-p4 git-instaweb
'/home/ssheikh/local/libexec/git-core'
install -m 644  git-mergetool--lib git-parse-remote git-rebase--am
git-rebase--interactive git-rebase--merge git-sh-setup git-sh-i18n
'/home/ssheikh/local/libexec/git-core'
install git git-upload-pack git-receive-pack git-upload-archive git-shell
git-cvsserver '/home/ssheikh/local/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/home/ssheikh/Downloads/git-1.8.3.4/templates'
install -d -m 755 '/home/ssheikh/local/share/git-core/templates'
(cd blt && gtar cf - .) | \
        (cd '/home/ssheikh/local/share/git-core/templates' && umask 022 &&
gtar xof -)
make[1]: Leaving directory `/home/ssheikh/Downloads/git-1.8.3.4/templates'
install -d -m 755 '/home/ssheikh/local/libexec/git-core/mergetools'
install -m 644 mergetools/*
'/home/ssheikh/local/libexec/git-core/mergetools'
install -d -m 755 '/home/ssheikh/local/share/locale'
(cd po/build/locale && gtar cf - .) | \
        (cd '/home/ssheikh/local/share/locale' && umask 022 && gtar xof -)
make -C perl prefix='/home/ssheikh/local' DESTDIR='' install
make[1]: Entering directory `/home/ssheikh/Downloads/git-1.8.3.4/perl'
make[2]: Entering directory `/home/ssheikh/Downloads/git-1.8.3.4/perl'
mkdir /usr/local/lib64/perl5: Permission denied at
/usr/lib/perl5/5.8.8/ExtUtils/Install.pm line 112
make[2]: *** [pure_site_install] Error 13
make[2]: Leaving directory `/home/ssheikh/Downloads/git-1.8.3.4/perl'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/ssheikh/Downloads/git-1.8.3.4/perl'
make: *** [install] Error 2
*********************************************************



--
View this message in context: http://git.661346.n2.nabble.com/libz-and-RHEL-5-9-compile-of-Git-tp7602374p7602400.html
Sent from the git mailing list archive at Nabble.com.
