From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [GIT-SVN] master follows not trunk
Date: Wed, 22 Apr 2009 17:21:27 +0200
Message-ID: <36ca99e90904220821u3dae67d7jcb6366d7a95dfbd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LweHy-0007g9-21
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 17:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbZDVPVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 11:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZDVPV3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 11:21:29 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53794 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbZDVPV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 11:21:29 -0400
Received: by fxm2 with SMTP id 2so19404fxm.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=stj7P5sNjrauT2YlAPucn+hrQKbmpyqfXFFZ2QSMSlU=;
        b=WRFsiArMARovIvvY3resm+ZSaSVECrQRHRKLWMzxUIEax+tC+EjNLxGN4BF7ZkznSM
         +jYv5PgsZ0qPLibKT8ZecUCR4Wzii6w5u2ML3z0hZ6nrOH5OOVLDrH+ZgprlJSI7Bdcs
         pNhc5j+SULNYFB4FP4TvAxULJka8880qL75Yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=LzfEZKHcUhG0IV/O4pCbBzZsq4g6KuDV+7pd6ZajcseM0AlkPi2tBGY06zyuegWUn7
         B4l/4ZChdJZLq7UCrmkUIx+MLTCbTBfs3HyFO/ZnbcIcX1CHbyX0vudqmDJ1mulJOHbL
         8Zl7fbfV2Ot2IYeb7vXJG0Z6FtWR1zoLSNZdM=
Received: by 10.223.104.19 with SMTP id m19mr2610501fao.58.1240413687345; Wed, 
	22 Apr 2009 08:21:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117205>

Hi,

it seams so, that git-svn sets the master branch to that svn branch
which has the highest revision!

I cloned a svn repo today where exactly this happend. I.e. master
pointed not to the trunk but to the branch with the highest revision.
After trunk moved forward, a git svn rebase told me that master is up
to date.

A second clean clone of this repo and master pointed to trunk.

Is this indented?

Bert
