From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bug report Windows 10
Date: Mon, 10 Aug 2015 15:05:06 +0200
Organization: gmx
Message-ID: <16cbfe1f65f82104d084ce9626be7097@www.dscho.org>
References: <017101d0d367$d2009490$7601bdb0$@ms-informatique.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: MS-Informatique <info@ms-informatique.be>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:05:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOmlP-0003sN-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 15:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbbHJNFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 09:05:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:56010 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbbHJNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 09:05:10 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MBnPX-1ZZTsa2zsl-00AqkD; Mon, 10 Aug 2015 15:05:07
 +0200
In-Reply-To: <017101d0d367$d2009490$7601bdb0$@ms-informatique.be>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:qFZqkFqyfIpkeFhT+4mqpdmtda5hgBQl6CAgiFFuOYyRrHoahc0
 kLKqElKYm3hHBJtB9S/dovsld2aaC6GZgjsOt72nya18pEgGnm4ubEM2Ofsl+IUk4MqBg6V
 FSVrWSEwrTELEzshJop3y+c9ZZuiY0huuxrbn3F/yn6ULdj7K7sV9biGbYwHzi3KXzToupS
 Sl78oQ4BDw35BxtynheFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dk5d+Zx20LA=:Ob9E9kgYM2y4gLE/h6mx9K
 wLS7EpEEeuxVgbRM1lW2JZy1THJOBP6EAb/ot5dGfeyDErhaNLreHYVu2itU1p4xbGor7i5yj
 Pddgzvfz3PiRby645Hih7yrw7jHAIC0Ua9oiOY55LGqRQgH7Y4DK90oDn7tnYAek9jmf7X9+9
 FHg41SdA0P5lGS/Pwdl4IDG56laSwTUKyOVK/hg7gPhfsvfhZplmpqqEVkRRLudYYkO+MaxRi
 E7/QAtCHt2l8U0k4jOCune8mqd09SAQQO2W8jWtLQ5ga9zA3eUT9+Lw1tkybBKENE+hrFoZkp
 FhzG/oTjwq4gfQ+h6/cs5uFDGF35Iw3+ZZb67UUTYNodqou7yNdT7ZYis08jcZwjzQMn46GZJ
 W1LpGYOUzD9QmP7gIHLdaPFbutQeU1Ot3JwpYb9v6dOosFhurTRv3HM39kHztfZCy/4uT08oJ
 sw9LDHAyKJ6AIKleatflAOe4+rSoOwk+ou0IUYXAl+X6XzjoZiAsWoDoPc+FdD2X/DZQVMsLw
 CN5lKe2DXULxMfllMuukgcJ5uv+IkmuydguzhQkmJQhw0yk+YwoRM5JJvPDdvlO85I+x4xuUH
 5dshvapwYboXpc9fXVk5T26BA3+f9h2ZBV6yiqq8unP8ntkVmfhgbRCEV2dYDbC1HcJmlAH+M
 QqwkQvaB8YVqmE63aruTC+XrgquwGc6MnVo5K0lzjjWyzG1szUUYhEZKpF6ic0M+YpMBn2IoC
 RJhd4k5z/uIIcZvxtFl4iG3wSYWpEU0aL23Wtg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275616>

Hi,

On 2015-08-10 14:26, MS-Informatique wrote:
> My Windows notebook got updated to Windows 10 and now my Git Bash doesn't
> start and when I open an existing repository from Git Gui, I am getting next
> error: 
> "0 [main] us 0 init_cheap: VirtualAlloc pointer is null, Win32 error 487
> AllocationBase 0x0, BaseAddress 0x68570000, RegionSize 0x410000, State
> 0x10000
> C:\Program Files (x86)\Git\bin\sh.exe: *** Couldn't reserve space for
> cygwin's heap, Win32 error 0"
> 
> I am running GIT version 1.9.5 (latest build for Windows).
> 
> Can someone help me?

First of all, the home page of Git for Windows has hints where to report bugs (and where to look for possible resolutions first).

Second, this issue is so common that I wrote a wiki page about it: https://github.com/git-for-windows/git/wiki/32-bit-issues

Short version: reinstall Git for Windows. Preferably a 64-bit Git for Windows 2.x from https://git-for-windows.github.io/. And you might want to heed the advice given in http://git-for-windows.github.io/#contribute when you want to report bugs ;-)

Ciao,
Johannes
