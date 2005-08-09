From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Cannot install git RPM
Date: Tue, 09 Aug 2005 17:36:38 +0200
Message-ID: <42F8CD86.9000409@anagramm.de>
References: <20050809104040.B9C61352B36@atlas.denx.de> <20050809110705.6B1FF352B36@atlas.denx.de> <42F8AE6E.2020808@anagramm.de> <Pine.LNX.4.58.0508090758110.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 17:37:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2W9f-00060b-Lh
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 17:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVHIPgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 11:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVHIPgg
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 11:36:36 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:15594 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964823AbVHIPgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 11:36:36 -0400
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1E2W9W-00016g-00; Tue, 09 Aug 2005 17:36:30 +0200
Received: from [84.154.80.14] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1E2W9W-0000hI-00; Tue, 09 Aug 2005 17:36:30 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508090758110.3258@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus!

Linus Torvalds wrote:
> 
> On Tue, 9 Aug 2005, Clemens Koller wrote:
> 
>>Over here - using a non-standard ELDK/LFS mixture, git depends at least on:
>>...
>>diffstat (ftp://invisible-island.net/diffstat/diffstat-1.39.tgz)
> 
> 
> Hmm.. This should not be true. Any "diffstat"s should be converted to use
> "git-apply --stat" instead.
> 
> I don't find any diffstat users, so maybe you just remember it from "the 
> old days", and didn't realize that it's not needed any more.

Okay, just FYI: As far as my installation history remembers it was needed
at least up to:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
Which is _NOT_ recommended for new installations!
(Can somebody please remove/mark that old stuff to avoid using it?!)

Instead use:
http://www.codemonkey.org.uk/projects/git-snapshots/git/git-latest.tar.gz

> [ That said, anybody who wants to install git might as well install 
>   diffstat, it's a useful program in general, and works on more than just 
>   unified diffs ]

true.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
