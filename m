From: Jiergir Ogoerg <f35f22fan@gmail.com>
Subject: Possibly a bug
Date: Sun, 17 Nov 2013 04:59:20 +0200
Message-ID: <CAJbVpmyoZCCQU3w8oMTJfxFr4f1cSNTgF+qQW6QD5e44LYg_Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 17 03:59:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhsaL-0001I4-7C
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 03:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454Ab3KQC7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 21:59:22 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59146 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3KQC7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 21:59:20 -0500
Received: by mail-ie0-f179.google.com with SMTP id u16so6579707iet.24
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2LtsDW54pcU2ybY2uby5HubroLmI3Sq3KVAG5jvIFsg=;
        b=zvGOXh0bMzTAjRHvhmgZYSvJhvNtqMAGJ0xAK5r80sQz6GGwzC9MzHxf2wh7tIGQLr
         n04jhLijFsYaOXABkKHCw8dgJtn6ydx8YDy5KvebZsoJyc5Cj116c5lqBFq2t+u1m0uv
         VrfS0vQ40wQfawUHR1xYXQlD5VrPJpvEjUcfeTUhgbExSA0HaXbJTCX7oFJK1u9JV0nR
         NlOb2oDUXiZxLJ8Qykik3pnQruR67FLksvB6MmsVUpAWUDW8tOiXQVLU2sWUpeduZ/Zf
         0+Vxd3S8CS/I0bvCqN7mPHczffPaBeD88CmVHZ6A6C8T50FN7I+ppwMiW8eAobfjU1KO
         vfnA==
X-Received: by 10.50.61.179 with SMTP id q19mr9058107igr.33.1384657160345;
 Sat, 16 Nov 2013 18:59:20 -0800 (PST)
Received: by 10.64.230.239 with HTTP; Sat, 16 Nov 2013 18:59:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237950>

Hi,
As suggested by the git book/tutorial I cloned "simplegit-progit" to
learn using git.
The issue:
git log --since=5.years
yields 2 commits, while
git log --since=6.years
yields 3 commits, despite the "Date" in both cases being March 2008.
Is it a bug?

Using Fedora 20 amd64 with git version 1.8.4.2


Details:
//==> FIVE YEARS
simplegit-progit$ git log --since=5.years
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gmail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    changed the verison number

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
Author: Scott Chacon <schacon@gmail.com>
Date:   Sat Mar 15 16:40:33 2008 -0700

    removed unnecessary test code
//<== FIVE YEARS

//==> SIX YEARS
simplegit-progit$ git log --since=6.years
commit ca82a6dff817ec66f44342007202690a93763949
Author: Scott Chacon <schacon@gmail.com>
Date:   Mon Mar 17 21:52:11 2008 -0700

    changed the verison number

commit 085bb3bcb608e1e8451d4b2432f8ecbe6306e7e7
Author: Scott Chacon <schacon@gmail.com>
Date:   Sat Mar 15 16:40:33 2008 -0700

    removed unnecessary test code

commit a11bef06a3f659402fe7563abf99ad00de2209e6
Author: Scott Chacon <schacon@gmail.com>
Date:   Sat Mar 15 10:31:28 2008 -0700

    first commit
//<== SIX YEARS
