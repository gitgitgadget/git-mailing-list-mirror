From: Abdelrazak Younes <younes.a@free.fr>
Subject: Re: Windows binaries for qgit 2.0
Date: Sun, 16 Dec 2007 10:10:03 +0100
Message-ID: <fk2q1f$bbh$1@ger.gmane.org>
References: <e5bfff550712150702p2675da8axed1f3db6273f619@mail.gmail.com>	 <fk2juf$t25$1@ger.gmane.org>	 <e5bfff550712152355o7c8ef2f3j95f239697f77ccef@mail.gmail.com>	 <fk2p0f$961$1@ger.gmane.org> <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 16 10:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3pWh-0006RJ-Od
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 10:11:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbXLPJKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 04:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbXLPJKs
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 04:10:48 -0500
Received: from main.gmane.org ([80.91.229.2]:45442 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616AbXLPJKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 04:10:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J3pVn-0006ST-44
	for git@vger.kernel.org; Sun, 16 Dec 2007 09:10:15 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 09:10:14 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 16 Dec 2007 09:10:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <e5bfff550712160105w3817a460v3db1bde15969fcf2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68449>

Marco Costalba wrote:
> On Dec 16, 2007 9:52 AM, Abdelrazak Younes <younes.a@free.fr> wrote:
>> Hum, I can't imagine this is the reason, it might be for another reason,
>> most certainly the static compiling.
>>
> 
> Static compiling is indeed a highly suspect. I'm now compiling as
> shared libraries, we will see...

Another suspect is that under Windows, at least with MSVC, it is 
strongly advised to not mix debug and release libraries as they have 
different memory models. I am not sure to what extend this advice is 
valid for mingw compiled libraries.

> 
>> Well, for the LyX project we used to use and distribute the patched
>> version of Qt in order to compile it with MSVC. Now, since Qt4.3.2 the
>> MSVC compilation support is enabled in the official release so you don't
>> even have to patch it anymore. I can send you precompiled dll if you
>> want.
> 
> Sorry for the stupid question, but, what ddl ??

The MSVC compiled Qt dlls :-)
Sorry too, I guess I was not clear enough.

Abdel.
