From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: [Query] Can we ignore case for commiters name in shortlog?
Date: Fri, 30 Nov 2012 13:01:55 +0000 (UTC)
Message-ID: <k9aao3$til$1@ger.gmane.org>
References: <CAOh2x==NBeeoE2=PhaDC143ZF_xHKD5m=Po+-DS2X43CEeGiEQ@mail.gmail.com> <CAJDDKr7yr2JSutcEy1mz-SfMq8ZdNzR3+s++ooenn5+wD-LDAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 14:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeQGL-0000BJ-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 14:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932928Ab2K3ND5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 08:03:57 -0500
Received: from plane.gmane.org ([80.91.229.3]:54569 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932233Ab2K3ND4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 08:03:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TeQG2-0007jo-EQ
	for git@vger.kernel.org; Fri, 30 Nov 2012 14:03:54 +0100
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 14:03:54 +0100
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 14:03:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Fri, 30 Nov 2012 13:58:29 +0100 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210921>

David Aguilar  wrote in message
<CAJDDKr7yr2JSutcEy1mz-SfMq8ZdNzR3+s++ooenn5+wD-LDAw@mail.gmail.com>:
> There's a feature that does exactly this.
> http://www.kernel.org/pub/software/scm/git/docs/git-shortlog.html

By the way, the mailmap ignore case which is annoying.
I have commits as Damien.Olivier.Robert+git@gmail.com and a dummy email
address robert@numenor.night-elves. I thought that putting:

Damien Robert <Damien.Olivier.Robert+git@gmail.com> <robert@numenor.night-elves>

in the .mailmap would unify the two adresses, but it does not:

git shortlog -se
    15  Damien Robert <Damien.Olivier.Robert+git@gmail.com>
    266  Damien Robert <damien.olivier.robert+git@gmail.com>

as you can see, the Damien.Olivier.Robert+git as been lowercased to
damien.olivier.robert, so I am forced to write a mailmap like this:

Damien Robert <Damien.Olivier.Robert+git@gmail.com> <robert@numenor.night-elves>
Damien Robert <Damien.Olivier.Robert+git@gmail.com> <Damien.Olivier.Robert+git@gmail.com>

git shortlog -se
   281  Damien Robert <damien.olivier.robert+git@gmail.com>
