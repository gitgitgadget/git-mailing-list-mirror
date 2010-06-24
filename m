From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/4] msvc: Fix some "expr evaluates to function" compiler
 warnings
Date: Thu, 24 Jun 2010 12:01:07 +0200
Message-ID: <201006241201.08212.johan@herland.net>
References: <4C226323.5080709@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:01:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORjFH-0003Pb-5i
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab0FXKBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:01:13 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43237 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754526Ab0FXKBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:01:12 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4I00GFNJTXQ960@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Jun 2010 12:01:09 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 7875C1EA583D_C232CE5B	for <git@vger.kernel.org>; Thu,
 24 Jun 2010 10:01:09 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 512B51EA2F12_C232CE5F	for <git@vger.kernel.org>; Thu,
 24 Jun 2010 10:01:09 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4I0063AJTX7V00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 24 Jun 2010 12:01:09 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <4C226323.5080709@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149569>

On Wednesday 23 June 2010, Ramsay Jones wrote:
> In particular, the following warning is issued while compiling
> notes.c:
> 
>     notes.c(927) : warning C4550: expression evaluates to a \
> function which is missing an argument list
> 
> along with identical warnings on lines 928, 1016 and 1017.
> 
> In order to suppress the warning, we change the definition of
> combine_notes_fn, so that the symbol type is an (explicit)
> "pointer to function ...".  As a result, several other
> declarations need some minor fix-up to take account of the
> new typedef.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Acked-by: Johan Herland <johan@herland.net>


Thanks,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
