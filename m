From: Patrick Doyle <wpdster@gmail.com>
Subject: How to merge into my working copy?
Date: Fri, 6 Nov 2009 09:53:02 -0500
Message-ID: <e2a1d0aa0911060653t7bbb54ebp948eac0dffeaba64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 15:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6QBa-0000aH-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 15:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381AbZKFOw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 09:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758340AbZKFOw6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 09:52:58 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38502 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758184AbZKFOw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 09:52:57 -0500
Received: by ewy3 with SMTP id 3so1099707ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=UzD4+p7/Rp1UzzRNHMHdA9/GGB/VKRM08jAZ8reftGw=;
        b=oAjh0PzEtW1CNnEj3SrluDNppX5GHzEUOuMCQwHWq01tivgYGCK3hufEwXuOQ6sUdG
         sN0a9ulDFPOd/mtCwD7ZPmJ+Xcz9i7VUid7VcuYuV2HI4zaKBBKuEqwDm6dsTt71AINh
         K/aa0TFrv1vLj5ZKJ5zwqmoMQBadQ58mn8F30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=x++xCFv0NIFdAAooJpYEL3Is+ewB60p9WbfgpKG+6PhTJ0CKDqklRyuJh3Bg/QGMSA
         DoJBns8MlOIlHtHrimlPyi8jd19jjw4S02i+4kExM6GptHCr3NPjbXpEZuUVji65CT/e
         84Xtqlc1e3Q0WsPXVgnihLZvyJuXGdCTB/bUc=
Received: by 10.213.27.1 with SMTP id g1mr952410ebc.78.1257519182324; Fri, 06 
	Nov 2009 06:53:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132301>

I would like to pull a set of changes from a branch back into the
working copy of my current branch without affecting the index.  I
can't figure out the right combination of --commit, --no-commit, -ff,
-no-ff, --log, --no-log, --squash, --no-squash, etc... options to use
with git-merge.

Basically, I created a branch off my mainline branch a few days ago.
Made some commits on that branch.  Then went back to my mainline
branch, made a few commits there, and now I would like to make my
working copy look like a merge of its current state with the changes
from the branch, minus any associated commits.

I probably should have just used git-stash to tuck those changes away,
but I didn't.

--wpd
