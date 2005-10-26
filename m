From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 13:12:40 -0700
Message-ID: <86ll0gavgn.fsf@blue.stonehenge.com>
References: <200510261722.j9QHMLGY006576@laptop11.inf.utfsm.cl>
	<86mzkwdsef.fsf@blue.stonehenge.com>
	<7vr7a8ca8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 22:16:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUrdd-0004p0-Nt
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 22:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVJZUMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 16:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUMm
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 16:12:42 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:37276 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964915AbVJZUMl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 16:12:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 6DCB28F3EF;
	Wed, 26 Oct 2005 13:12:41 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22652-01-10; Wed, 26 Oct 2005 13:12:41 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0D0938F711; Wed, 26 Oct 2005 13:12:41 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
In-Reply-To: <7vr7a8ca8j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10691>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> I swallowed Linus version.  Thanks for reporting (and also ctype
Junio> fix the other day).

I apologize that I don't immediately post the patch, but generally
I figure that maybe Smarter People Than Me might recognize the issue
before I can get around to figuring out what broke.

After all, my C is rusty.  My Perl is much better. :)

Also, I'm learning how git works, to generate diffs and patches, etc.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
