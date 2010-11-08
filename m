From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git as a backup system?
Date: Mon, 8 Nov 2010 21:26:12 +0300
Message-ID: <20101108212612.bb4bfeb8.kostix@domain007.com>
References: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 19:26:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFWQA-00021r-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 19:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab0KHS0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 13:26:17 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:45095 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039Ab0KHS0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 13:26:16 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id oA8IQCAB021152;
	Mon, 8 Nov 2010 21:26:13 +0300
In-Reply-To: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
X-Mailer: Sylpheed 3.0.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160964>

On Mon, 8 Nov 2010 13:01:29 -0500
Eric Frederich <eric.frederich@gmail.com> wrote:

> I maintain a corporate MediaWiki installation.
> Currently I have a cron job that runs daily and tar's up the contents
> of the installation directory and runs a mysqldump.
> I keep backups of the past 45 days.
> Each backup is about 200M, so all in all I always have about 9.0G of
> backups. Most of the changes are in the database, so the mysqldump
> file is changed every day.
> Other than that, there can be new files uploaded but they never
> change, just get added.
> All configuration files stay the same.
[...]
> Am I insane?  Are there other tools more suited toward this?
> I just thought of using Git since I looked at my 9G worth of data out
> there in my backup directory that is almost exactly the same and said
> "git could handle this well".
> 
> Are any of you using git for a backup system?  Have any tips, words
> of wisdom?
I suspect the rdiff-backup tool [1] was invented precisely for the setup
like yours: it is able to sync one directory to another + create diffs
between them thus providing for incremental backups.

1. http://www.nongnu.org/rdiff-backup/
