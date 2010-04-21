From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Add warning when there are changes in the index and using -a with  git commit
Date: Wed, 21 Apr 2010 23:38:38 +0200
Message-ID: <0CCBCCA0-8378-42A8-A925-F60AA09949DC@wincent.com>
References: <v2m7fce93be1004211320r9adc0b14j11bd06c3b045e639@mail.gmail.com> <q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:11:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4i8H-00016l-NU
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab0DUWKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 18:10:52 -0400
Received: from outmail148097.authsmtp.co.uk ([62.13.148.97]:55764 "EHLO
	outmail148097.authsmtp.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755436Ab0DUWKv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:10:51 -0400
X-Greylist: delayed 1917 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2010 18:10:51 EDT
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt10.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o3LLcqKd025602;
	Wed, 21 Apr 2010 22:38:52 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o3LLcirh080881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Apr 2010 22:38:45 +0100 (BST)
Received: from [192.168.1.6] (175.Red-88-3-72.dynamicIP.rima-tde.net [88.3.72.175])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o3LLceLq006231
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 21 Apr 2010 17:38:42 -0400
In-Reply-To: <q2pfabb9a1e1004211421q80d273ady11f4621284522c46@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 4356428e-4d8e-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJDkVH aB8dB0JJdwdEHAkR AWQBWFxeVFg/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNF3kUUkVD Xh4WUhF6dktHeX55 YwhmXXVdWEZyIFt5 FkYBCGwHMTF9OTIb Vl1YdwJVeAYefRhC OQExNiYHcRRTMmon FhU1PjY+dSpfJSId XgEAN19aSFwGVjU8 ThYNEC5nHEtNWyU+ Zx0gJlMMVE8XPg0v KlonVhpdOlcNCxFe VwlCATMRLF4EQis3 ZT34
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145470>

El 21/04/2010, a las 23:21, Sverre Rabbelier escribi=F3:

> Heya,
>=20
> On Wed, Apr 21, 2010 at 22:20, Sylvain Rabot <sylvain@abstraction.fr>=
 wrote:
>> Many times I had the bad reflex of doing a git commit -as -m "blah
>> blah" when I was willing to commit only things I had staged in the
>> index.
>=20
> Me too, and I think I brought it up in the past and it was dismissed
> as being too annoying, but I'm not sure. Either way, you can work
> around it by creating your own 'git-co' wrapper that does the check
> and use that instead of 'git commit'.

I think this is a tendency fostered by evil tutorials which start off b=
y saying that people can use "git commit -a" in order to continue worki=
ng in the same way they are used to from Subversion. (These tutorials d=
o more harm than good, IMO. Counseling people to use "git commit -a" an=
d live as though the index didn't exist is about the same as teaching n=
ewcomers to VIM that they should just stay in insert mode the whole tim=
e; it's encouraging bad habits that end up producing a limited awarenes=
s of and proficiency with the tool.)

I personally never make the mistake of accidentally including an "-a" i=
n my "git commit" parameters, because for me "-a" is not something rout=
ine but actually quite the opposite: something extremely exceptional.

Without even really meaning to, I ended up training myself to only comm=
it what's staged in the index, because early on I acquired the habit of=
 always reviewing every single changed hunk by using "git add --patch" =
(in fact I use it so often that I've created an alias of "git patch" fo=
r it). There's no telling how many times this kind of last-minute hunk-=
by-hunk reviewing has saved me from committing bad code.

Cheers,
Wincent
