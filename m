From: "Here I. Come" <me.detected@gmail.com>
Subject: Bad URL passed to RA layer ('https')
Date: Tue, 4 May 2010 13:18:56 +0400
Message-ID: <l2y5208b6091005040218t2890b871x1753a1788b67350b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 11:34:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9EVx-0007mL-PT
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 11:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab0EDJeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 05:34:00 -0400
Received: from mail-bw0-f171.google.com ([209.85.218.171]:56406 "EHLO
	mail-bw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0EDJd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 05:33:59 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 05:33:58 EDT
Received: by bwz19 with SMTP id 19so194330bwz.9
        for <git@vger.kernel.org>; Tue, 04 May 2010 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=/dKXWRq5IhRtbrnIGcDi+7GGA8pJjWaCKRiB2WGAAmI=;
        b=MvJUnLY1hXT3DABIX6ebWnvyUy0QZt/4kFTySl/K10u+z6n5V4a7ijXYFtlw3UztBR
         mcSr/WzecGZlwdoNk5eWMkZuWcCRpTD3SbUcI3wclYDdPnpGHgYkkdlXMgLvnPe+9DbP
         MoR0sKwzVteqys5g2bHgulcp+fhQI5995ZmsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=G80Y08gisbEhcvyc0qw9gUm4BwaiOH0zCQusz/TZMFL8uJgXD0qMAm+hRzuRLl2OX8
         xUV+uAcRcwpOSwCNp5eZ3Cqixctl+4CgnY8gVEj5oWhxKrOOSs9kNHfUy5ZNN4wlzTTO
         SSGX7lXBskYTbBbN6ivYVbTsa2tCYxn4li7xM=
Received: by 10.204.33.16 with SMTP id f16mr666691bkd.11.1272964736420; Tue, 
	04 May 2010 02:18:56 -0700 (PDT)
Received: by 10.204.156.22 with HTTP; Tue, 4 May 2010 02:18:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146306>

Hi, list.

Googled and searched the list on this problem. No luck...

------------------8<-----------------------
$ git svn clone https://host/svn/myrepo
Initialized empty Git repository in /tmp/myrepo/.git/
Bad URL passed to RA layer: Unrecognized URL scheme for
'https://host/svn/myrepo' at /usr/libexec/git-core/git-svn line 1770
------------------8<-----------------------

Could not clone from a repository. Although if I issue 'svn checkout
https://host/svn/myrepo' it will work, so it seems that the problem is
connected with git. Cannot check if this happens only with 'https',
sorry.

versions used:

------------------8<-----------------------
$ git --version
git version 1.7.1

$ svn --version
svn, version 1.6.11 (r934486)
   compiled Apr 30 2010, 02:06:58

Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme

------------------8<-----------------------

Running on Slackware-current.

Thanks.
