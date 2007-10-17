From: David Kastrup <dak@gnu.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 07:56:50 +0200
Organization: Organization?!?
Message-ID: <85lka2ffmk.fsf@lola.goethe.zz>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 07:58:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii1uq-00021U-Es
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 07:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934918AbXJQF5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 01:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935028AbXJQF5J
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 01:57:09 -0400
Received: from main.gmane.org ([80.91.229.2]:43505 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934918AbXJQF5H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 01:57:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ii1tE-0006ys-1H
	for git@vger.kernel.org; Wed, 17 Oct 2007 05:56:20 +0000
Received: from dslb-084-061-008-130.pools.arcor-ip.net ([84.61.8.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 05:56:20 +0000
Received: from dak by dslb-084-061-008-130.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 05:56:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-008-130.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:g9iRWDI1EB6+89jIfUIvrd51jKM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61334>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 16 Oct 2007, Tom Tobin wrote:
>> 
>> But you then dismiss out of hand the option of using all spaces
>
> I do indeed. I don't think it's sensible.

Actually, it seriously degrades (both performance and savings)
deltifying once you reach an indentation of 16.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
