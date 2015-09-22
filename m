From: Josh Boyer <jwboyer@gmail.com>
Subject: Specifying N revisions after the initial commit
Date: Tue, 22 Sep 2015 14:32:19 -0400
Message-ID: <CA+5PVA40x8bxW63X+b77FDO8btRBaVOg=fq+ZyX=bdJ+uEm9gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSNQ-00072i-AG
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934115AbbIVScW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:32:22 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33664 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933806AbbIVScT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:32:19 -0400
Received: by igbkq10 with SMTP id kq10so105183093igb.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=/kQUiAW7PJzKYJLBzGVi/B1k96IvTsXfNBZmeKJKDSY=;
        b=lioVZAJL8l46s9QW5Gxr0par2jIKmCd56WC0f2UDEvt/jV+A2zxPw6jLKeFyKefF4e
         95V/5NhaT00fEV/iX12CKtBE3BketazQ/5gbCYHAewSFl2aal6JaUExbDZnsq4cs+R9I
         94YWdceVOPLhXb2TS6s+wmJF5Tjf60/RWSKvq7PFPf02Ngbi2wn1axfAT7x9JngPbCpd
         7BLxbRMlPd+fnaL/AGMtYAnb3CRBFQMHobKjOYy7G+HUnNcqucv4U/cq19iDjAUvXyAP
         UK88vSSDp9wNbuhjRQ026ARArLadfRbDyrPAaBPx/MoSrut5EoCLCkhNjav0iP1HsO5E
         7/pQ==
X-Received: by 10.50.67.43 with SMTP id k11mr19525438igt.92.1442946739086;
 Tue, 22 Sep 2015 11:32:19 -0700 (PDT)
Received: by 10.64.132.167 with HTTP; Tue, 22 Sep 2015 11:32:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278410>

Hi All,

Please CC me as I'm not subscribed.

I was hoping someone could help me with the revision shorthand to get
the commit sha of a commit N commits after the initial commit.  Thus
far I've figured out that to get the initial commit in a repository,
you can use:

git rev-list --max-parents=0 HEAD

but I can't figure out how to get "give me the commit sha1 of the
commit immediately after the initial commit", or for some number N.  I
could always do something like:

git rev-list HEAD | tail -2

to get both, but I was curious if there was a refspec shorthand for
this that could be used.  It seems that git's rev parsing is all built
on going backwards in order (and probably rightfully so).

Thanks in advance.

josh
