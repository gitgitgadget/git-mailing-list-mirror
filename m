From: Howard Miller <howardsmiller@gmail.com>
Subject: "submodule" mistake and a problem
Date: Mon, 1 Oct 2012 11:41:13 +0100
Message-ID: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 12:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIdRm-0003EG-9v
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 12:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab2JAKlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 06:41:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:48217 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab2JAKlN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 06:41:13 -0400
Received: by ieak13 with SMTP id k13so11714363iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=IU5cc2EqoJQG9d/fCQteeCZcnGHqVzTfs9MItEQXJbM=;
        b=v+3142EKCkck/1OVbxnHW1xSw6IpyuUwm+KuHjuJScrffLwYQ38JdIcZxqz1/DS5ke
         QAXRvqaHlvmqqR/yF5nptudl3/T2x/LCo0Uzn0FUsGEimqiym3qfzEP5iCxOiVa1iTyA
         dDjMJw1oHaS/RrInNFsppzCRGrs2l1+zgTCmdemkXVVc+ulcRxsP1nOJHBSrt81GGMhM
         unt4lDZrjmt19ZJTGpNIUqwLozXrK3zXwBgfedTTVZJQdbdFekJDO77AQKuf/KKaJGC8
         rwLwAAdAoHioLe2n7L6g3LcLHeCu/sWq87e50YRVia/BfXgBGA5XAySqe2SS+PMFr6qR
         rwlg==
Received: by 10.50.36.193 with SMTP id s1mr5294608igj.15.1349088073355; Mon,
 01 Oct 2012 03:41:13 -0700 (PDT)
Received: by 10.64.13.110 with HTTP; Mon, 1 Oct 2012 03:41:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206728>

Hi,

I did this and now am confused/stuck...

- I have an existing (long standing) project in git with an upstream in github
- I added a subdirectory which I had forgotten was itself a git
project (i.e. it has its own .git directory)
- I committed the subdirectory (git add /path/to/subdir;  git commit -m ....)
- I pushed the latest version upstream

....at this point I realised that only the directory name had been pushed. SO...

- git rm /path/to/subdir resulted in fatal: pathspec
'/path/to/subdir/' did not match any files
- so I deleted it manually, re-copied the directory and removed its
.git directory

...I now cannot add or commit the directory. Git just ignores it. I
have grepped and searched and kind find no reference to this directory
anywhere. I am completely stumped.

Can anybody help? I don't want this to be a git subdirectory, I just
want to be able to add the files (without the .git directory)

Cheers :)
