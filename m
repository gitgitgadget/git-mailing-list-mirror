From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Pointers to setup an internal git repository with access
 control
Date: Tue, 30 Aug 2011 16:59:37 +0400
Message-ID: <20110830165937.188baae9.kostix@domain007.com>
References: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
	<20110830162223.1cbf9f98.kostix@domain007.com>
	<CAAZ43xYhFQzBVmjfnvRoboNPQ1OLtyq57=0ZL3B6p+dRWnJZ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:59:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNv0-0006Rk-WB
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab1H3M7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 08:59:50 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60331 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab1H3M7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 08:59:50 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id p7UCxbng001115;
	Tue, 30 Aug 2011 16:59:38 +0400
In-Reply-To: <CAAZ43xYhFQzBVmjfnvRoboNPQ1OLtyq57=0ZL3B6p+dRWnJZ-g@mail.gmail.com>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180409>

On Tue, 30 Aug 2011 08:35:22 -0400
robert mena <robert.mena@gmail.com> wrote:

[...]
> I don't have to use https+dav, it can be ssh as long as it is
> encrypted and I have some sort of access control.  The branches item
> is to be able to control who can merge/commit things back to, for
> example, the trunk or whatever I call the "live" branch.
> 
> This way the devs can do what they want but the final merge to the
> "live" branch would be done after the Q&A approves.
Go for gitolite then.
