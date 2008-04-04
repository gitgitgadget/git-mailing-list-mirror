From: "Pat Maddox" <pergesu@gmail.com>
Subject: git add after changing a submodule
Date: Fri, 4 Apr 2008 13:50:48 -0700
Message-ID: <810a540e0804041350u7fe4a5c4t7e86274e188e3e91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 22:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhst6-0003b0-4v
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbYDDUvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 16:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbYDDUvC
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 16:51:02 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:15188 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYDDUvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 16:51:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so48404ywb.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=Was4FICA3LFHD0fVEI/GpcHtFUXhwVHbRVf8x3UD9cA=;
        b=rnNHcQNjQhPuM1uxuCll8VB6752TzRXo5iFo2EOFxrjWiYeAisH7D763SSCRs7+NhsJH1zm2OpZtQZuJNvr81tM9IUFJQ8qHZs3j9xGRNkrWO6VMAMfkGYvH/YgwnngMirja61EZUwjZ1zo/nJdYgHYRlcgxb2cwvfRyy1DAkMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FOM9DOEJxbtzZcC+qc4UhrJe/xgMzZTRexOhu8i5qXO6YYJo+XZ4+NIdZtguYJoKVei5NcESatLQho/FHviKkC4594cFcZCbcFUbDBxTnkF8/8h4iKH1Cd9LISP4lJaWWUMFVH5V6wIsJAXMy7Q4r46OySofSl1L///hSyCDe94=
Received: by 10.115.78.1 with SMTP id f1mr2804390wal.100.1207342250266;
        Fri, 04 Apr 2008 13:50:50 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Fri, 4 Apr 2008 13:50:48 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78817>

If I make a change to a submodule and commit it, I then have to add it
to the parent repo.  If I do

git add path/to/submodule

then it works fine.  But if I do

git add path/to/submodule/ (with trailing slash)

then it blows away the submodule and adds all the files in that directory.

Seems pretty dangerous to me.  I know that I can just use git commit
-a to do it, but I'd like to prevent the mistake of adding the path
and screwing up the repo.  Is it possible to protect the submodules a
bit more?

Pat
