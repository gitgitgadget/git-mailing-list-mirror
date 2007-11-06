From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git-windows and git-svn?
Date: Tue, 6 Nov 2007 09:20:51 +0100
Message-ID: <19A8600D-B8F8-4590-90E9-C2DEFB528A24@zib.de>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net> <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de> <472C211C.90907@obry.net> <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de> <72D5CB06-9067-47C4-ABDF-4E1F6F4A679D@zib.de> <472C2FF8.2000603@obry.net> <591E16CE-E303-4971-B57D-D84E883BB01D@zib.de> <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pascal Obry <pascal@obry.net>,
	Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJfI-0002RM-ET
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbXKFITu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXKFITu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:19:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:64479 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327AbXKFITu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:19:50 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA68JWl6018857;
	Tue, 6 Nov 2007 09:19:45 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA68JVE8027060
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 6 Nov 2007 09:19:31 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63640>


On Nov 6, 2007, at 9:02 AM, Peter Karlsson wrote:

> Steffen Prohaska:
>
>> Right. The experience should be good if you use binmode.
>
> Shouldn't it be possible to fix this by sprinkling the appropriate
> number of "b"s in the parameters to fopen()? Or is it more complicated
> than that?

It's more complicated. I tried. But others convinced me that
it's harder than you think. The interfacing with other programs
through shell scripts is one major problem. Another difficulty
is that Cygwin's textmode is deprecated. So, the Cygwin guys
won't help. Search the list archives for more details.


>> But never use textmode. You'll not get an error right away. At first
>> git seems to work. But later it reports weird errors. The experience
>> is really bad. Don't do that.
>
> I got errors almost right away when trying that (I need text mode to
> interface with some other programs), so Cygwin-git is a no-go for  
> me at
> the moment.

Same for me. You're welcome to join the msysgit effort ;)

But do not expect too much from my side. For me the only
priority is to get the core git commands running. Everything
that is needed to support a git-only workflow has top priority.
Everything else has lowest priority. I'll refuse to put work
into the scripts interfacing with other SCMs and I'll refuse
to work on things needed to setup a git 'server', like git-shell.


> Of course, mixing msys-Git with Cygwin and ActiveState Perl
> is also an interesting experience, to say the least :-)

I can imagine that. If you already have some new insights how
to handle such a situration it would be interesting if you
could share some of them.

	Steffen
