From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: git reset --hard isn't resetting
Date: Wed, 6 Aug 2008 22:01:42 +0400
Message-ID: <37fcd2780808061101p6b75a663hb54f3cb6ad88314f@mail.gmail.com>
References: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Graham" <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQnLT-0001Q1-KK
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYHFSBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 14:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbYHFSBn
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 14:01:43 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:1084 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYHFSBm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 14:01:42 -0400
Received: by wf-out-1314.google.com with SMTP id 27so61239wfd.4
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FmCdTC3AccC1Qm5H784OYtz7n3JY+lZrsZLeD2NEBw8=;
        b=t3Ay8W1H/YK+qqZY31qpg3a43YV9KvEpiCc08DlqBojcwhpwtQ7uhjf98G04nWhTOG
         LdBRsy37KR0cLfkgJplCA+pgxdhVTFj0MONBvnZWzkf6YldbhvC9qs9reRf+RtfQSCmV
         4t5LdbrGA0EWj8qEM/sUZnQCdkrAwc+q1SfA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=k4Z/K2CnsKMuO8HTS9whodUGiCgUBalS3Ag6wjfapqqNsjKe92yE+XstvhRsjAAbPG
         vX9XDhzdmtENj4SogeoDKvExKeHKOojzcQagTAG7fIcwq53XboSnE5MisUjgi38Nisj4
         BFRr2Rx6BL6YJTiKr1tHixzBz3PTOtCpbJse4=
Received: by 10.142.187.8 with SMTP id k8mr106131wff.199.1218045702480;
        Wed, 06 Aug 2008 11:01:42 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Wed, 6 Aug 2008 11:01:42 -0700 (PDT)
In-Reply-To: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91530>

Hi,

On Wed, Aug 6, 2008 at 8:41 PM, Matt Graham <mdg149@gmail.com> wrote:
> I'm using a git svn tree in Cygwin.  I tried doing an svn rebase and
> got in some weird state with local changes I can't get rid of.  It's
> not an issue w/ the same repository on my linux machine.
>
> git reset --hard
> toggles 4 files between capitalization.  The files don't appear to
> have changed case in svn, but it's a huge repository and not easy to
> determine with certainty.

What version of Git do you use?
Was this repo created with Git prior 1.5.6?
Do you have core.ignorecase set to true in .git/config?

What "git ls-files" says for these files?
What "ls" says for these files?

Dmitry
