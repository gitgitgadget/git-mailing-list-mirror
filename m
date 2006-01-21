From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remove "historical" objects from repository to save place
Date: Sat, 21 Jan 2006 12:25:57 -0800
Message-ID: <7virsdl44q.fsf@assigned-by-dhcp.cox.net>
References: <200601212218.51055.arvidjaar@mail.ru>
	<7v1wz1mjy8.fsf@assigned-by-dhcp.cox.net>
	<20060121200615.GM28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 21 21:26:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0PJB-0006Gf-Vx
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:26:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAUUZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAUUZ7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:25:59 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58292 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932318AbWAUUZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 15:25:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121202355.DFRB17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 15:23:55 -0500
To: git@vger.kernel.org
In-Reply-To: <20060121200615.GM28365@pasky.or.cz> (Petr Baudis's message of
	"Sat, 21 Jan 2006 21:06:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15017>

Petr Baudis <pasky@suse.cz> writes:

>> You might be able to cauterize the history at a specific commit
>> and then re-clone.  I've talked about how in "[QUESTION] about
>> .git/info/grafts file" thread yesterday, so I won't repeat that.
>
> Shouldn't the git-prune be sufficient after cauterizing the history?

Logically yes, but practically no.

Most likely what the original requestor cloned from Linus has
been already packed so git-prune would not do much.
