From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-2.0rc1
Date: Sun, 10 Jun 2007 13:47:17 +0200
Message-ID: <e5bfff550706100447g5d34adf2j92389cd193658738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Pavel Roskin" <proski@gnu.org>,
	"Andy Parkins" <andyparkins@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 10 13:47:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxLtC-0003jt-Lk
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 13:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbXFJLrT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXFJLrS
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 07:47:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:23904 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbXFJLrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 07:47:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1730344wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 04:47:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ulbWfWVeXHWdCED/6/bC7nmtrKj9bVuqC4yZJdZKWg/8gFt2pYcRwzb8HlARwsVj0KGED6r1YEzCB+4u7KO1AV5SLWkvZgxvQ6fpOPkRxXajJpBJBmNHh+vSbf6p4JeDeVPUMmIOVylfX2q9Zvx8rdq1v7tMh9D86wIfEZzpL64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c4nbNPaEL0zUi9mb1b6tzgISuampxQ0LaTRASyiCUlzwEtSRgbC6pP/4QCQ78zeNxCGNmwrvCfYMI9Q60ZHrfGzvQmW1YWBlBE5mWLTkGd5YuXoHw623mH7YYT53UEpqXZechDKr9P1XkWtRzq5LGspIyOUQBz22rH3Yj4iazLk=
Received: by 10.114.195.19 with SMTP id s19mr4452711waf.1181476037329;
        Sun, 10 Jun 2007 04:47:17 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 04:47:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49711>

This is qgit-2.0rc1

With qgit you will be able to browse revision histories, view patch
content and changed files, graphically following different development
branches.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

  - Apply or format patch series from selected commits, drag and drop
commits between two instances of qgit.

 - Associate commands sequences, scripts and anything else executable
to a custom action. Actions can be run from menu and corresponding
output is grabbed by a terminal window.

  - qgit implements a GUI for the most common StGIT commands like
push/pop and apply/format patches. You can also create new patches or
refresh current top one using the same semantics of git commit, i.e.
cherry picking single modified files.


NEW IN THIS RELEASE

This is the first public release of the shining new qgit 2.0 based on
the shining new Qt 4.2 libraries.

This is the result of more the five months of porting efforts.

All the features of the stable series have been ported. In addition
this new release sports a better GUI both on visually side, thanks to
the work of Andy Parkins on the new revision description pane header,
and on usability side.

A new and much improved repository browsing experience is now
possible, in particular you don't need to switch to patch tab to view
diff content anymore. Patch information, together with patch
description, is shown in bottom left pane.

New browsing features are:

- Possibility to switch from revision message to diff content in
  bottom left pane of main view (from menu or key shortcut 'm')

- Possibility to jump to next/previous revision with link labels at
  the pane corners

- Optional use of mouse wheel to perform all of the above actions

- Added small tabs to description pane with log and diff info.


All this is tweakable from 'Edit->Settings->Browse' menu dialog, so to
let fine grain control on the preferred browse setting.

For an history viewer easy and quick browsing is the single MOST
important feature.


A lot has changed, apart from browsing, the list would be very long,
so the best thing is to download and check yourself.

This is a 'rc' release, but should be already quite stable, so I
encourage everyone interested to give it a spin.


You can download the tarball from
http://downloads.sourceforge.net/qgit/qgit-2.0rc1.tar.bz2

or clone the public git archive at
git://git.kernel.org/pub/scm/qgit/qgit4.git


Please, check the shipped README for detailed build and install information.


I would like to thank Pavel Roskin and Andy Parkins for their very
valuable support in shaping this new release.


Ah, the last thing, because we are Qt4 now, qgit 2.0rc1 works natively
also under Windows.


Have fun
Marco
