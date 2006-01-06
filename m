From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: 06 Jan 2006 14:55:54 -0800
Message-ID: <86wthd7ypx.fsf@blue.stonehenge.com>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0VC-0002t3-SA
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWAFW4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWAFW4C
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:56:02 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:28711 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S965019AbWAFW4A
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 17:56:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A84648F3FF;
	Fri,  6 Jan 2006 14:55:55 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 31377-01-2; Fri,  6 Jan 2006 14:55:55 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 042348F3EF; Fri,  6 Jan 2006 14:55:55 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.16.19; tzolkin = 11 Cauac; haab = 17 Kankin
In-Reply-To: <7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14227>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> So I'd prefer not touching for (@df) { print H "$_\n" } loops.

Being as I'm a *bit* familiar with Perl, I'd write that as:

  print H "$_\0" for @deletedfiles;

if you want to write "for" as "foreach", I wouldn't complain either.
After all, that's spelled "f o r", but pronounced "foreach". :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
