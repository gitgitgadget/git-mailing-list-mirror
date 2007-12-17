From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: [msysGit] Re: Windows binaries for qgit 2.0
Date: Mon, 17 Dec 2007 12:07:56 +0100
Message-ID: <fk5lad$mlc$1@ger.gmane.org>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>  <fk2juf$t25$1@ger.gmane.org>  <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>  <fk2p0f$961$1@ger.gmane.org>  <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>  <fk2q1f$bbh$1@ger.gmane.org>  <e5bfff550712160242v54ce284emd31a29964770179c@mail.gmail.com>  <fk3153$rtb$1@ger.gmane.org> <e5bfff550712161426y101c77efl4f5321d3440fed3f@mail.gmail.com> <fk5grp$7il$2@ger.gmane.org> <Pine.LNX.4.64.0712171042520.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 12:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Dpv-0006um-N9
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935617AbXLQLIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935590AbXLQLIK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:08:10 -0500
Received: from main.gmane.org ([80.91.229.2]:47732 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935472AbXLQLII (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:08:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J4DpN-00074E-DD
	for git@vger.kernel.org; Mon, 17 Dec 2007 11:08:05 +0000
Received: from matrix-eth-s4p3c0.eurocontrol.fr ([192.93.23.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 11:08:05 +0000
Received: from younes.a by matrix-eth-s4p3c0.eurocontrol.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 11:08:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: matrix-eth-s4p3c0.eurocontrol.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712171042520.9446@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68540>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 17 Dec 2007, Abdelrazak Younes wrote:
> 
>> Marco Costalba wrote:
>>> On Dec 16, 2007 12:11 PM, Abdelrazak Younes <younes.a@free.fr> wrote:
>>>> Actually you might prefer to just use the LyX dependencies package that
>>>> we provide for Windows developers, it contains Qt. I paste here the
>>>> relevant part of our 'INSTALL.Win32':
>>>>
>>> Thanks, I've tried it but without success because I need MSVC 2005
>>> installed, and currently is not.
>> Right.
>>
>>> Anyhow for now I have produced a version with mingw that seems more or
>>> less to work, when I have a bit of time I will install MSVC 2005 and
>>> try if with that compiler is better...
>> I would like to help you with that but I can't retrieve the repository:
>>
>> $ git clone git://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
>> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
>> git.kernel.org[0: 130.239.17.7]: errno=Invalid argument
>> git.kernel.org[1: 199.6.1.166]: errno=Bad file descriptor
>> git.kernel.org[2: 204.152.191.8]: errno=Bad file descriptor
>> git.kernel.org[3: 204.152.191.40]: errno=Bad file descriptor
>> fatal: unable to connect a socket (Bad file descriptor)
>> fetch-pack from 'git://git.kernel.org/pub/scm/qgit/qgit4.git' failed.
>>
>> $ git clone http://git.kernel.org/pub/scm/qgit/qgit4.git qgit4.git
>> Initialized empty Git repository in d:/devel/git/qgit4/qgit4.git/.git/
>> Cannot get remote repository information.
>> Perhaps git-update-server-info needs to be run there?
>>
>> $ git --version
>> git version 1.5.3.6.1791.gfd264
>>
>> 'git clone ssh://...' seems to work but I guess I need a login and password?
>>
>> Maybe I am doing something wrong here? Sorry, my first time ever with git...
>>
>> Abdel.
>>
>> PS: Sorry for the cross posting but I guess this issue is maybe of
>> interest to msysgit people.
> 
> Why would anything that has to do with MSVC2005 be interesting to msysGit?  
> Note the "msys" part of "msysGit".

Sorry, I meant the error I am facing trying to clone the qgit 
repository. MSVC2005 has of course nothing to do with MSYS (while one 
could imagine that MSys and for the matter git could be compiled with it 
instead of mingw).

> 
> FWIW a member of our team works on compiling/including qgit into msysGit.  
> But definitely not using closed-source compilers.  I would violently 
> oppose that.

Noted. I didn't meant to start a debate here.

Abdel.
