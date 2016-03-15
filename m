From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Tue, 15 Mar 2016 15:26:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603151517590.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com> <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 15:26:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afpw0-0005VI-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 15:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbcCOO0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 10:26:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:62336 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754905AbcCOO0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 10:26:48 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LbuIK-1Zz7BJ2JpE-00jI5L; Tue, 15 Mar 2016 15:26:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SqXL3wv1YCCbDqh5ZOFNWf7CLBNSjNUk1LGAR6NJm0+y32kMY+R
 9cJ23Iix1egqeWc6ikoqPBHXk/aBGAOXfWfk+p7CHQ6dAgDpxEYlzpHj0vZBZiLvGPDm41x
 Ro6oyb1nRarw3ocdzQ1KC5+2j5Zy4RzbgvAme35lo6w7EAdNuCnW7fpeFrvvhMMPmNkajTr
 1EptWZbJND1uVYdDB1Dog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pzNY111uAec=:akFvSKVj+kKPV8LQJXblCZ
 CiuUIq1ZNF4WrK5u4dcKu/Xr9fN+eI65kuFLN5f56hiAoybqkm2lzA/ceGvRIKSTjY7GxG/Xq
 rnR5VauziwK+TU7LjTRaHNj7kAXJyFyQqax50CDlBRaGIMxAJsRHVsbMPz1fjMitzFcFmqr8N
 duwIQso9ted5zUEP8F7qHcf3rEoJ+QIGmNUylKLt80BYa28VW0QBBE26tDs1M/Tuu1wZYp0hl
 GffiLWGggjHfsFO6luqhOOiuYXu8uC/SsY5XFBYQXZkvXTwOM0q4pUErwTgSXmDm8GgUridbf
 f50wRFwK4jcs3+vbHRcmKLyq7tU/0qtZq/gOhjcCD5F3nlxV7DBa1LV8LsUJDvCHseS2eXWI8
 vLhg4fOVFpEamzslvOpZby7ySSVnlw/Xh1yYTwbXmFbIoHJV+JB8x1ABYgZJ0vr3eVNp7lmqa
 dal0jpvDXpA4ym3GG7X2LPP9iE3yszFq19SRbCOHJ74T0qnwFqpCYei0TCtkZZtYJqlmGdUEa
 /6bEJmgMzSQWjC0xLuiiT6fSXXkBWqDlwIOxl8ssDAlFlnOi5YhEyNY0p01sMaa0AbvZKAHcf
 HgYtSTEviGiaUSPmdoFPpP53udtEzXyfAcynSm7rAs3S36kfljEFxF9gPDbOUA1dzP3Hgt4Wg
 ZFViRIUZzrGKkTN7Jb4z/2cAS5RLChPIE4lG6JJ5BVbPd1fnkhfnEektusdmawXfmhSdBZnB6
 EUMLt455BXWCuwBQSiFNhpIrycW3oKJ76NIAZ9xPJdhq7No3dolNAXkZRP95rR5tC0Fvo2+M 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288856>

Hi Duy,

On Tue, 15 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com> wrote:
> > Introduce a new config option, indexhelper.autorun, to automatically
> > run git index-helper before starting up a builtin git command.  This
> > enables users to keep index-helper running without manual
> > intervention.
> 
> This could be a problem on Windows because "index-helper --detach"
> does not work there. I have no idea how "daemons" are managed on
> Windows and not sure if our design is still good when such a "daemon"
> is added on Windows. So I'm pulling Johannes in for his opinions.
> 
> Background for Johannes. We're adding "git index-helper" daemon (one
> per repo) to cache the index in memory to speed up index load time
> (and in future probably name-hash too, I think it's also more often
> used on Windows because of case-insensitive fs). It also enables
> watchman (on Windows) for faster refresh. This patch allows to start
> the daemon automatically if it's not running. But I don't know it will
> work ok on Windows.
> 
> Assuming that "index-helper" service has to be installed and started
> from system, there can only be one service running right? This clashes
> with the per-repo daemon design... I think it can stilf work, if the
> main service just spawns new process, one for each repo. But again I'm
> not sure.

If we want to run the process as a Windows service, you are correct, there
really can only be one. Worse: it runs with admin privileges.

But why not just keep it running as a detached process? We can run those
on Windows, and if we're opening a named pipe whose name reveals the
one-to-one mapping with the index in question, I think we are fine (read:
we can detect whether the process is running already).

We can even tell those processes to have a timeout, or to react to other
system events.

Please note that I am *very* interested in this feature (speeding up index
operations).

Ciao,
Dscho
