From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tip of the day: archaeology
Date: Tue, 13 Dec 2005 14:19:39 -0800
Message-ID: <7vbqzk7i84.fsf@assigned-by-dhcp.cox.net>
References: <20051209215414.14072.qmail@science.horizon.com>
	<7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
	<20051212195319.11d41269.tihirvon@gmail.com>
	<Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
	<86y82qyrqs.fsf@blue.stonehenge.com>
	<20051213035842.GF10371@always.joy.eth.net>
	<86d5k1y7dp.fsf@blue.stonehenge.com>
	<7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
	<7vd5k1bf40.fsf@assigned-by-dhcp.cox.net>
	<861x0hxfn2.fsf@blue.stonehenge.com>
	<7vpso07l63.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512131351100.4184@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 23:19:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIUr-0003jG-5s
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbVLMWTm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVLMWTm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:19:42 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62888 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030271AbVLMWTl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 17:19:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213221901.YUXK15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 17:19:01 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512131351100.4184@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 13 Dec 2005 13:54:44 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13592>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 13 Dec 2005, Junio C Hamano wrote:
>> 
>> *1* Sometimes I wish we had "cvs co -p" equivalent.
>> 
>> 	$ git cat-blob rev path
>> 
>> Perhaps?
>
> Isn't "git-ls-tree rev path" good enough? Maybe you want to wrap it with
>
> 	#!/bin/sh
> 	git-ls-tree "$@" |
> 		while read mode type sha name
> 		do
> 			git-cat-file $type $sha
> 		done
>
> or something? 

Exactly.  The point was that we do not ship a prepackaged script
like that.
