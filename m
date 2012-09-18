From: Stefan Beller <stefbel@web.de>
Subject: git installation fails in home directory on ubuntu 12.04
Date: Tue, 18 Sep 2012 13:23:32 +0200
Message-ID: <505859B4.2090205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 13:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDvu3-00034w-GV
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab2IRLXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:23:35 -0400
Received: from mout.web.de ([212.227.15.4]:61376 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757999Ab2IRLXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:23:34 -0400
Received: from [131.234.64.68] ([131.234.64.68]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M89uv-1TRSPF04Rt-00veEf; Tue, 18 Sep 2012 13:23:32
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
X-Provags-ID: V02:K0:WoII+bZSbtqe9T6Agz3+9f/z3OUow7itZ488vRf4GWU
 pmQ+TnrEoR2ulfO7iGoyro4CaBzoIKWHTZUS1i3vmbTL+vRwNT
 aGE3mG/37QlWBxgBESsOyVovNDbwnmghfslt5Y5GgQpX8WLsJ/
 WC51cSr28ckcvhleQlZRq9c5TZ74cTUQwGnKNT10yBeFpHnwEj
 CHy78mxwGVMyxnIU1jyEA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205821>

So I did
git fetch
git rebase
git describe
v1.7.12-503-g5976753

./configure --prefix=/home/sb
make
make install
    GEN perl/PM.stamp
    SUBDIR gitweb
    SUBDIR ../
    SUBDIR perl
make[1]: `perl.mak' is up to date.
make[2]: `GIT-VERSION-FILE' is up to date.
    GEN git-instaweb
    SUBDIR git-gui
    SUBDIR gitk-git
make[1]: Nothing to be done for `all'.
    SUBDIR perl
    SUBDIR git_remote_helpers
    SUBDIR templates
install -d -m 755 '/home/sb/bin'
install -d -m 755 '/home/sb/libexec/git-core'
install   git-credential-store git-daemon git-fast-import
git-http-backend git-imap-send git-sh-i18n--envsubst git-shell
git-show-index git-upload-pack git-http-fetch git-http-push
git-credential-cache git-credential-cache--daemon git-remote-http
git-remote-https git-remote-ftp git-remote-ftps git-am git-bisect
git-difftool--helper git-filter-branch git-lost-found git-merge-octopus
git-merge-one-file git-merge-resolve git-mergetool git-pull
git-quiltimport git-rebase git-repack git-request-pull git-stash
git-submodule git-web--browse git-add--interactive git-difftool
git-archimport git-cvsexportcommit git-cvsimport git-cvsserver
git-relink git-send-email git-svn git-remote-testgit git-p4 git-instaweb
'/home/sb/libexec/git-core'
install -m 644  git-mergetool--lib git-parse-remote git-rebase--am
git-rebase--interactive git-rebase--merge git-sh-setup git-sh-i18n
'/home/sb/libexec/git-core'
install git git-upload-pack git-receive-pack git-upload-archive
git-shell git-cvsserver '/home/sb/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/home/sb/OSS/git/templates'
install -d -m 755 '/home/sb/share/git-core/templates'
(cd blt && tar cf - .) | \
	(cd '/home/sb/share/git-core/templates' && umask 022 && tar xof -)
make[1]: Leaving directory `/home/sb/OSS/git/templates'
install -d -m 755 '/home/sb/libexec/git-core/mergetools'
install -m 644 mergetools/* '/home/sb/libexec/git-core/mergetools'
install -d -m 755 '/home/sb/share/locale'
(cd po/build/locale && tar cf - .) | \
	(cd '/home/sb/share/locale' && umask 022 && tar xof -)
make -C perl prefix='/home/sb' DESTDIR='' install
make[1]: Entering directory `/home/sb/OSS/git/perl'
make[2]: Entering directory `/home/sb/OSS/git/perl'
Appending installation info to /usr/local/lib/perl/5.14.2/perllocal.pod
mkdir /usr/local/lib/perl: Permission denied at
/usr/share/perl/5.14/ExtUtils/Command.pm line 288
make[2]: [doc_site_install] Error 13 (ignored)
/bin/sh: 1: cannot create /usr/local/lib/perl/5.14.2/perllocal.pod:
Directory nonexistent
make[2]: [doc_site_install] Error 2 (ignored)
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ERROR: Can't create '/usr/local/share/man/man3'
mkdir /usr/local/share/man/man3: Permission denied at
/usr/share/perl/5.14/ExtUtils/Install.pm line 494

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 at -e line 1
make[2]: *** [pure_site_install] Error 13
make[2]: Target `install' not remade because of errors.
make[2]: Leaving directory `/home/sb/OSS/git/perl'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/sb/OSS/git/perl'
make: *** [install] Error 2
