From: Markus Korber <korbse@gmx.at>
Subject: Re: Revert git push
Date: Thu, 10 Jan 2008 14:45:52 +0100
Message-ID: <6zmyrdpze7.fsf@odpc25.int.ondemand.co.at>
References: <6zve61q0t3.fsf@odpc25.int.ondemand.co.at>
	<57518fd10801100531v6f6aef85k4b1b875c6f16aeba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 14:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCxjk-0001B5-Uh
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 14:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbYAJNp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 08:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbYAJNp4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 08:45:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:45174 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754503AbYAJNpz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 08:45:55 -0500
Received: (qmail invoked by alias); 10 Jan 2008 13:45:54 -0000
Received: from vie004.vienna.atvirtual.net (EHLO odpc25.gmx.at) [212.186.216.185]
  by mail.gmx.net (mp018) with SMTP; 10 Jan 2008 14:45:54 +0100
X-Authenticated: #23003311
X-Provags-ID: V01U2FsdGVkX1/L1SE0GRzLHZLQSxPxgeQnI8FQ57/SP2acHphObw
	12yLQVBEFAdHzG
In-Reply-To: <57518fd10801100531v6f6aef85k4b1b875c6f16aeba@mail.gmail.com>
	(Jonathan del Strother's message of "Thu, 10 Jan 2008 13:31:59 +0000")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70072>

Thus spake Jonathan del Strother:

> On Jan 10, 2008 1:15 PM, Markus Korber <korbse@gmx.at> wrote:
>
>> I've got two local git repositories, linux and mplayer, where I push to
>> from a local directory.  Now I accidentally pushed from mplayer into the
>> linux repository (via a not updated URL[1]).  Is it somehow possible to
>> revert this push if nobody has pushed something since my last pull from
>> the linux repository?
>
> You can push again to revert your original push, just specifying a
> different ref to push.  Something like this ought to work :
>
> git push -f mplayer 94545bade:master
>
> which will update the remote 'master' branch with commit 94545bade,
> which is what it was before your accidental push

Unfortunately this gives:

,----[ git push -f mplayer 94545bade:master  ]
| error: src refspec 94545bade does not match any.
| fatal: The remote end hung up unexpectedly
| error: failed to push to '/prj/gitroot/linux'
`----

,----[ git --version ]
| git version 1.5.3.1
`----

Regards,
Markus Korber
