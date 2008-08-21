From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: [kernel.org users] README and ChangeLog files
Date: Thu, 21 Aug 2008 18:32:36 +0200
Message-ID: <g8k5b6$32a$1@ger.gmane.org>
References: <48AC5972.80908@zytor.com> <20080820182636.GJ8318@parisc-linux.org> <48AC6839.7050605@zytor.com> <1219264114.7576.1121.camel@calx> <20080820210733.GA418@smurf.noris.de> <20080820223033.GD18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201552070.3487@nehalem.linux-foundation.org> <57C9024A16AD2D4C97DC78E552063EA309E70713@orsmsx505.amr.corp.intel.com> <20080820232332.GE18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201629590.3487@nehalem.linux-foundation.org> <m163pv59lo.fsf@frodo.ebiederm.org> <48AD03BD.9000909@zytor.com> <alpine.LFD.1.10.0808210830080.3487@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 18:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWD71-00048p-2w
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbYHUQct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYHUQct
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:32:49 -0400
Received: from main.gmane.org ([80.91.229.2]:57464 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751AbYHUQcs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:32:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWD5Z-0002G7-P7
	for git@vger.kernel.org; Thu, 21 Aug 2008 16:32:45 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 16:32:45 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 16:32:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <alpine.LFD.1.10.0808210830080.3487@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93172>

Linus Torvalds venit, vidit, dixit 21.08.2008 17:35:
> 
> On Wed, 20 Aug 2008, H. Peter Anvin wrote:
>> Personally, I think this grand renaming was a huge step backwards; an attempt
>> to be bug-compatible with other SCMs.  The only people I personally ever saw
>> complaining about the situation in the first place were people who were
>> fanbois of some other SCM.
> 
> Heh. It's true that the push came from people who were used to the "scm 
> xyz" model, but it's also true that git basically made the situation in 
> /usb/bin even worse. 
> 
> You _can_ actually have the "best of both worlds" (if you really do want 
> to continue the "git-xyzzy" usage) by doing
> 
> 	PATH=$PATH:$(git --exec-path)
> 
> although there has been noise about removing the built-in commands 
> entirely even from there. I'm cc'ing the git mailing list just to bring 
> the point up - I'm the one who actually championed removing the 
> "unnecessary" hardlinks, and it seems that nto doing so was the right 
> choice.
> 
> One of the reasons that the dashed format is being removed is a real 
> technical one, though: git aliases. They never supported the dashed 
> format, since they never were real executables (that's the whole point of 
> an alias, after all).
> 
> So even with the above path thing, you'll still have to use the spacey 
> version for any aliases you use.

Come to think of it: Maybe commands like "git pull" should, when
spitting out warnings, refer to "git help pull" rather than
"git-pull(1)" now. I do like it spacey, but the man issue is confusing.
It continues with the links in the help/man pages, of course.

Michael
