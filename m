From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: no "uname -o" on Mac OSX
Date: 09 Oct 2005 12:31:08 -0700
Message-ID: <864q7qlc77.fsf@blue.stonehenge.com>
References: <86k6gnm0sz.fsf@blue.stonehenge.com>
	<7voe5yebjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 21:33:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOgtE-0004XO-Oh
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 21:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVJITbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 15:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJITbS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 15:31:18 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:19269 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932260AbVJITbR
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2005 15:31:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 83D568F69B;
	Sun,  9 Oct 2005 12:31:09 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24326-01-24; Sun,  9 Oct 2005 12:31:09 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 24D2B8F6DC; Sun,  9 Oct 2005 12:31:09 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.12.10; tzolkin = 13 Oc; haab = 8 Yax
In-Reply-To: <7voe5yebjv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9869>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Peter, I noticed the same on Solaris recently.

Junio> The following seems to work but is quite yucky, and I prefer
Junio> somebody to come up with a better alternative.

How about a chain of elsif's?

Doesn't make support that?

I mean, when you know it's Darwin, no point in checking if it's OpenBSD. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
