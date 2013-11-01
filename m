From: Sitesh Shrivastava <siteshshrivastava@gmail.com>
Subject: error: unpack failed: unpack-objects abnormal exit
Date: Fri, 1 Nov 2013 16:02:10 +0530
Message-ID: <CALK6XSgMA8KCJ1zBRpib6X-pUqwHFzh+uEj8OLm6OZfCi0wmDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 11:32:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcC1s-0002Re-HG
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 11:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab3KAKcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 06:32:32 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:60498 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab3KAKcc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 06:32:32 -0400
Received: by mail-la0-f47.google.com with SMTP id ep20so3254221lab.34
        for <git@vger.kernel.org>; Fri, 01 Nov 2013 03:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=XB4XQIfxUQ3ETgYqLj9y39AciDBq5NWlegGsTwmKTOk=;
        b=Yna07dKKLCi/u2Ih7dKeWZ/vdhFJbhCJQMj0dmeoTS3FnITHHPQSuqPbF+6yomTTHf
         nTFm3ZglxINx/0mzsi3LzET7wkwu3slR4W8dVeGiE9rf2IsaxheagYPq554XFN5ltIvs
         NuFj3ApZGNNwlRxXDbTnefFcjvG+KGOQlCgR6jgmrRWZnNrvKGmIu2IwVwJJN3sVMEiw
         JTmw5KooWCgOx4eIhmlHTlcqgHRzM0qUNNnDP2VmSJptQoaku0q0Pm7TeR1yI7JBC0sv
         i2FLEPJJrz6vR9balPdFH2oPZUZBXQkuIGJlmU1Xjvzby+ei92+NCS+yvAMGmNfrXF16
         DzYQ==
X-Received: by 10.152.5.228 with SMTP id v4mr998645lav.7.1383301950994; Fri,
 01 Nov 2013 03:32:30 -0700 (PDT)
Received: by 10.112.198.170 with HTTP; Fri, 1 Nov 2013 03:32:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237205>

Hey,

I'm using a gitosis server. Suddenly I'm not able to push to the
remote server. Everyone else is able to push to the same server. Btw I
can't push to *any repo* on the server. This is the error I get:

Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 353 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
error: unpack failed: unpack-objects abnormal exit
To git://git.srv.net/code-repo.git
 ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'git://git.srv.net/code-repo.git'

I Tried git fsck too:c

git fsck --full
Checking object directories: 100% (256/256), done.
Checking objects: 100% (2844/2844), done.

Can something be wrong with my git installation?
git --version
git version 1.8.3.2


-Thanks & Regards,
Sitesh Shrivastava
Phone: +91-9470521313
E-Mail: siteshshrivastava@gmail.com
Home-Page: http://www.siteshshrivastava.com
