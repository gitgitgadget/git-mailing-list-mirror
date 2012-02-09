From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 13:23:18 -0800
Message-ID: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:23:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbSd-0005HJ-Go
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189Ab2BIVXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:23:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39490 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124Ab2BIVXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:23:18 -0500
Received: by yenm8 with SMTP id m8so1166975yen.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0zd6CotM/v6FdUT6bBHwO76eLU4/0BDUnMDolaRKxtI=;
        b=x9g9ykq49+pL1rBCR2BLFSzWplVZ7cg4E2Nhl4QMAuCxIi97l45yhSvHvkpMubFWPf
         bSfkRYvlYsw5WhNLNvKZjbOXY5+QxBy9U5vy8bYVWOy7pEDz2boavVtNhoeQR83xjA7N
         Totk9gQxe4He0OyZdG0SP1bN6BGccbZFKR2DM=
Received: by 10.100.231.4 with SMTP id d4mr1618029anh.37.1328822598211; Thu,
 09 Feb 2012 13:23:18 -0800 (PST)
Received: by 10.236.73.130 with HTTP; Thu, 9 Feb 2012 13:23:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190326>

Hi all,

I'm thinking about trying out different filesystems over the weekend
to see if, say, BTRFS or XFS is faster when using Git and running our
build.

Currently, I'm using ReiserFS and it's not like it's not working. I'm
very pleased with ReiserFS but after seeing talks about BTRFS and XFS
I'm curious if another (newer) FS is better suited to our specific
environment. Anything to make the build a little faster. :-)

For the record, our (Java) project is quite small. It's 43MB (source
and images) and the entire directory tree after building is about
1.6GB (this includes all JARs downloaded by Maven). So we're not
talking TBs of data.

Any thoughts on which FSs to include in my tests? Or simply which FS
might be more appropriate?

Cheers,
Hilco
