From: "Jeffrey Ollie" <jeff@ocjtech.us>
Subject: Problems importing from Apache SVN
Date: Wed, 23 Apr 2008 12:50:17 -0500
Message-ID: <935ead450804231050u25be05bcjaaab22caa82c984c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 19:51:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joj7k-0000pB-Vr
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 19:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbYDWRub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 13:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbYDWRua
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 13:50:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:4669 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbYDWRua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 13:50:30 -0400
Received: by yw-out-2324.google.com with SMTP id 5so226858ywh.1
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 10:50:19 -0700 (PDT)
Received: by 10.142.141.21 with SMTP id o21mr246667wfd.84.1208973017945;
        Wed, 23 Apr 2008 10:50:17 -0700 (PDT)
Received: by 10.142.172.8 with HTTP; Wed, 23 Apr 2008 10:50:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80234>

Hello,

I'm having some problems importing CouchDB from the Apache SVN
repository.  Here's what I get:

$ rpm -q subversion-perl
subversion-perl-1.4.6-7.x86_64
$ git --version
git version 1.5.5.1
$ git svn init -s http://svn.apache.org/repos/asf/incubator/couchdb
Initialized empty Git repository in .git/
Using higher level of URL:
http://svn.apache.org/repos/asf/incubator/couchdb =>
http://svn.apache.org/repos/asf
$ git svn fetch
W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: REPORT request failed on
'/repos/asf/!svn/bc/100': REPORT of '/repos/asf/!svn/bc/100': 200 OK
(http://svn.apache.org)
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositoriesRA layer request failed:
REPORT request failed on '/repos/asf/!svn/vcc/default': REPORT of
'/repos/asf/!svn/vcc/default': 200 OK (http://svn.apache.org) at
/usr/bin/git-svn line 3833

Could the problem be that the Apache SVN repository has a large number
of commits but there are only a handful that apply to CouchDB.  From
looking at the logs it appears that the following commits are relevant
to CouchDB:

642432, 642445, 642448, 642450, 642660, 642672, 642768, 642775,
642789, 642848, 642965, 643203, 643556, 644444, 644593, 644594,
644649, 644674, 644964, 645171, 645661, 645675, 646163, 646734,
647314, 648023, 648033, 648037, 648039, 648050, 648054, 648060,
648069, 648074, 648081, 648222, 649048, 649948, 649988, 650275,
650705, 650721, 650729

Can anyone help me figure out what's going wrong here? I have plenty
of memory on this system (4Gb) so I don't think that's the problem.

Jeff
