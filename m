From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: Newbie question: Is it possible to undo a stash?
Date: Wed, 14 May 2008 22:51:40 +0200
Message-ID: <482B50DC.3020400@gmx.ch>
References: <509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Ikl2w6FuIFYuIg==?= <elterrible@ivanyvenian.com>
X-From: git-owner@vger.kernel.org Wed May 14 22:53:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwNxi-0007lp-Mk
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 22:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbYENUvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 16:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYENUvo
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 16:51:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:54550 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750836AbYENUvn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 16:51:43 -0400
Received: (qmail invoked by alias); 14 May 2008 20:51:41 -0000
Received: from 128-34.78-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.78.34.128]
  by mail.gmx.net (mp037) with SMTP; 14 May 2008 22:51:41 +0200
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/vfChQIKDveMlzRak74E7GK/pNhGyyvvP+SKHExi
	c1yO+MgaN7grnl
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <509f40850805141256gce6ac1brf5ced6436f81dae8@mail.gmail.com>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82149>

Hello!

Iv=C3=A1n V. wrote:
> I just did a git stash, and then changed my mind and ran git apply,
> thinking that would get me back to where I was...

Certainly you mean "git stash apply".  "git apply" is something
different.

> Now I have lots of conflicting merges and files that came back from
> the dead (and some files seem lost)... I've been trying to go step by
> step to try to get the tree to where it was, but it's very
> complicated, so I was wondering if there is anything I can do to get
> my working tree exactly to where it was before I ran git stash...

git stash pop --index

I think that should get you exactly where you were before "git
stash".  The --index makes it also restore the index, which
wouldn't happen by default.  Using 'pop' instead of 'apply' makes
it remove the stash after re-applying it.

jlh
