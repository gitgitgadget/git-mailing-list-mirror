From: Marco Costalba <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.1rc3
Date: Sun, 5 Feb 2006 00:34:26 +0100
Message-ID: <e5bfff550602041534k4ffa1fcarfd12b347bdbc0902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Feb 05 00:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5WvG-0003NO-56
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 00:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWBDXe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 18:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBDXe1
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 18:34:27 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:21595 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964881AbWBDXe1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 18:34:27 -0500
Received: by wproxy.gmail.com with SMTP id i23so848312wra
        for <git@vger.kernel.org>; Sat, 04 Feb 2006 15:34:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iUeVIAaT0wlhIK2SdzcrzmOkPcSJtkE28LX4okfm4YO3CUzjPxy4lxOF05WmmoUacMw/JgfQQvlcVd9omMDWCZCQ1MI6j2lqXQgQ9T+8BaDdG7PmjsaYeTUfopSMEaIJc2vab5Ow5ArkJXeI5+pd3IFPVDEWPPxRYZJhYvnYMC0=
Received: by 10.65.183.2 with SMTP id k2mr57334qbp;
        Sat, 04 Feb 2006 15:34:26 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 4 Feb 2006 15:34:26 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15611>

This release is mainly about the new build system, based on auto tools
instead of scons (courtesy of Pavel Roskin).

To install now use ./configure + make + make install-strip
Or check the README for detailed information.

To note is also the use of git-diff-tree -c option to prune
uninteresting files in merges and to show merge diffs patch.

See http://digilander.libero.it/mcostalba/  for download information.

Changes:
- new build environment based on auto-tools instead of scons (by Pavel Roskin)
- SunOS make cannot chain implicit rules - avoid them (by Pavel Roskin)
- make sure wrong version of Qt is not used (by Pavel Roskin)
- support patch files with spaces in name
- fixes for using srcdir in src/Makefile.am (by Pavel Roskin)
- future-proof configure.ac (by Pavel Roskin)
- use git-diff-tree -c (combined) option to retrieve merge's file list
- fix disabled 'show file viewer' action when no file selected from tree
- use --remove-empty option to retrieve file history
- fix jump to parent/childs lanes pop-up menu
- allow to copy an annotation header sub part in file viewer
- fix handling of command line arguments with single quotes
- widget sizes tweaks and small fixes


Marco
