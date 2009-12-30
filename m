From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Need some help with git rebase
Date: Wed, 30 Dec 2009 23:24:26 +0100
Message-ID: <1262211866.7068.1.camel@kheops>
References: <4B38B3A7.6010900@steek.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 23:24:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ6yO-0000jY-Rz
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 23:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbZL3WYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 17:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbZL3WYw
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 17:24:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:35365 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbZL3WYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 17:24:51 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NQ6yH-0000gR-H9
	for git@vger.kernel.org; Wed, 30 Dec 2009 23:24:49 +0100
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 23:24:49 +0100
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 23:24:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <4B38B3A7.6010900@steek.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135926>

So,

I tried again "git rebase --onto 12.72.1 master feature".

Situation :

                         a--a--a--a--a--a--a--a--a feature
                        /
--x--x--x--x--x--x--x--x--x--x--x--x master
   \
    o--o--o--o--o--o--o 12.72.1


Work flow :

$ git checkout 12.72.1
$ git rebase --onto 12.72.1 master feature

a lot of conflicts, resolving and git rebase --continue

And then, at the end of the rebase, without me doing anything, feature
branch is checked out and it seems that its HEAD has been reset to the
new 12.72.1 HEAD.

--x--x--x--x--x--x--x--x--x--x--x--x master
   \
    o--o--o--o--o--o--o--a--a--a--a--a--a--a--a--a 12.72.1 feature

Is that normal ? If it is, how do I do to avoid my feature branch to be
reset at 12.72.1's HEAD ?

Any enlightenment is very welcome.

Regards.

-- 
Sylvain Rabot <sylvain@abstraction.fr>
