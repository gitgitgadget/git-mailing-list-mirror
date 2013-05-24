From: Jim Greenleaf <james.a.greenleaf@gmail.com>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 15:42:37 +0000 (UTC)
Message-ID: <loom.20130524T174015-773@post.gmane.org>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com> <loom.20130523T185301-635@post.gmane.org> <87sj1d5ous.fsf@linux-k42r.v.cablecom.net> <7vd2shcnx7.fsf@alter.siamese.dyndns.org> <87obc15mq5.fsf@linux-k42r.v.cablecom.net> <7v4ndtcmh0.fsf@alter.siamese.dyndns.org> <CABURp0rBzH9=VdW0Y4Bv1tfbSzZ3dwismwgZ7zCwrXC6nDRSJQ@mail.gmail.com> <loom.20130524T173321-264@post.gmane.org> <20130524153853.GE27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 24 17:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufu8x-0000KZ-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab3EXPmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:42:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:54089 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab3EXPmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:42:53 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ufu8q-0000FM-6V
	for git@vger.kernel.org; Fri, 24 May 2013 17:42:52 +0200
Received: from 112.205.196.58.pldt.net ([112.205.196.58.pldt.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 May 2013 17:42:52 +0200
Received: from james.a.greenleaf by 112.205.196.58.pldt.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 May 2013 17:42:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 112.205.196.58 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225365>

John Keeping <john <at> keeping.me.uk> writes:

> I wonder if this would be better as a file rather than another option to
> git-update-index.  We already have .git/info/exclude so we could add
> .git/info/freeze or .git/info/local with the same syntax as the normal
> .gitignore file.

.git/info/freeze would be a good solution.
It would avoid the need to add a new class of files for git-status,
while keeping a simple, familiar record of all frozen files in a single location.
