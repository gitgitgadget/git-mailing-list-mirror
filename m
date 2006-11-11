X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-1.5.3
Date: Sat, 11 Nov 2006 09:06:20 +0100
Message-ID: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 11 Nov 2006 08:07:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c8zkq7L9Ve860kWWa5BR6YWMM1H4sdgbajYst608ooYwS1iw7KFU8aLir2H+zWGbmdliXzKWCIcBOeMJ8GfDtvlfl7E7xaBth/X5eH8lHeQo0MNAdM/Tc/Bq0Obn2D/DevY72MNr3BvoosoP5XMuwf5ZW1rsuKBav57lc13ALpo=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31210>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GintE-0004Vs-TJ for gcvg-git@gmane.org; Sat, 11 Nov
 2006 09:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947147AbWKKIG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 03:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947150AbWKKIG4
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 03:06:56 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:23909 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S1947148AbWKKIGy
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 03:06:54 -0500
Received: by py-out-1112.google.com with SMTP id a29so392071pyi for
 <git@vger.kernel.org>; Sat, 11 Nov 2006 00:06:21 -0800 (PST)
Received: by 10.35.70.2 with SMTP id x2mr5323321pyk.1163232380927; Sat, 11
 Nov 2006 00:06:20 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sat, 11 Nov 2006 00:06:20 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Sender: git-owner@vger.kernel.org

qgit it's a graphical git repositories viewer built on Qt libraries.

This is mostly a bug fix release.

Several issues has been fixed, also some crash bugs, so an update is
strongly suggested.

To note is the new possibility to set the font used by patch and file
content viewers.

Thanks to Pavel Roskin and Josef Weidendorfer for their help and patches.


Download tarball from http://www.sourceforge.net/projects/qgit
or directly from git public repository
git://git.kernel.org/pub/scm/qgit/qgit.git

Please refer to http://digilander.libero.it/mcostalba/ for additional
information.

	Marco


ChangeLog from 1.5.2

- use a smaller tab close button and a smaller icon (Pavel Roskin)

- fix a crash in case of repo change while in filtered view

- fix a crash due to evil static pointers

- clear all the panes if search from the toolbar doesn't find anything

- silence a Qt warning when closing a tab

- let the user to set the typewriter (fixed width) font used
  with patch and file content viewers

- fix broken StGit 'pop' command interface

- do not use "--keep" option of git-am as default

- fix issues with tag marks when changing graph size

- fix filenames cache data saving in case of bare repositories

- rewrite and simplify graph drawing code (Josef Weidendorfer)

- fix issues with file names with spaces

- adjust columns width when changing window size

- fetch file history from all trees instead of only current

- early exit update cycle when a new request arrives

- correctly order tags in start-up input range dialog

