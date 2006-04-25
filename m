From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1(): :path and :[0-3]:path to extract from index.
Date: Tue, 25 Apr 2006 01:46:21 -0700
Message-ID: <7vr73myrdu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
	<7v7j5iph7f.fsf@assigned-by-dhcp.cox.net>
	<20060425083724.GA1663@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 10:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJBj-0007Ag-8T
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 10:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWDYIqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 04:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWDYIqY
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 04:46:24 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:24818 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751464AbWDYIqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 04:46:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060425084622.LEON25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Apr 2006 04:46:22 -0400
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060425083724.GA1663@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Tue, 25 Apr 2006 10:37:24 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19139>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

>> This is a fairly straightforward patch to allow "get_sha1()" to
>> also have shorthands for blob objects in the current index.
>
> I sometimes want to have something like that:
>
> 	uzeisberger@io:~/gsrc/linux-2.6$ git cat-file blob v2.6.16:Makefile
>
> That is not a shortcut for objects in the current index, but for blobs
> in written trees.

That's already present in the "master".  You are responding to a
wrong message ;-).
