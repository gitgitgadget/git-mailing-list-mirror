From: Erik Blake <erik@icefield.yk.ca>
Subject: Re: Escape character for .gitconfig
Date: Tue, 20 Dec 2011 09:04:41 +0100
Message-ID: <4EF04199.1010008@icefield.yk.ca>
References: <4EEC6A9D.1060005@icefield.yk.ca> <20111217105806.GB23935@sigill.intra.peff.net> <4EED9BE5.8060600@icefield.yk.ca> <20111218095120.GA2290@sigill.intra.peff.net> <4EEF5F59.8030802@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Dec 20 09:44:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcvJf-0008OF-Ma
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 09:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab1LTIow convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 03:44:52 -0500
Received: from bosmailout04.eigbox.net ([66.96.186.4]:39148 "EHLO
	bosmailout04.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1LTIou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 03:44:50 -0500
X-Greylist: delayed 2402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Dec 2011 03:44:50 EST
Received: from bosmailscan01.eigbox.net ([10.20.15.1])
	by bosmailout04.eigbox.net with esmtp (Exim)
	id 1Rcugo-0005NN-Vb
	for git@vger.kernel.org; Tue, 20 Dec 2011 03:04:47 -0500
Received: from bosimpout02.eigbox.net ([10.20.55.2])
	by bosmailscan01.eigbox.net with esmtp (Exim)
	id 1Rcugo-0005aM-5B; Tue, 20 Dec 2011 03:04:46 -0500
Received: from bosauthsmtp05.eigbox.net ([10.20.18.5])
	by bosimpout02.eigbox.net with NO UCE
	id BL4m1i00906Zqne01L4mqo; Tue, 20 Dec 2011 03:04:46 -0500
X-EN-OrigOutIP: 10.20.18.5
X-EN-IMPSID: BL4m1i00906Zqne01L4mqo
Received: from [77.40.181.154] (helo=[192.168.10.131])
	by bosauthsmtp05.eigbox.net with esmtpa (Exim)
	id 1Rcugo-0004uN-42; Tue, 20 Dec 2011 03:04:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEF5F59.8030802@dirk.my1.cc>
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:fb4e807829017c6d805c060c7025d0c2
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 77.40.181.154
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187503>

Hi Dirk,

I ended up using "'C:/Program Files (x86)/Notepad++/notepad++.exe'=20
-multiInst -notabbar -nosession -noPlugin" which works nicely for me=20
(note the placement of the inner quotations).

It is notepad.exe (the default Windows editor) that fails on files with=
=20
only <lf> termination. That's why I was trying to set notepad++ as the=20
git editor as it is vastly superior.

Cheers,
Erik

On 2011-12-19 16:59, Dirk S=C3=BCsserott wrote:
> Am 18.12.2011 10:51 schrieb Jeff King:
>> On Sun, Dec 18, 2011 at 08:53:09AM +0100, Erik Blake wrote:
>>
> [...]
>>> Now, however, I have a different problem in that notepad++ is someh=
ow
>>> signalling git that editing is complete before I even get a chance =
to
>>> edit the file. I am trying the command
>>>> git commit --amend
> [...]
>> I know nothing about notepad++, but a quick google turned up the
>> "-multiInst" option, which would avoid attaching to the existing
>> instance. That might work for you.
>>
>> -Peff
> Jeff is right! I also use notepad++ and have set
>
> export GIT_EDITOR=3D'notepad++ -multiInst'
>
> in my .bashrc (msysGit). And btw: notepad++ DOES handle cr/lf. Look a=
t
> the "Format" menu.
>
>      Dirk
