From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: [regression?] "git status -a" reports modified for empty	submodule
 directory
Date: Tue, 22 Apr 2008 11:00:18 -0700
Message-ID: <1208887218.25663.449.camel@work.sfbay.sun.com>
References: <46dff0320804220401h26d2f2ebg1748a4a310acc0f5@mail.gmail.com>
 <480DD6D8.9040900@viscovery.net>
 <46dff0320804220539y51c02dedoe181a0eed8599902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:57:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoMkL-0005we-Ds
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763700AbYDVR4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759841AbYDVR4q
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:56:46 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:65027 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481AbYDVR4p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:56:45 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3MHuhm5017418
	for <git@vger.kernel.org>; Tue, 22 Apr 2008 10:56:44 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZQ00M01LSXU800@fe-sfbay-10.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Tue, 22 Apr 2008 10:56:43 -0700 (PDT)
Received: from [129.146.84.200] by fe-sfbay-10.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JZQ00GEHN67QUB0@fe-sfbay-10.sun.com>; Tue,
 22 Apr 2008 10:56:31 -0700 (PDT)
In-reply-to: <46dff0320804220539y51c02dedoe181a0eed8599902@mail.gmail.com>
X-Mailer: Evolution 2.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80151>

On Tue, 2008-04-22 at 20:39 +0800, Ping Yin wrote:
> >  > $ git status -a
> >  > # On branch master
> >  > # Changes to be committed:
> >  > #   (use "git reset HEAD <file>..." to unstage)
> >  > #
> >  > #       deleted:    sub
> >  > #
> >
> >  There's nothing wrong with this.
> >
> >  -- Hannes
> 
> It seems that in 1.5.4, both 'git status' and 'git status -a' report
> "no changes added to commit". And i think this is the right behaviour.
> Because when a super project is cloned, all submodule directories are
> empty in the beginning. In this case 'git status' and 'git status -a'
> should report " no changes added to commit".

Agreed 100%

Thanks,
Roman.
