From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git-windows and git-svn?
Date: Sat, 3 Nov 2007 10:47:58 +0100
Message-ID: <591E16CE-E303-4971-B57D-D84E883BB01D@zib.de>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net> <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de> <472C211C.90907@obry.net> <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de> <72D5CB06-9067-47C4-ABDF-4E1F6F4A679D@zib.de> <472C2FF8.2000603@obry.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 10:50:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFdg-00025n-5k
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 10:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbXKCJtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Nov 2007 05:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbXKCJtq
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 05:49:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:51236 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbXKCJtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 05:49:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA39kcak026105;
	Sat, 3 Nov 2007 10:49:41 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1075c.pool.einsundeins.de [77.177.7.92])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA39kb9m027454
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 3 Nov 2007 10:46:37 +0100 (MET)
In-Reply-To: <472C2FF8.2000603@obry.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63224>


On Nov 3, 2007, at 9:23 AM, Pascal Obry wrote:

> Steffen Prohaska a =E9crit :
>> "What crappy tool are you suggesting to use. It's not
>> even capable of cloning it's own development repository.
>> I'll not use that tool. Don't steal my time."
>
> Well it's not because people don't understand how Cygwin is working =20
> that
> it is to be taken for granted that Cygwin/Git is crap! As I said =20
> git svn
> is only working on Cywgin AFAIK. I'm using Cygwin/Git on many
> repositories without problem. So experience may vary :)

Right. The experience should be good if you use binmode.

But never use textmode. You'll not get an error right away.
At first git seems to work. But later it reports weird errors.
The experience is really bad. Don't do that.

And if you advertise git on Cygwin please tell people to
avoid textmode. It is an important detail.

	Steffen
