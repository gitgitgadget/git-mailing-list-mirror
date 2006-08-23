From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: bugfix: a.list formatting regression
Date: Tue, 22 Aug 2006 22:23:09 -0700
Message-ID: <7vy7tghvpe.fsf@assigned-by-dhcp.cox.net>
References: <20060823044545.25836.qmail@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 23 07:23:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFlCt-0003f5-16
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 07:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWHWFXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 01:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWHWFXM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 01:23:12 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1482 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751376AbWHWFXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 01:23:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823052310.DFPV6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Aug 2006 01:23:10 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060823044545.25836.qmail@web31802.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 22 Aug 2006 21:45:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25896>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> The fix is to add "subject" class and use this class
>> to replace pre-format_subject_html formatting of subject
>> (comment) via using (or not) <b>...</b> element. This
>> should go back to the pre-17d0744318... style.
>> 
>> Regression noticed by Luben Tuikov.
>> 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
>> ---
>
> ACK. Looks good.
>
>     Luben

Thanks, both.
