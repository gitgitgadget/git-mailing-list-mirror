From: "Pat Maddox" <pergesu@gmail.com>
Subject: Submodules and branches
Date: Fri, 4 Apr 2008 12:40:18 -0700
Message-ID: <810a540e0804041240p4efd0973g7f46a2021b352822@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 21:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhrwJ-00051k-PG
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 21:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbYDDTuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbYDDTuY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 15:50:24 -0400
Received: from el-out-1112.google.com ([209.85.162.180]:57319 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346AbYDDTuX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 15:50:23 -0400
Received: by el-out-1112.google.com with SMTP id v27so187992ele.17
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=9wdkqu+e9sREBnIc238w39yCiTwxi1POkhDlq29Dwiw=;
        b=JgLWc7VTjXooIYc+2TNjFpOAahpyhiPhwpQf07z2Sx528oGvvAFNm2tImVakqY/9Te/ufoJCVRXejOhOnb8EWRlC3fU0H7w19UWxOdfcVpp5RPrNeklCUIlIUqhtAh4RQ5on1LgPCCL4aBUlzpauS3fihp5DmDhHSrPbtsXueM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rqD8wypRzkBN/nDooeF6sOGtGlV1qczeIcEd/dGPyBpX3hqCVZVO9aHe7XUOuPIYouki4nxyjAhD2yGs6SPlA7BgTG5H6xPhvNUcIBY55P8e8oIJmU+hrdvpfElGY1gQn0/upUmPOAtn7whuoxKnsH0eg9MMqtdYV8rVsIFYdNE=
Received: by 10.114.170.1 with SMTP id s1mr2699715wae.54.1207338018441;
        Fri, 04 Apr 2008 12:40:18 -0700 (PDT)
Received: by 10.114.146.5 with HTTP; Fri, 4 Apr 2008 12:40:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78812>

I've got a repository that uses submodules.  If I cd to the repo root
and create a branch, all the submodules are switched to that branch as
well.  All good so far.  I go into the submodules and do my work,
committing as I go along.  Then when I'm all done and want to merge
the changes into my master branch, I cd back to the repo root and do
"git merge new_topic"

That's where it breaks down.  The commits that I made go into the
master repo itself, and the submodules don't have them.  So when I
push from the submodule to its origin, nothing goes through.  The code
is now a part of the master repo.

Is it possible for me to use branches like usual, but with submodules?

Pat
