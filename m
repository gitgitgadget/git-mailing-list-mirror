From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Git Wiki improvements
Date: Mon, 14 Apr 2008 12:18:42 -0400
Message-ID: <87skxos93x.fsf@jeremyms.com>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
	<200804140303.22624.jnareb@gmail.com>
	<8aa486160804140106m570d3fb9va0081d8a0d42870@mail.gmail.com>
	<alpine.DEB.1.00.0804141555350.28504@racer>
	<BAYC1-PASMTP10A8BA28CC2999519EA0B2AEE80@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <sbejar@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	"Pack\, Dylan" <PackD@navcanada.ca>,
	"Pack\, Dylan" <sarpulhu@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Mon Apr 14 18:28:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlRPZ-0007dy-N8
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 18:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761325AbYDNQSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 12:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761326AbYDNQSz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 12:18:55 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:41315 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761311AbYDNQSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 12:18:54 -0400
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JlROH-0003CN-Dv; Mon, 14 Apr 2008 12:18:45 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <BAYC1-PASMTP10A8BA28CC2999519EA0B2AEE80@CEZ.ICE> (Sean
	Estabrooks's message of "Mon, 14 Apr 2008 11:48:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79515>

Sean Estabrooks <seanlkml@sympatico.ca> writes:

> On Mon, 14 Apr 2008 15:58:29 +0100 (BST)
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Johannes,

>> While this would seem a good idea from the viewpoint of using as much of 
>> your own dog food as possible, I think that the Wiki is fine as-is.  
>> Especially since I like to spend more time hacking on Git than on the 
>> Wiki, and I expect most people to feel the same.

> It's not just about eating dog food but improving the chances that people
> use and update the wiki with useful stuff.  Adding the ability for people to
> clone a  copy of the wiki onto their own systems and use it offline can only
> help.  If people are permitted to push changes back to the wiki it has the
> potential to change the rules of the game in a positive way[1].

I've thought about this possibility myself, but it seems that the clone,
edit, commit, push cycle may not really be ideal for a wiki.  For one
thing, it is hardly ever necessary or useful to have anything more than
per-file commits.  Also, if there are a large number of simultaneous
users trying to push to the repository, you could run into a problem
whereby you can never successfully push because ever time you try, it is
not a fast-forward, so you have to fetch then merge (we can assume the
merge is just done automatically because e.g. only different files were
modified) then try to push again, but before you have a chance to retry
the push, the branch head may have changed again due to another push.

I suppose in practice this may not be a problem for the git wiki as it
may not have so many contributors, but this would certainly be a problem
for e.g. wikipedia.

More generally, though, although we may all dislike using webpage
interfaces, actually having to keep the entire wiki updated locally
doesn't seem terribly useful.  Really, you just want a way to edit a
particular page in your text editor, have various commands available for
e.g. previewing, and have commands available for showing the log
information with a nicer interface than a web page.

-- 
Jeremy Maitin-Shepard
