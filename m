From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn and Author files question
Date: Fri, 14 Apr 2006 13:34:57 -0700
Message-ID: <m21wvzx5e6.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 14 22:35:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUV0V-0001lU-1O
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 22:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWDNUfA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 16:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWDNUfA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 16:35:00 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:677 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965154AbWDNUe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 16:34:59 -0400
Received: by nz-out-0102.google.com with SMTP id o37so179440nzf
        for <git@vger.kernel.org>; Fri, 14 Apr 2006 13:34:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=GHDT9vK4Pl1x6fOYMCim77BCWiT288pg/kTIc1wp8/zXAb7ZJ9KvXhSeIVjvleyiPDTWOF0e9vc1gtdXDgWC7H7fmEcuAxgShOU86XPEAGtBoML5BUpBqyXti2PgV3W3rLyyEudmewIFfQgqEc+R54EJXB0IPmdZbNVX20jEbd4=
Received: by 10.36.146.13 with SMTP id t13mr2684254nzd;
        Fri, 14 Apr 2006 13:34:58 -0700 (PDT)
Received: from ziti.fhcrc.org ( [140.107.181.38])
        by mx.gmail.com with ESMTP id p4sm490968nzc.2006.04.14.13.34.57;
        Fri, 14 Apr 2006 13:34:58 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18699>

Hi all,

I've been using git to manually track changes to a project that uses
svn as its primary SCM.

git-svn looks like it can help me streamline my workflow, but I'm
getting stuck with the following:

    mkdir foo
    cd foo
    git-svn init $URL  <--- the svn URL
    git-svn fetch
    Author: dfcimm3 not defined in  file

:-(

Can someone point me to the file and the place that describes what I
should put in it?  There are many committers to the svn project.  I'm
hoping that I will not have to enumerate all of their names in some
file.

I'm using git version 1.3.0.rc1.g40e9, and BTW, enjoying it very much.

Thanks,

+ seth
