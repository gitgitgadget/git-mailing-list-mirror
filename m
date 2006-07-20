From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn + publishing repos question
Date: Thu, 20 Jul 2006 12:41:52 -0700
Message-ID: <m2d5c0cbcv.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 20 21:42:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3ePJ-0003Dy-QQ
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 21:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030366AbWGTTl7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 15:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWGTTl6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 15:41:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:63297 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030366AbWGTTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 15:41:58 -0400
Received: by wr-out-0506.google.com with SMTP id 70so268476wra
        for <git@vger.kernel.org>; Thu, 20 Jul 2006 12:41:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=qzhcO+X+JW/CyGKiWo1jqJD4RgZ4CgT5mE4U0BT5dxVexPvByv75rXmj/0bI5LcfEOv8da0+OXPpXdY11YTprkmIQvQrwAMZYW0ozeh212TzTJUvsRdfUJkowXzTpGw92AzAXHYF7vvEk5bBJ8kYMjyyI8rL1/1y2hWagY2AmyI=
Received: by 10.65.51.3 with SMTP id d3mr149191qbk;
        Thu, 20 Jul 2006 12:41:57 -0700 (PDT)
Received: from ziti.local ( [140.107.181.122])
        by mx.gmail.com with ESMTP id r15sm1249700nza.2006.07.20.12.41.55;
        Thu, 20 Jul 2006 12:41:56 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24036>

Hi all,

I want to publish a read-only git mirror of a project that uses svn.

So far, I have a git repository served by git-daemon and git-svn has
been used to create remotes/git-svn.  I'm thinking the git-svn fetch
can be put in chron.

I know that I could pull remotes/git-svn into master (and also chron
that), but is there a shortcut (to trick the repos into thinking that
master and remotes/git-svn are the same)?

Other suggestions?

Thanks,

+ seth
