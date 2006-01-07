From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: Sat, 07 Jan 2006 02:29:46 -0800
Message-ID: <7vk6dcl49x.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
	<86wthd7ypx.fsf@blue.stonehenge.com>
	<20060107102820.GB5536@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:29:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBKY-0005Ex-AG
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAGK3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWAGK3s
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:29:48 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:18912 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932343AbWAGK3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 05:29:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107102749.YPCA26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 05:27:49 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060107102820.GB5536@steel.home> (Alex Riesen's message of
	"Sat, 7 Jan 2006 11:28:20 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14252>

Alex Riesen <raa.lkml@gmail.com> writes:

> Randal L. Schwartz, Fri, Jan 06, 2006 23:55:54 +0100:
>>
>>   print H "$_\0" for @deletedfiles;
>
> Does not work for old Perl

How old may I ask?
