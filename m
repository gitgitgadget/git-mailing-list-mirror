From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 0/3] "git notes remove" updates
Date: Thu, 19 May 2011 09:08:18 +0200
Message-ID: <201105190908.19080.johan@herland.net>
References: <1305764061-21303-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 09:08:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMxLQ-0004kH-RX
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 09:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab1ESHIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 03:08:23 -0400
Received: from smtp.getmail.no ([84.208.15.66]:33555 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754979Ab1ESHIW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 03:08:22 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLF008HTL5WNR40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 19 May 2011 09:08:20 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 53C101EEF069_DD4C1E4B	for <git@vger.kernel.org>; Thu,
 19 May 2011 07:08:20 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 23FFE1EEF000_DD4C1E4F	for <git@vger.kernel.org>; Thu,
 19 May 2011 07:08:20 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLF00L95L5WBV30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Thu, 19 May 2011 09:08:20 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1305764061-21303-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173942>

On Thursday 19 May 2011, Junio C Hamano wrote:
> I wanted to do a bit better than
> 
> 	for sha1 in ... list of old commit objects
> 	do
> 		git notes --ref refs/notes/amlog remove $sha1
> 	done
> 
> to remove old entries in my "where did this commit come from" database.
> 
> Junio C Hamano (3):
>   notes remove: allow removing more than one
>   notes remove: --missing-ok
>   notes remove: --stdin reads from the standard input


After a cursory reading the series looks good to me. Thanks! :)


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
