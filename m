From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 01:17:46 -0400 (EDT)
Message-ID: <53717.10.10.10.28.1127107066.squirrel@linux1>
References: <432E1F28.9060909@bigpond.net.au>
    <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 07:18:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHE2N-000448-86
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 07:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVISFRw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 01:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVISFRw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 01:17:52 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:27847 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932308AbVISFRw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 01:17:52 -0400
Received: from linux1.attic.local ([67.71.125.52])
          by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050919051747.HDXD11463.simmts6-srv.bellnexxia.net@linux1.attic.local>;
          Mon, 19 Sep 2005 01:17:47 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1.attic.local (8.12.11/8.12.11) with ESMTP id j8J5HhAm007549;
	Mon, 19 Sep 2005 01:17:44 -0400
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 19 Sep 2005 01:17:46 -0400 (EDT)
In-Reply-To: <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
To: "Peter Williams" <pwil3058@bigpond.net.au>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8836>

On Mon, September 19, 2005 12:46 am, Junio C Hamano said:
> Peter Williams <pwil3058@bigpond.net.au> writes:
>
>> So I installed String::ShellQuote from CPAN and tried again with the
>> same result.  So I then rebuilt the rpm on my system and still got the
>> same error message.  So I've installed the rpm using the --nodeps option
>> but would like to test whether it is successfully finding
>> String::ShellQuote.  Which command(s) would exercise this perl package?
>
> $ git grep ShellQuote
> git-archimport.perl:42:use String::ShellQuote;


Peter,

You need to install ShellQuote with rpm rather than installing it directly
from CPAN.  You can pick up a rpm version of ShellQuote from several
places, here's one:  http://tinyurl.com/7p7ey

Cheers,
Sean
