From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 18:22:16 +0800
Message-ID: <46A72458.1000004@midwinter.com>
References: <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net> <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241337470.14781@racer.site> <46A5FDF0.3060801@trolltech.com> <Pine.LNX.4.64.0707241431540.14781@racer.site> <46A63EAA.6080203@trolltech.com> <Pine.LNX.4.64.0707241923450.14781@racer.site> <46A654A6.5070802@trolltech.com> <20070724231529.GA29156@steel.home> <46A6F21D.2010306@trolltech.com> <Pine.LNX.4.64.0707251024390.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 25 12:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDe0r-0001Dr-4i
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 12:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756473AbXGYKWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 06:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756338AbXGYKWX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 06:22:23 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:45537
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1755698AbXGYKWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 06:22:22 -0400
Received: (qmail 11689 invoked from network); 25 Jul 2007 10:22:22 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qFWE+AjZZVNbjcqd6e+Dj4O4/hzCvCj7CFwchxYSZ9dflNrqhvu3g9fm4yUAAM11  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 Jul 2007 10:22:21 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <Pine.LNX.4.64.0707251024390.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53679>

Johannes Schindelin wrote:
> So this leaves me with the question: do Windows users really want a proper 
> native Windows support for Git?  If the answer is yes, why don't they _do_ 
> (as in "not talk") something about it?
>   

I'm not a Windows user, but I know some, so I can maybe answer this: 
They do want that, but what they primarily want is a good DVCS they can 
use without trouble. I know at least two Windows people who took a look 
at the Win32 git, had trouble with it, then looked at Mercurial (which, 
whatever opinions you might have about it, does work better on Windows) 
and just stuck with that since it met their needs.

The fact that Mercurial exists is a big disincentive for Windows people 
to work on git; unless they specifically want to interoperate with an 
existing git repository, hg gives them a lot of the same features that 
we enjoy in git land. And they don't have to fiddle with MinGW or Cygwin 
or anything like that. The distance between git and hg is small enough 
in their minds that it's not worth the unknown amount of effort to work 
on making git run better.

At least, that's my take on it. Maybe an actual Windows git user will 
tell me I'm full of it...

-Steve
