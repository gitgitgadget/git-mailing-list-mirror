From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Fri, 15 Nov 2013 08:34:04 +0100
Organization: FutureLAB
Message-ID: <5285CE6C.2030609@futurelab.ch>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>	<CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com> <CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Pabst <benjamin.pabst85@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 15 09:23:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhEh1-00043C-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 09:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab3KOIXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 03:23:52 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:44553 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3KOIXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 03:23:51 -0500
X-Greylist: delayed 2984 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Nov 2013 03:23:51 EST
Received: from astricker.futurelab.ch (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id rAF7Y4tK006375;
	Fri, 15 Nov 2013 08:34:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237892>

Hi

> But today I tried to push back a rename to the subversion server,
> which resulted in the following error:>
> perl: subversion/libsvn_subr/dirent_uri.c:2489:
> svn_fspath__skip_ancestor: Assertion
> `svn_fspath__is_canonical(child_fspath)' failed.
> error: git-svn died of signal 6

I also observed this issue with a rename. My workaround was to downgrade
subversion to 1.7.x. That worked, but I'm searching for a real solution.

> After searching the web I found a similar problem at stackoverflow:
>
http://stackoverflow.com/questions/17693255/git-svn-dcommit-fails-because-of-assertion-error-svn-fspath-is-canonicalchildj

I'll add this one to the list: https://trac.macports.org/ticket/39986

It looks like I'm not the only one experiencing this.

Regards, Andy
