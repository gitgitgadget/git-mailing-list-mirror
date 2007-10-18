From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: git-svn help for authorsfile
Date: Thu, 18 Oct 2007 14:26:30 +0800
Message-ID: <4b3406f0710172326y29c73a79x648ef98208adba78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 08:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOqh-0003kD-QG
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 08:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757200AbXJRG0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 02:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761563AbXJRG0c
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 02:26:32 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:27137 "EHLO
	hs-out-2021.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbXJRG0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 02:26:31 -0400
Received: by hs-out-2021.google.com with SMTP id 54so51919hsz
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=NQxTTqWIEx/ZlNPPs4dzHTDOGfQGEXGQFbMcVHAphSE=;
        b=R5nGjocH/xfYeZhr7smMXyiU3EpzsV5vZYxyC5vuFw8Dv1zMt257+3YIedph+2nCovwX5kS3JHWVs9tZ+hQzmNBaYfupBn8K43x9XK/aZ5AVcy4dX9XSdoSPZ1ZTmqvpZoNpctxe0uWxKOrMhD9Vd/n2c5Hr+NEwmxZOFXDYAHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aHNwoh4x5ofdC6ItNNg5XrZ1NSkMJGzf6EL/eP1wQRE+3WEuXhUJU05P5xzsErm+IftETFoegngDDbSJXX6ogp3bTc75W9nm4ZQrQ2Lou9rmkFjgKLb4zak2yCYPXpCWxFKvec8YRzQpnVhmui6cxNV9j8urVKRWKg5Su8tB8rY=
Received: by 10.90.95.11 with SMTP id s11mr368619agb.1192688790125;
        Wed, 17 Oct 2007 23:26:30 -0700 (PDT)
Received: by 10.90.73.10 with HTTP; Wed, 17 Oct 2007 23:26:30 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61494>

In general, all svn projects share the same authorsfile, e.g.

[svn]
authorsfile=/path/to/authorsfile

[svn-remote "project-a"]
   url = http://server.org/svn
   branches = branches/*/project-a:refs/remotes/project-a/branches/*
   tags = tags/*/project-a:refs/remotes/project-a/tags/*
   trunk = trunk/project-a:refs/remotes/project-a/trunk

[svn-remote "project-b"]
   url = http://server.org/svn
   branches = branches/*/project-b:refs/remotes/project-b/branches/*
   tags = tags/*/project-b:refs/remotes/project-b/tags/*
   trunk = trunk/project-b:refs/remotes/project-b/trunk

But if  project-a and project-b has same svn id, map to different
user/email, how do I do?

Can we move authorsfile from svn to svn-remote section ?

Thanks for some help,

---
Dongsheng
