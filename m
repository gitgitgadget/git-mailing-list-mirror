From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Print Precedes/Follows in git log
Date: Tue, 15 Jan 2008 00:34:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801150031480.2315@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 00:35:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEYpr-0003oY-Qg
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYANXeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbYANXeq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:34:46 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:50988 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbYANXeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:34:46 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 1FC2518031632; Tue, 15 Jan 2008 00:34:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 164051C00E290
	for <git@vger.kernel.org>; Tue, 15 Jan 2008 00:34:45 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70488>

Hi,


gitk has a nice feature in that, when a commit is selected, it prints in 
the log window something like:

(id 1beeffe43311f64df8dd0ab08ff6b1858c58363f)

Author: Tony Jones <tonyj@suse.de>  2007-08-20 22:46:20
Committer: Mark M. Hoffman <mhoffman@lightlink.com>  2007-10-10 04:56:30
Parent: 8afb10490b18e916e33707baa7d1cfc615d545ea (hwmon: (f71882fg) trivial whitespace cleanup)
Branches: ...
Follows: v2.6.23
Precedes: v2.6.24-rc1

And it would be really nice if `git log` would also show the 
Precedes/Follows lines so one can identify much more easily in
big logs like those of the Linux kernel what the next release to
have a given patch is.


thanks,
Jan
