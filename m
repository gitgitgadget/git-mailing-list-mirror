From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: Cannot install git RPM
Date: Tue, 09 Aug 2005 15:23:58 +0200
Message-ID: <42F8AE6E.2020808@anagramm.de>
References: <20050809104040.B9C61352B36@atlas.denx.de> <20050809110705.6B1FF352B36@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 15:24:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2U5H-00051n-BP
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 15:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVHINXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVHINXv
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 09:23:51 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:51949 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932536AbVHINXv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 09:23:51 -0400
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1E2U57-00024D-00; Tue, 09 Aug 2005 15:23:49 +0200
Received: from [84.154.80.14] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1E2U57-00079W-00; Tue, 09 Aug 2005 15:23:49 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050809110705.6B1FF352B36@atlas.denx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Wolfgang!

> But the resulting RPM cannot be installed either,  at  least  not  in
> standard Fedora Core 2/3/4 installations:
> 
> error: Failed dependencies:
>         perl(Email::Valid) is needed by git-core-0.99.3-1
>         perl(Mail::Sendmail) is needed by git-core-0.99.3-1
> 
> 
> Seems git is depending on more and more stuff which is not  available
> in standard distros. This makes it not easier for new users...
> 
> Is there at least some  documentation  which  external  packages  are
> needed, and where to find these?

Over here - using a non-standard ELDK/LFS mixture, git depends at least on:
zlib ()
libcurl (http://curl.haxx.se/download/curl-7.14.0.tar.bz2)
openssl ()
diff ()
diffstat (ftp://invisible-island.net/diffstat/diffstat-1.39.tgz)
which (http://www.xs4all.nl/~carlo17/which/which-2.16.tar.gz)
rsync (http://samba.anu.edu.au/ftp/rsync/rsync-2.6.5.tar.gz)
perl ()

() -> ask Google.
The versions given in brackets seem to work fine for me. - YMMV

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
