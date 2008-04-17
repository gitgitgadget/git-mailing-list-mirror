From: "Miguel Vaz" <hepaminondas@gmail.com>
Subject: Problem with tar while installing git
Date: Thu, 17 Apr 2008 13:35:35 +0200
Message-ID: <4c610e240804170435p7a628e4bo84c92f4eb4bb7a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 17 13:36:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmSPd-0005EB-ID
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 13:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbYDQLfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 07:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbYDQLfh
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 07:35:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:5628 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbYDQLfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 07:35:36 -0400
Received: by wf-out-1314.google.com with SMTP id 28so20749wff.4
        for <git@vger.kernel.org>; Thu, 17 Apr 2008 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=vXzdTlgEjrNMasQB98Zpd8R8xV5FI/EDEgUijDt9Dac=;
        b=pW781Rz4+771ggBGCezvg0zC6SeKizGInjdJYDJJmEkWp18jwECy9ccAYP9VI9iaYMWtm8ec2Gfoq4pD3BJP0U1iYanSnQoF1HlzHchLO1zLPp6qQo1DjnEKJQkiYQh2gJPW9+HB0l7xIFjr+15znYeQDLyelJEGaUoQaOPmB7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LrIxgMnFxw0ORu8P3qtOg4LIC9Nh7pobP7B3VFDY18b0NDHNsqNUb4m4VY8niXi71TUfWTSTnr6ogXEwVnRIc1TlJDcfQXjz/ZXLxe1oHFIDWWbtZFddlhsZh2nH1e+rfg/UvjypnXWn0vY9sgJ7/boiAN/fe++icW+S3tg5CzU=
Received: by 10.142.58.9 with SMTP id g9mr407195wfa.44.1208432135917;
        Thu, 17 Apr 2008 04:35:35 -0700 (PDT)
Received: by 10.143.191.4 with HTTP; Thu, 17 Apr 2008 04:35:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79786>

Hi all,

I've already googled around to see if this is a known issue, but found nothing.
When installing git, after

   ./configure --prefix=$HOME/local
   make
   make install

I get the the following error message:

install  git-daemon git-fast-import git-fetch-pack git-hash-object
git-imap-send git-index-pack git-merge-index git-merge-tree git-mktag
git-mktree git-pac
k-redundant git-patch-id git-receive-pack git-send-pack git-shell
git-show-index git-unpack-file git-update-server-info git-upload-pack
git-var git-http-pu
sh git-am git-bisect git-clone git-filter-branch git-lost-found
git-merge-octopus git-merge-one-file git-merge-resolve git-merge
git-merge-stupid git-merge
tool git-parse-remote git-pull git-quiltimport git-rebase--interactive
git-rebase git-repack git-request-pull git-sh-setup git-stash
git-submodule git-web-
-browse git-add--interactive git-archimport git-cvsexportcommit
git-cvsimport git-cvsserver git-relink git-send-email git-svn
git-instaweb '/home/mvaz/loca
l/bin'
install git '/home/mvaz/local/bin'
make -C templates DESTDIR='' install
make[1]: Entering directory `/home/mvaz/git-1.5.5/templates'
install -d -m 755 '/home/mvaz/local/share/git-core/templates/'
(cd blt && tar cf - .) | \
(cd '/home/mvaz/local/share/git-core/templates/' && umask 022 && tar xf -)
tar: This does not look like a tar archive
tar: Skipping to next header
tar: Archive contains obsolescent base-64 headers
tar: Error exit delayed from previous errors
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/mvaz/git-1.5.5/templates'
make: *** [install] Error 2

Any thoughts?

Miguel

PS. Running suse

mvaz@grobi> uname -a
Linux grobi 2.6.13-15.18-smp #1 SMP Tue Oct 2 17:36:20 UTC 2007 i686
i686 i386 GNU/Linux
