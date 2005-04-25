From: Geert Bosch <bosch@adacore.com>
Subject: Re: mod-times (was: keyword expansion)
Date: Mon, 25 Apr 2005 14:13:43 -0400
Message-ID: <3741014dfd79fce50999dc19d7029c40@adacore.com>
References: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 20:09:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ80e-0005PJ-H4
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 20:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVDYSNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 14:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVDYSNo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 14:13:44 -0400
Received: from nile.gnat.com ([205.232.38.5]:50927 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S262698AbVDYSNn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 14:13:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP
	id 6F65A961A; Mon, 25 Apr 2005 14:13:42 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20768-01-6; Mon, 25 Apr 2005 14:13:42 -0400 (EDT)
Received: from [205.232.38.235] (dhcp13.gnat.com [205.232.38.235])
	by nile.gnat.com (Postfix) with ESMTP
	id 383459616; Mon, 25 Apr 2005 14:13:42 -0400 (EDT)
In-Reply-To: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
To: tony.luck@intel.com
X-Mailer: Apple Mail (2.622)
X-Virus-Scanned: by amavisd-new at nile.gnat.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Apr 25, 2005, at 13:56, tony.luck@intel.com wrote:
>> 	- Time stamp of the last modification of a file
>
> One way to do this would be to rip on some of the core fundamentals of 
> GIT
> and store the time that an object was created inside the object. E.g.
>
>    blob size secs-since-1970 ...
>
> Then "read-tree" could fill this into the cache, and checkout-cache 
> could
> set the mod-time on the file when it creates it, which would mean that 
> you
> could see the timestamp for a file simply by using "ls -l file".

Of course this negates the idea of content-based storage, since you
want two copies of the same content with different time-stamps to share
the same blob.

   -Geert

