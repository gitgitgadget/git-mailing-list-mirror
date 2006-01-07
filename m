From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-mv.perl: use stderr for error output and cleanup
Date: 07 Jan 2006 02:34:23 -0800
Message-ID: <86sls0498w.fsf@blue.stonehenge.com>
References: <81b0412b0601050349s6bec1a36jc410fd315fbbc4c@mail.gmail.com>
	<7vek3lq8wu.fsf@assigned-by-dhcp.cox.net>
	<86wthd7ypx.fsf@blue.stonehenge.com>
	<20060107102820.GB5536@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 11:34:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBP1-0005rw-EF
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWAGKeZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWAGKeZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:34:25 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:22842 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030401AbWAGKeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 05:34:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3BD1C8F2D2;
	Sat,  7 Jan 2006 02:34:24 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 20571-01-9; Sat,  7 Jan 2006 02:34:23 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B582E8F2D7; Sat,  7 Jan 2006 02:34:23 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
x-mayan-date: Long count = 12.19.12.17.0; tzolkin = 12 Ahau; haab = 18 Kankin
In-Reply-To: <20060107102820.GB5536@steel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14255>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Randal L. Schwartz, Fri, Jan 06, 2006 23:55:54 +0100:
>> >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>> 
Junio> So I'd prefer not touching for (@df) { print H "$_\n" } loops.
>> 
>> Being as I'm a *bit* familiar with Perl, I'd write that as:
>> 
>> print H "$_\0" for @deletedfiles;
>> 

Alex> Does not work for old Perl

Correct.  It was added for Perl 5.5, first released on 22 July 1998.

Are you really saying you need this code to run on Perl 5.4?  There
are a number of other things that would have to be fixed as well.
(We had this conversation a while back.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
