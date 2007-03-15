From: Seth Falcon <sethfalcon@gmail.com>
Subject: error with symlinks on OSX
Date: Thu, 15 Mar 2007 10:12:29 -0700
Message-ID: <m2r6rqbfcy.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 18:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRtVB-0006DZ-3W
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 18:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbXCORMa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422963AbXCORMa
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 13:12:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:29328 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422813AbXCORM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 13:12:29 -0400
Received: by nz-out-0506.google.com with SMTP id s1so109618nze
        for <git@vger.kernel.org>; Thu, 15 Mar 2007 10:12:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=Zjjqdzt6lFPM3L9r4qkIDimQ/pPUd6TV1HCiAO95UZZtdkGDmGPz02uxS+OkpSXfaRh3+HLndWQcKBdvm6dMhV8AamTmPU7vqjDAL8bVotdJfvNJPbLyUdewUn17cP3IEqmQPHOK+39MDyR4B9HifF49lLPgXC8cEBvMsEvGv3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=bOdnKONe4CVnPAV2NEm0psz6gBVQZHVH5PnBIEqgHSBbFrzjdqyRWMb+5fc/QIspwa6CkNsGY93fYKMigRl+YsPUSXxMAf/9IEPmVd74dftJS+KpdxHvyW4qGj4QJIz6moy1Mf4719JQWE4HQr1+1KWxK3bESVV9wVDUthW85Xc=
Received: by 10.114.173.15 with SMTP id v15mr315051wae.1173978747391;
        Thu, 15 Mar 2007 10:12:27 -0700 (PDT)
Received: from ziti.local ( [140.107.181.196])
        by mx.google.com with ESMTP id m27sm2413468pof.2007.03.15.10.12.26;
        Thu, 15 Mar 2007 10:12:26 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42294>

Hi,

I've been tracking an svn repository using git-svn and today when I
did:

   git svn rebase

   (which is equivalent to git svn fetch && git rebase
   remotes/git-svn)

I got errors like this:

error: git-checkout-index: unable to create symlink Category/Makefile (Invalid argument)

Now while my file system isn't smart enough to tell the difference
between t and T, it does support symlinks AFAIK.

git version 1.5.0.2.293.g102a0

I can provide more info if it would help.

+ seth
