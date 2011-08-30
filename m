From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Pointers to setup an internal git repository with access
 control
Date: Tue, 30 Aug 2011 16:22:23 +0400
Message-ID: <20110830162223.1cbf9f98.kostix@domain007.com>
References: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 14:38:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyNa6-0005je-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 14:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1H3MiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 08:38:14 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41661 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658Ab1H3MiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 08:38:14 -0400
X-Greylist: delayed 945 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Aug 2011 08:38:13 EDT
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id p7UCMNdO029175;
	Tue, 30 Aug 2011 16:22:24 +0400
In-Reply-To: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180407>

On Tue, 30 Aug 2011 08:01:44 -0400
robert mena <robert.mena@gmail.com> wrote:

> I am trying to migrate from SVN to git and so I am looking for tools
> that help me create an interal repository.  I currently use SVN over
> HTTPS/Dav using the access.conf to be able to control which uses can
> read/write to the repos or given branches.
> 
> Ideally I am looking for tools that enable me to do the same with git.
Possibly look at smart http protocol [1], [2].

I may be wrong, but this access method cannot be used to implemet
access control with branch-level granularity.  If you really need this,
use gitolite [3].

1. http://progit.org/2010/03/04/smart-http.html
2. http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
3. https://github.com/sitaramc/gitolite
