From: "rollinsdr@gmail.com" <rollinsdr@gmail.com>
Subject: Re: Submodule status inside nested submodule fails
Date: Wed, 9 May 2012 18:40:04 -0700 (PDT)
Message-ID: <1336614004527-7545109.post@n2.nabble.com>
References: <loom.20120224T104003-230@post.gmane.org> <loom.20120224T142455-253@post.gmane.org> <1336500675427-7540130.post@n2.nabble.com> <20120509213443.GA74366@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 03:40:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSIN9-00035r-UG
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 03:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab2EJBkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 21:40:07 -0400
Received: from sam.nabble.com ([216.139.236.26]:48079 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab2EJBkG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 21:40:06 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <rollinsdr@gmail.com>)
	id 1SSIMO-0007s6-N7
	for git@vger.kernel.org; Wed, 09 May 2012 18:40:04 -0700
In-Reply-To: <20120509213443.GA74366@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197534>

Thanks Heiko,


Heiko Voigt-3 wrote
> 
> Hi,
> 
> On Tue, May 08, 2012 at 11:11:15AM -0700, rollinsdr@ wrote:
>> I'm having the same issue. Did it ever get resolved, or is there a hack
>> to
>> fix it, or is there some link I can track it on?
>> 
>> 
>> Charles Brossollet wrote
>> > 
>> > Charles Brossollet <chbrosso <at> lltech.fr> writes:
>> > Using MSysGit 1.7.9 on Win7 (64 bit), I have a repo with the following 
>> > structure: 
>> > 
>> > main/ 
>> >   src/ 
>> >   ext/ 
>> >     submodule/ 
>> >        modules/module1 
>> >        modules/module2 
>> > 
>> > submodule is... a submodule, having itself submodules. 
>> > 
>> > When I query submodule status --recursive in main/, no problem. 
>> > But when I query submodule status in  ext/submodule, I get error "You
>> need
> 
> Without having looked at the code itself this smells like an issue with
> the newly introduced gitlink files and git rev-parse --show-cdup not
> taking this into account.
> 
> I will have a look at this issue.
> 
> Cheers Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@.kernel
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Actually the issue went away once I upgraded from 1.7.9 to 1.7.10, and
re-cloned my repo. I guess it was fixed in 1.7.10, but some stuff in the
config files had to be rewritten during the new clone to fix the issue b/c
just switching to 1.7.10 and trying to use the existing repo still had the
same issue.

Thanks for all the work you guys do!
DAVE

--
View this message in context: http://git.661346.n2.nabble.com/Submodule-status-inside-nested-submodule-fails-tp7314413p7545109.html
Sent from the git mailing list archive at Nabble.com.
