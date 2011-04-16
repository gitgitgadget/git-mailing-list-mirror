From: Timo Schmiade <timo.schmiade@gmx.de>
Subject: Strange behaviour of --tags when adding remotes
Date: Sat, 16 Apr 2011 12:50:17 +0200
Message-ID: <20110416105017.GA2887@Discworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 12:50:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QB359-0007cx-4C
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 12:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294Ab1DPKuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 06:50:21 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:48848 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759154Ab1DPKuU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 06:50:20 -0400
Received: (qmail invoked by alias); 16 Apr 2011 10:50:17 -0000
Received: from dslb-084-060-105-052.pools.arcor-ip.net (EHLO localhost) [84.60.105.52]
  by mail.gmx.net (mp006) with SMTP; 16 Apr 2011 12:50:17 +0200
X-Authenticated: #18738959
X-Provags-ID: V01U2FsdGVkX1+VVEtNHJKVWCDyqen7gKCZzhylXT/Bp9kt5nBPqI
	VXtHvtO0zxEEEK
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171669>

Hi all,

I just stumbled upon what I think is a bit of a strange behaviour when
using "git remote add" with the --tags option. The remote I added was
fetch'able after the command (it was added to .git/config), but there
was no remote tracking branch set up for it (i.e. the
.git/refs/remotes/<shortname> directory didn't exist).

Only after removing the "tagopt = --tags" option from .git/config was it
that "git fetch <shortname>" created a remote tracking branch for the
remote.

After double-checking the "man git-fetch", I still think this behaviour
is quite confusing, so I wanted to inform you about this.

Kind regards,

Timo
