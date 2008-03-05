From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: tracking renames
Date: Wed, 5 Mar 2008 10:39:47 -0500
Message-ID: <965172C8-C7A4-4932-899B-1E1A77BD7C12@yahoo.ca>
References: <20080304135734.b2c2f473.akpm@linux-foundation.org> <590657100803041403q2cc68e21p1c92c244939eb148@mail.gmail.com> <20080304141029.52b12065.akpm@linux-foundation.org> <m3zltegmj0.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Harvey Harrison" <harvey.harrison@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 16:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWvkC-0000xz-Nk
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 16:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbYCEPkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 10:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753933AbYCEPkF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 10:40:05 -0500
Received: from n27.bullet.mail.mud.yahoo.com ([68.142.200.142]:37686 "HELO
	n27.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754574AbYCEPkB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 10:40:01 -0500
Received: from [68.142.200.226] by n27.bullet.mail.mud.yahoo.com with NNFMP; 05 Mar 2008 15:39:57 -0000
Received: from [68.142.201.71] by t7.bullet.mud.yahoo.com with NNFMP; 05 Mar 2008 15:39:57 -0000
Received: from [127.0.0.1] by omp423.mail.mud.yahoo.com with NNFMP; 05 Mar 2008 15:39:56 -0000
X-Yahoo-Newman-Id: 996225.46114.bm@omp423.mail.mud.yahoo.com
Received: (qmail 41220 invoked from network); 5 Mar 2008 15:39:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=G+C0WbWhLbcHP5nmVSSZpoLFj9TW8imJI6IkTIldfD8IguL4p70x8f94tzRXoK3M/5BKVzxCmVvt0OLaHhZUb1AN8R+T9ULzdoukVDPdGzp4JKsT7a6Hk4gknyDbbrnzH4CCuMYxA8Jd59UOuEJds7lOmv7FCEa/XWt6QUsHeiQ=  ;
Received: from unknown (HELO ?192.168.3.248?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp103.mail.mud.yahoo.com with SMTP; 5 Mar 2008 15:39:56 -0000
X-YMail-OSG: rW1DyM0VM1lU_Fm0hCrmbq45BzKyUs5yIbpex67iGPGtoVF_s1QJEzPJJmlu_mqqbuORdm6vZg--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <m3zltegmj0.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76230>

Le 08-03-04 =E0 17:19, Jakub Narebski a =E9crit :

> Andrew Morton <akpm@linux-foundation.org> writes:
>
>> On Tue, 4 Mar 2008 14:03:54 -0800
>> "Harvey Harrison" <harvey.harrison@gmail.com> wrote:
>>>
>>> git-whatchanged --follow drivers/watchdog/iTCO_wdt.c
>>>
>>
>> Oh.  Thanks.  It seems dumb that one needs to add an option to get
>> it to do this.
>
> In "git log <paths>..." or "git whatchanged <paths>..." the <paths>
> option is "path limiter" and can be a directory. There can be more
> than one path. And following renames is more costly.

Am I the only one who think rename could be explicit ?
Don't take me wrong, I do appreciate the fact that git recognize =20
renames after-the-fact, when specifically asked for it.
But as a developer, at some point, a rename is no longer a point-of-=20
view discovery, a rename is a rename by 'design', by the nature =20
itself of the change, it's no longer an after-the fact realisation.
It seem to me that no mather how smart we try to discover renames, =20
there will always be cases where algorithm won't discover due to time/=20
space/other constraints.
I would like something like 'graft' where after the fact, we can =20
educate git that there is a connection between 2 commits.  In a =20
similar way, at some point, I would like to tell git, 'ok stop trying =20
to figure out which changes are renames, you guessed it right for the =20
last 10 times, just freeze it ... but let me adjust it if you guessed =20
it wrong'.

This is a comment from  a git user, I've not looked at the code at =20
all (and probably won't do anytime soon).

- jfv


