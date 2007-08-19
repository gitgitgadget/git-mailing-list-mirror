From: David Kastrup <dak@gnu.org>
Subject: Re: renaming question
Date: Sun, 19 Aug 2007 21:49:16 +0200
Message-ID: <85odh3qp8j.fsf@lola.goethe.zz>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm>
	<87vebbo0f1.fsf@mid.deneb.enyo.de>
	<03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
	<85sl6fqr9n.fsf@lola.goethe.zz>
	<03bd01c7e295$976a2970$0600a8c0@ze4427wm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Aaron Gray" <angray@beeb.net>
X-From: git-owner@vger.kernel.org Sun Aug 19 21:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMqm6-0001fS-Px
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 21:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516AbXHSTtY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 15:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbXHSTtX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 15:49:23 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:39422 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502AbXHSTtX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Aug 2007 15:49:23 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 4B75D133F06;
	Sun, 19 Aug 2007 21:49:22 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 389AC345C1B;
	Sun, 19 Aug 2007 21:49:22 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-025-172.pools.arcor-ip.net [84.61.25.172])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 9F53C2C29E6;
	Sun, 19 Aug 2007 21:49:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8D4181C36605; Sun, 19 Aug 2007 21:49:18 +0200 (CEST)
In-Reply-To: <03bd01c7e295$976a2970$0600a8c0@ze4427wm> (Aaron Gray's message of "Sun\, 19 Aug 2007 20\:17\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3999/Sun Aug 19 18:24:49 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56143>

"Aaron Gray" <angray@beeb.net> writes:

>> "Aaron Gray" <angray@beeb.net> writes:
>>>
>>> Would the following do the trick ?
>>>
>>>    git add test.c
>>>    git commit
>>>
>>>    rename test.c test.cpp *
>>>    vi test.cpp
>>>
>>>    git rm test.c
>>>    git add test.cpp
>>>    git commit -M
>>>
>>> Many thanks in advance,
>>
>> There is no such thing as "git commit -M".  git does not keep track
>> of renames.  It generates the rename info on the fly when you ask
>> it for patches, log stats, blame annotations or similar.
>
> Could you elaborate maybe with a rough example for generating
> patches.

Uh, is that a trick question?

git-format-patch -M

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
