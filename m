From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: AW: AW: "unable to remap" error with git svn after upgrade to
 Win10
Date: Wed, 15 Jul 2015 12:50:53 +0200
Organization: gmx
Message-ID: <1b9f222b56504c59c369678b33c02583@www.dscho.org>
References: <8e6220ba0ffb43dbbc7c4eaefd2ab753@CIPEXMB03N1.ci04.de>
 <cca8143375b9134b7a29f3748a3c4389@www.dscho.org>
 <8e9a6445d54343708757e16052539b6a@CIPEXMB03N1.ci04.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christoph Murczek <Christoph.Murczek@iteratec.at>
X-From: git-owner@vger.kernel.org Wed Jul 15 12:51:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFKHG-00062f-8X
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 12:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbbGOKu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 06:50:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:57635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbbGOKu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 06:50:56 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lh7sF-1YaRQY48iF-00oVzu; Wed, 15 Jul 2015 12:50:54
 +0200
In-Reply-To: <8e9a6445d54343708757e16052539b6a@CIPEXMB03N1.ci04.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:lTkb2WdFO0yBgnvxurh+IPjFuCi0jjkSpqBJdbie4LP2pIH8/y5
 s5TsK23I6L5elcNLrwtmLanhNBbJla+gASNLQlklOMzJP2PO5aoFdbJ1L4iD76vMHigXAZq
 2aU1WxyOc1Ut1HYXMNvmx3LOaaK38fn4djM0K6L02dO36ValhJC/FRnaxKGtomgdPwFjjq9
 Pfa9LPdS6OCh14win7whg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C42q53C+GUs=:QzMJOjPHkES1AcwxIN+IuJ
 Qj1L3KnVUoBrSeE/eDkmluZc38E4Kg2MhjCYtis0vD+1arKLSECJMRZGIImK9gYnO8nxXyk7T
 Mv6UEK2XJoVJTzWktipcy0dDyElst/Fx8I+gNHnWS6VNnLUrjNHTKnnVIgpuoNi8lU/R1GEPb
 K1TFmSSRql8+LkUwGOfRbv+rKia2MsRRopIsBhWzZA7nHypjv9MQv4nIEHAVh9TpPEWCdcme3
 +AjFpL9RU6iGt0bOvjmiJsBN5XOkHWYq4oChDYcstn354y7b5dIuwHwIn+KxIOtsLzcWuAgmg
 eY/eX5fKk3oRH6P5OUzcrpCtUdm7xpsLZlbVNc1NU4948Sh65XA9q3ueX0ES3U8Y48g2lkSP0
 cY5UrKg7m52K9/EdKj6qlqO3XdL3+YSO+Cy9XCrLKKNISZ7wgSvhEzJvXU1DfaXT0dGgW0rxC
 Ei54/MrEQ+mgJJCu3x52CKslxE7wvi3zFt2yAKk5Xx3JWTcRNWngvP7GC+ETIrIxi0jYAXudq
 oUCthQKrma9GQHGvenupVzUG4nkqnxdAgHIBRutvxfpWIyCCdj/8mY4wbGBkk7EUmkhsXLu/p
 qXTpef15ooGZvDqpuJePkiCc2swlGUwD7UEAxiep6hSX1vAvN3PmaSat0AcvB0j7SU0S1YGCO
 YeS9Bs2hE7gzFbRNZDtE0zPKVrHaq2npGCZ8scwsOcdz3QngtLNR4dQKSJEnq4fe1z9I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273984>

Hi Christoph,

On 2015-07-14 23:04, Christoph Murczek wrote:

> thanks for explaining why re-installing fixed my problem. Although I
> still can't wrap my head around why it happened in the first place. It
> could only be caused by Windows moving the base address of one, but
> not the other thus causing the overlap. Sounds weird. But then again,
> what do I know what's going on under the hoods when upgrading to
> Win10. ;)

To help that, I just wrote a wiki page about this very problem:

    https://github.com/git-for-windows/git/wiki/32-bit-issues

> In regards to your question: Yes I am running 64bit Windows, but the
> 32-bit version of git is the only thing I can download. I just
> double-checked on the webpage, but there's no option to get a 64 bit
> download link, and if there was some logic determining whether I
> should get 32 or 64 bit it puts me in the first bucket for some
> reason.
> I haven't considered building from source yet, mostly because the
> 32bit works fine so far. What would be the benefit? I guess
> performance when dealing with large repos? If you have a 64bit version
> available and need feedback let know. Always happy to help out :)

So I assumed that you found the official web site of Git for Windows 2.x:

    https://git-for-windows.github.io/

Its download link leads to 32-bit/64-bit versions of the installer and the portable Git.

Ciao,
Johannes
