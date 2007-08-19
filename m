From: David Kastrup <dak@gnu.org>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 21:05:24 +0200
Message-ID: <85sl6fqr9n.fsf@lola.goethe.zz>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>
	<87vebbo0f1.fsf@mid.deneb.enyo.de>
	<03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Aaron Gray" <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMq5k-00055g-L1
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 21:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbXHSTFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbXHSTFd
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 15:05:33 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:51133 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751489AbXHSTFd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 15:05:33 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id C1FD027AD51;
	Sun, 19 Aug 2007 21:05:30 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id AF95A201002;
	Sun, 19 Aug 2007 21:05:30 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-172.pools.arcor-ip.net [84.61.25.172])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 84F401F7090;
	Sun, 19 Aug 2007 21:05:30 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0BFDB1C36605; Sun, 19 Aug 2007 21:05:26 +0200 (CEST)
In-Reply-To: <03b401c7e28f$3c7304c0$0600a8c0@ze4427wm> (Aaron Gray's message of "Sun\, 19 Aug 2007 19\:32\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3997/Sun Aug 19 17:04:14 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56139>

"Aaron Gray" <angray@beeb.net> writes:

>>* Aaron Gray:
>>
>>> I have a very large C source project that I am converting from C to C++.
>>>
>>> Is it posssible to track changes with renamed files in GIT ?
>>
>> You don't need to rename the files if you compile them using g++.  If
>> you still want to rename them, most history-related GIT commands
>> accept an -M switch which enables rename ("move") detection.
>
> For sanity they have to be renamed.
>
> I am a bit of a GIT newbie. With the -M switch what would be the
> proceedure with a single file conversion such as with test.c and
> test.cpp ?
>
> Would the following do the trick ?
>
>    git add test.c
>    git commit
>
>    rename test.c test.cpp *
>    vi test.cpp
>
>    git rm test.c
>    git add test.cpp
>    git commit -M
>
> Many thanks in advance,

There is no such thing as "git commit -M".  git does not keep track of
renames.  It generates the rename info on the fly when you ask it for
patches, log stats, blame annotations or similar.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
