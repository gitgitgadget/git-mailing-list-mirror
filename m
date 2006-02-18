From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit 1.1
Date: Sat, 18 Feb 2006 14:14:42 +0100
Message-ID: <e5bfff550602180514p2ef6eefodb6112cb3b32041f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sat Feb 18 14:14:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FARvC-0000fg-Lx
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 14:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWBRNOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBRNOo
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 08:14:44 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:30683 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751225AbWBRNOn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 08:14:43 -0500
Received: by wproxy.gmail.com with SMTP id i22so587338wra
        for <git@vger.kernel.org>; Sat, 18 Feb 2006 05:14:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JNkRA2AMYgDaZFww35hJj6l4ahKSzJKJ1VPHdIktLJZS6oKbuugAMlYfxlA1wY9DgwA2kl8abVYJKSADJsxVHm6XygfrLmqeTP+Qc7u8RHWoLk70O6AajhKGmsT6owiUGqyz7YsGhFgtHsbbg20cpfht9dGi8nbBAMH2B8znPpY=
Received: by 10.64.243.19 with SMTP id q19mr1500599qbh;
        Sat, 18 Feb 2006 05:14:42 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 18 Feb 2006 05:14:42 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16413>

This is qgit-1.1

With qgit you will be able to browse revisions history, view patch
content and changed
files, graphically following different development branches.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

  - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh
   current top one using the same semantics of git commit, i.e. cherry picking
   single modified files.


NEW IN THIS RELEASE

A lot of work has been done by Pavel and me from 1.0, too much to list.
A notably change from the last rc3 is a much improved GUI, courtesy of Pavel,
and various stability fixes.

Update to 1.1 is suggested for all users.

Please note that you will need git 1.2 or newer.


DOWNLOAD

SourceForge tarball link is:

      http://prdownloads.sourceforge.net/qgit/qgit-1.1.tar.bz2?download


Refer to http://digilander.libero.it/mcostalba/ for additional links
and detailed change log.

Installation should be as simple as ./configure + make + make install-strip

The last one (install-strip) to have a much smaller bin with debug
info stripped.
Please refer to shipped README file for more information.

In case you prefer to clone from the public git repository:

  http://digilander.libero.it/mcostalba/scm/qgit.git

you may run 'autoreconf -i' before ./configure


	Marco
