From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Tue, 13 Sep 2005 12:46:54 -0700
Message-ID: <7vslw821jl.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
	<4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>
	<43272350.3060801@progeny.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org, cel@citi.umich.edu
X-From: git-owner@vger.kernel.org Tue Sep 13 21:49:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFGkA-00016P-75
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 21:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIMTq7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVIMTq7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 15:46:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9956 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932417AbVIMTq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 15:46:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913194655.IAVT3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 15:46:55 -0400
To: Tim Ottinger <tottinge@progeny.com>
In-Reply-To: <43272350.3060801@progeny.com> (Tim Ottinger's message of "Tue,
	13 Sep 2005 14:06:56 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8481>

Tim Ottinger <tottinge@progeny.com> writes:

> 2) However unimportant, I'm an old OO guy and object_cmd looks like 
> object.command to me.

If you are OO then would not object_method remind you of object->method ??

>> +  init_cc
>> +  next_cc, prev_cc
>
> cc_init?
> cc_next, cc_previous

Nah, either set is fine as long as it is internally consistent.
I tend to prefer "do-this-to-that" so init_cc and next_cc are
fine by me (just one person's opinion, not a dictator's ruling).
