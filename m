From: Junio C Hamano <junkio@cox.net>
Subject: Re: compile problem with gcc 2.95
Date: Mon, 29 Aug 2005 12:10:48 -0700
Message-ID: <7vwtm4a79j.fsf@assigned-by-dhcp.cox.net>
References: <1125340116.26108.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 21:12:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9p1w-0001mc-PZ
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 21:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVH2TKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 15:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVH2TKu
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 15:10:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10628 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751457AbVH2TKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 15:10:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829191047.YMBW19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 15:10:47 -0400
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1125340116.26108.12.camel@localhost> (Dave Hansen's message of
	"Mon, 29 Aug 2005 11:28:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7921>

Dave Hansen <haveblue@us.ibm.com> writes:

> I know it's an ancient compiler, but last time I checked it is still
> faster at runtime than the 3.x versions.  If it's not going to be
> supported, it would probably be nice to at least detect that in the
> build system.  I've confirmed that it works just fine with gcc 3.3.
>
>> struct cache_entry {
> ...
>>         char name[]; <--- cache.h:107
>> };

Ah, my fault.  Let's undo that bit.
