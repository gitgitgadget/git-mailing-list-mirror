From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git-windows and git-svn?
Date: Sat, 3 Nov 2007 09:02:31 +0100
Message-ID: <72D5CB06-9067-47C4-ABDF-4E1F6F4A679D@zib.de>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net> <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de> <472C211C.90907@obry.net> <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 09:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoE0B-000247-Sh
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 09:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907AbXKCIEs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 04:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756885AbXKCIEr
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 04:04:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:44433 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756844AbXKCIEp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 04:04:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA381AK3019247;
	Sat, 3 Nov 2007 09:04:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1075c.pool.einsundeins.de [77.177.7.92])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA3819hD005898
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 09:01:09 +0100 (MET)
In-Reply-To: <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63216>


On Nov 3, 2007, at 8:57 AM, Steffen Prohaska wrote:

> On Nov 3, 2007, at 8:19 AM, Pascal Obry wrote:
>
>> Steffen Prohaska a =E9crit :
>>>> The best Git port on Windows is the Cygwin one. I'm using git-svn
>>>> without trouble.
>>>
>>> But you _MUST NOT_ use Cygwin's textmode.
>>
>> Yes, of course! Who would use Cygwin's textmode :) ?
>
> People who I'm working with. Cygwin's converts CVS working
> copies to Windows line endings if you use textmode. And this
> is what they want.
>
> And as long as textmode is an option in Cygwin's installer
> user will select this option. And after it was removed from
> the installer it will still be there for a couple of years,
> until all existing installations finally disappear.
>
> Because of this situation, I started to work on msysgit.
> I need git without Cygwin.

And btw, no one told me that git is only working in Cygwin if
Cygwin is configured the right way. So I started to advertise
git on Cygwin and people came back to me and told me:

"What crappy tool are you suggesting to use. It's not
even capable of cloning it's own development repository.
I'll not use that tool. Don't steal my time."

	Steffen