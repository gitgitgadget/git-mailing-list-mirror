From: "Scott Chacon" <schacon@gmail.com>
Subject: re-licensing pkt-line.c code
Date: Thu, 25 Sep 2008 10:17:52 -0700
Message-ID: <d411cc4a0809251017h5509bbdmaef935c61cc0929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 19:19:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiuUn-0000I8-P0
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 19:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556AbYIYRRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYIYRRy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 13:17:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:40158 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbYIYRRx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 13:17:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so590088wfd.4
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=uHLF3vWWeNiGjQ4y5SYlh1AnJGXaHYWhLapdyqhu6ZA=;
        b=ifw8qeKNVyut9uHDHpniD1+LTt2mTLxoVPOGpypnIFwrPxLhI6pb8rBB+oXSHFM9Oo
         em6DmlDFHpiW8dLu5aCUPq1RThOxMZnH3fF+ivKaPWum5f+XvuFR8J2UANX4fqrQuO2p
         C5fbwzM/lsJOLmoilZFn1GlZ3cS1cxdDICf7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=RJ+7GtgMK0KVmOHYiqwgVm/XbvyQsQtSUaeaVcjjiJsNawL6DpHdxRxIdAOjm0HzLC
         iDTYXiaTPWSMOg+2IyGdU6XPfna65V+LMAGEv2FIvfj9J8OEedPqaYwmjhoBisu2Djm3
         zH/j6wlhPGN/PHdOCnqwJcSRdnim/94Mmnj5s=
Received: by 10.114.46.6 with SMTP id t6mr49765wat.39.1222363073039;
        Thu, 25 Sep 2008 10:17:53 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Thu, 25 Sep 2008 10:17:52 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96785>

Hey all,

I am writing a partial implementation of git in Objective-C so I can
get a git server running on an iphone, and hopefully it could
eventually be used in a mac desktop app that could be distributed
without the git binary. If anyone is interested in the project, you
can get it here:

http://github.com/schacon/objective-git

There are about 20-25 lines of code from pkt-line.c that I think were
originally written back in 2005 that I would like to use so I don't
have to re-implement them.  It is pretty generic - it is just the code
that converts an int into a 4 char hex and back that is placed at the
beginning of several of the network protocol lines.

http://github.com/schacon/objective-git/tree/master/ObjGitServerHandler.m#L554

I have to relicense this, since I can't legally distribute my source
code for the iphone app due to Apples f**king NDA.  I would like to
release my ObjectiveGit project under the MIT (or, alternately, LGPL).
 Is Linus the right person to ask for this permission?  What is the
best way to do so?  I could come up with an alternate way to
accomplish the same thing, but it seems like a waste of time to do so,
and helpful to nobody.

Thanks,
Scott
