From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects by proxy servers
Date: Wed, 14 Sep 2005 09:28:16 -0700
Message-ID: <7vu0gnobq7.fsf@assigned-by-dhcp.cox.net>
References: <20050913153858.GB24405@master.mivlgu.local>
	<7vfys93qn5.fsf@assigned-by-dhcp.cox.net>
	<20050914131236.GH24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 18:30:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFa7k-00022g-F3
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbVINQ2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVINQ2S
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:28:18 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10659 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030246AbVINQ2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 12:28:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914162817.UGXO9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 12:28:17 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20050914131236.GH24405@master.mivlgu.local> (Sergey Vlasov's
	message of "Wed, 14 Sep 2005 17:12:36 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8537>

Sergey Vlasov <vsu@altlinux.ru> writes:

>> Do you know if we can use it for any reasonably recent version
>> of curl?  I seem to recall we already do things slightly
>> differently depending on LIBCURL_VERSION_NUM.
>
> http://cool.haxx.se/cvs.cgi/curl/include/curl/curl.h?rev=1.1&content-type=text/vnd.viewcvs-markup
> shows...

Cool.  I'll not worry about version dependency for this one,
then.

Thanks for the pointer -- I really appreciate it when people
teach others how to find out what was asked themselves next
time need arises.
