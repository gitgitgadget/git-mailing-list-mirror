From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Mon, 05 Dec 2005 13:58:07 -0800
Message-ID: <7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<20051205215059.GC4443@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 23:00:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjOLd-0004YS-L8
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVLEV6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVLEV6K
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:58:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4052 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964825AbVLEV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 16:58:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205215727.KDOY20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 16:57:27 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051205215059.GC4443@steel.home> (Alex Riesen's message of
	"Mon, 5 Dec 2005 22:50:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13239>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Mon, Dec 05, 2005 21:22:42 +0100:
>> This attempts to clean up the way various compatibility
>> functions are defined and used.
> ...
>> --- a/compat/mmap.c
>> +++ b/compat/mmap.c
>> @@ -2,7 +2,7 @@
>>  #include <stdlib.h>
>>  #include <unistd.h>
>>  #include <errno.h>
>> -#include "../cache.h"
>> +#include "../git-compat-util.h"
>
> I still think that compat functions should stand alone.
> Especially if it does not costs us much (or even less than that).

Sorry, you lost me.  What do you mean by "standing alone"?
