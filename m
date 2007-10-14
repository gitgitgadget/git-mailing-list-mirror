From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 20:27:00 +0200
Message-ID: <47125F74.9050600@op5.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih8BI-0003wk-Ox
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758492AbXJNS1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758411AbXJNS1G
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:27:06 -0400
Received: from mail.op5.se ([193.201.96.20]:39371 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbXJNS1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:27:04 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 237C81730710;
	Sun, 14 Oct 2007 20:27:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJxuYO4IHeLv; Sun, 14 Oct 2007 20:27:02 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 88F161730700;
	Sun, 14 Oct 2007 20:27:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60890>

Benoit SIGOURE wrote:
> Context: GNU make seems to be willing to switch from CVS to ... 
> something else.
> 
> On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:
> 
>> [...] the big thing no one else seems to have addressed much in
>> other discussions I've seen is portability.  It LOOKS like there are
>> native ports of GIT to MINGW, but I have no idea how complete and usable
>> they are.  If someone who has a Windows system could look into that it
>> would be a big help.
> 
> I think the best thing to do is to ask directly on the Git ML.
> 
> Someone already pointed out that he'd like to use Git on Windows but 
> doesn't want to install either Cygwin or MSYS.  Is this possible, or 
> will it be possible in the near future?

It is sort of possible. Without cygwin he'll be in the black for the few
features that are still implemented as shell-scripts, but perhaps he/she
will then be inclined to help us migrate those scripts to C builtins.

>  Is it possible to use one of 
> the various GUIs (git-gui, gitk, qgit) on Windows without requiring a 
> POSIXish shell etc.?
> 

qgit is possible to use natively, if one installs the qgit4 libraries for
windows, but it's more of a viewer than an action gui. git-gui and gitk
are usable if you have the windows TCL port. I haven't tried it, but
there are installers available, so testing it out (with all dependencies)
shouldn't take too long.

> When will the librarification of Git be finished?

When someone gets around to doing it ;-)

For a real answer, I'll have to defer to others. Everything works to my
satisfaction where I'm using it, so I'm not very inclined to fiddle with
it and risk breaking things.

>  (if Git is available 
> as a library, and if this library works on Windows, it will greatly help 
> truly native Windows ports).
> 

Yup. I believe the primary reason for libification is to easier support
both porting and fully-fledged gui's.

> Not that I like Windows in any way, right, but it's legitimate for 
> people working on Windows ports of various software to be willing to 
> have a truly native port of Git for Windows.
> 

Naturally. Amazingly few of those stuck with windows have so far
volunteered for helping out though, and since many of us on this list
don't even have a windows system for testing, it's kinda slow going :-/

I'd imagine getting in touch with Dscho to get a list of what's needed,
or reading the biweekly msys.git herald on this list, is the best way
of finding out the porting project's current priorities.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
