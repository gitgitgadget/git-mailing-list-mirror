From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: Cygwin: Use renames for creation
Date: Sun, 09 Aug 2015 11:01:26 +0200
Organization: gmx
Message-ID: <058a7756ada2fa5043ca9b910d6e1543@www.dscho.org>
References: <1438979428-5888-1-git-send-email-adam@dinwoodie.org>
 <55C66AF2.3060706@gmail.com>
 <20150808210627.GB155450@vauxhall.crustytoothpaste.net>
 <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 11:01:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOMU9-0003z1-4g
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 11:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbbHIJBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 05:01:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:52675 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530AbbHIJBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 05:01:34 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McVGq-1Z6pb61rQe-00HbxC; Sun, 09 Aug 2015 11:01:28
 +0200
In-Reply-To: <CA+kUOa=KRBSKDqWUj2RiO45PqVYGmN+yqG426jtUoXayxGkduw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:sGhk++FrO5vGUrwiQrLD4/Ny5+HmtDsf+/oeFoi3gbzG/QazLe+
 DiFNYc1/90MkWX2zEMLsfSxgRri8vTsjCPgrOz5F6mpegAaZtqaMeQqIDNzRRd1ZCj8Yl3o
 c0r4LNu6DJuGu9IYVbcy1nxDpTiaZzPKOUYHXhXx9fyCcnU6b9kqNacb9Y3+XjHKaNyywOV
 DTc3p/4OID73heWhp2KfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1NSuh256KBY=:7ZThWQCB00vOCCZVmdtLst
 Q235FCXh74wiUk9hIArIxtbSUYkT0ZMqKD5/BAi/haGLhtNc1utyhotYRCb8B5GgiE4dEbh0E
 D/YJ60CfeunJJudxylftaN7AgYTGoTeHHa+IUEZDLFl51VuQGX/BXrxVMb7c5nCDrI0G+JUEW
 l056WYQCnojAdxmufTXwy7S0qhdhTtCAzqAfGwvK4m8j1wXI3hAcJYpb5LaOyXR3g9HAR9DPj
 LbaRp406icV9mHua4J/TZSHajhmFTSsHJez0UYmO3LUHshulpw8x2JnSpsan1dvl1hiRJ8Ici
 KjDe0hQifc1ezTkFe/X6k4Nn6myhz3tk53vdpSqzYI7RWPUNJcZofNs8Qj0MKLv7pnbQgT5uv
 sYC1KzIi9DTTk31APgdYe86qQTDCgS+HSUD9EdUl0158Tuz9LZZOd9lF9OCfAdhaM3q9BT7mA
 5EN0lseDhC54+kTH8ApJaY7tbOBz8TGXC9zKE9GzTXe7bS2iU8E1b8y0Dqh1y8tpqFPuA5DiC
 ZBFZEaknSFBCegLokA7Z6Yi4hsTsc+7BvMO0jtABub+qaLlFp2jcQKTjkku2ucmRMkI0yZgv8
 p/S4aN0I7WN9QZY9+68KbAnSEAQzKMfjeD7Q5urd9EOV8BTIBY1nDAgXOa82X4gUnxErugr6+
 AxgHCFvXzAgtyQYPLzk0a25RS5ZjHRiwpvAsN7GTldJJWrfBRyphT2O6dhACYPOFmql520dD3
 p9+Xf9W/Otk+Q09BGYJBiIqlmCakjHs3RZvx9Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275534>

Hi Adam,

On 2015-08-09 04:01, Adam Dinwoodie wrote:

> I do not see any difference between the situation here and the situation
> for MinGW, which is fundamentally a Cygwin fork, but which already has
> this build option set for it in config.mak.uname.

This is incorrect. MinGW is distinctly *not* a Cygwin fork. MinGW means "Minimal GNU on Windows" and that in turn means that it provides an environment to build executables that purely use the Win32 API. Read: no POSIX emulation whatsoever. Most notably, MinGW programs cannot use fork(2); It is simply unavailable.

What you *probably* meant is that Git for Windows relies on MSys2 for its shell and Perl scripts, and that MSys2 in turn is a fork of Cygwin. That affects *only* the scripts, though; Git itself (as in `git.exe`) is still a pure MinGW program (and as a consequence, is quite a bit faster than Cygwin Git, at the price of certain quirks that Cygwin Git does not suffer).

>> We've gotten a lot of users on the list who ask why their Git
>> directories on shared drives aren't working (or are broken in some way).
>> Since I don't use Windows, let me ask: does the Cygwin DLL handle
>> link(2) properly on shared drives, and if not, would this patch help it
>> do so?  I can imagine that perhaps SMB doesn't support the necessary
>> operations to make a POSIX link(2) work properly.
> 
> I'd need to go back to the Cygwin list to get a definite answer, but as
> I understand it, yes, this is is exactly the problem -- quoting Corinna,
> one of the Cygwin project leads, "The MS NFS is not very reliable in
> keeping up with changes to metadata."
> 
> We have verified that setting `core.createobject rename` resolves the
> problem for people who are seeing it, which very strongly implies that
> this build option would solve the problem similarly, but would fix it
> for all users, not just those who spend enough time investigating the
> problem to find that setting.

>From my experience, it appears that providing Corinna Vinschen (or better put: the Cygwin developers in general) with a sound patch gets things fixed pretty timely.

And since `core.createObject = rename` seems to work around the problem, it should be possible to patch the Cygwin runtime accordingly. Sure, it will take a little investigation *what* code should be changed, and how, but the obvious benefit to *all* Cygwin applications should make that effort worth your while.

Please note that Cygwin's source code itself is in Git now, too: https://cygwin.com/git.html

Ciao,
Johannes
