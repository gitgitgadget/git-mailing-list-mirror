From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Fwd: after first git clone of linux kernel repository there are changed files in working dir
Date: Thu, 11 Dec 2008 21:35:16 +0100
Message-ID: <ghrti4$m53$1@ger.gmane.org>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com> <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com> <e32b7bb40812101220s370a64f1n3f7ecb56dd352405@mail.gmail.com> <d304880b0812110142g41b80745ic09a7200e02dcdb0@mail.gmail.com> <d304880b0812110915o6968050cufbb1e29c8bcea984@mail.gmail.com> <alpine.LFD.2.00.0812110934180.3340@localhost.localdomain> <d304880b0812110958u3da52e4fs7e5154ebe9a353a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 21:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAsHD-000148-2q
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 21:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202AbYLKUfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756946AbYLKUfc
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 15:35:32 -0500
Received: from main.gmane.org ([80.91.229.2]:34538 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756981AbYLKUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 15:35:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LAsFn-0004mS-PX
	for git@vger.kernel.org; Thu, 11 Dec 2008 20:35:23 +0000
Received: from 78.13.53.163 ([78.13.53.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 20:35:23 +0000
Received: from giuseppe.bilotta by 78.13.53.163 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 20:35:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78.13.53.163
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102821>

On Thursday 11 December 2008 18:58, rdkrsr wrote:

> Thank you, Linus and Brett, for your answers.
> 
> I'm not developing linux kernel, I just wanted to experiment with git.
> And then I didn't know if this is a normal behaviour of git. I'm using
> windows xp and msysgit for this. And the file system is NTFS. I'm
> using dual boot to sporadicly use linux and tried also linux in
> virtual box. But both isn't really good. Maybe one day I dare to use
> linux as my primary OS.
> 
> Red
> 
> 2008/12/11 Linus Torvalds <torvalds@linux-foundation.org>:
>>
>>
>> On Thu, 11 Dec 2008, rdkrsr wrote:
>>>
>>> I'm sorry that I didn't answer to git mailing list address. So here
>>> comes the email again.
>>
>> You have a broken filesystem.

Actually, the funny (in a grotesque kind of way) thing about NTFS
is that it's a case-*sensitive* filesystem (in the sense that i
can legally hold files with names that differ only for the case),
but the Windows subsystems use it in case-preserving (but
insensitive) mode. It is possible to use NTFS case insensitively
under Windows, but it requires something such as the Interix
subsystem, and in Windows XP (and possibly later versions) it also
needs toggling a security policy that defaults to enforcing case
insensitivity for all subsystems.

Maybe the Windows ports to git (at least the cygwin one, maybe?)
may be able to exploit this.

-- 
Giuseppe "Oblomov" Bilotta
