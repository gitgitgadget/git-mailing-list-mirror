From: Junio C Hamano <junkio@cox.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 20:55:01 -0700
Message-ID: <7v3bedll62.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	<46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 05:55:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FouZ2-0000hF-36
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 05:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWFJDzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 23:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWFJDzE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 23:55:04 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36534 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030237AbWFJDzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 23:55:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610035502.NSZN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 23:55:02 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
	(Martin Langhoff's message of "Sat, 10 Jun 2006 15:41:39 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21592>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Yes, most people have -z3, and I agree with you, on paper it sounds
> like the cost is 1/4 of a git clone.
>
> However.
>
> The CVS protocol is very chatty because the client _acts_ extremely
> stupid. It says, ok, I got here an empty directory, and the server
> walks the client through every little step. And all that chatter is
> uncompressed cleartext under pserver.
>
> So the per-file and per-directory overhead are significant. I can do a
> cvs checkout via pserver:localhost but I don't know off-the-cuff how
> to measure the traffic. Hints?

If you have an otherwise unused interface, you can look at
ifconfig output and see RX/TX bytes?  But that sounds very
crude.

Running it through a proxy perhaps?
