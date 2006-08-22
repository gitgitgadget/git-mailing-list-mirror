From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Tue, 22 Aug 2006 16:14:58 -0700
Message-ID: <7vy7tgl5vx.fsf@assigned-by-dhcp.cox.net>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
	<11562409683011-git-send-email-jnareb@git.vger.kernel.org>
	<7vr6z8mmb7.fsf@assigned-by-dhcp.cox.net> <ecg1fd$3uj$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 01:15:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFfSb-0000T1-Kq
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 01:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWHVXPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 19:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHVXPA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 19:15:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37596 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932130AbWHVXPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 19:15:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822231459.NQHS21457.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 19:14:59 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ecg1fd$3uj$2@sea.gmane.org> (Jakub Narebski's message of "Wed,
	23 Aug 2006 00:46:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25882>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> It might be worthwhile to do a full sweep of the pages we
>> generate and identify what classes we would want.  I have a
>> feeling that we overuse a.list for example -- they are all in
>> some form of list alright but they might benefit from a bit
>> finer logical separatoin.  One list is enumaration of refs and
>> another is a chronological sequence of commits.
>> 
>> Then people who would want to tweak the presentation would have
>> an easier time changing only gitweb.css.
>
> Next patch in this series of patches 
>    [PATCH] gitweb: Replace some presentational HTML by CSS
>    Message-Id: <11562431392439-git-send-email-jnareb@git.vger.kernel.org>
> adds "name" subclass (a.list.name) for ref names. (I think
> subclasses/multiple classes is the way to do it, as all a.list
> elements have something in common: use next class to divide).

I agree about the implementation aspect, such as using
"list.name" as class names; I was suggesting to start from
design.
