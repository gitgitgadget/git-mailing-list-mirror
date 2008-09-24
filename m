From: Heiko Voigt <heiko.voigt@mahr.de>
Subject: Re: Partial tree export and merging
Date: Wed, 24 Sep 2008 17:05:27 +0200
Message-ID: <48DA5737.4030909@mahr.de>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan> <48D9FACB.20901@mahr.de> <48DA476F.1070700@mahr.de> <20080924143945.GN3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@mahr.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:12:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVwr-0006NT-Vb
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbYIXPFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYIXPFW
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:05:22 -0400
Received: from mail.mahr-austria.at ([193.158.246.156]:16531 "EHLO
	mail.mahr.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751280AbYIXPFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:05:21 -0400
Received: from [172.20.12.218] ([172.20.12.218]) by mail.mahr.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 Sep 2008 17:05:19 +0200
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080924143945.GN3669@spearce.org>
X-OriginalArrivalTime: 24 Sep 2008 15:05:19.0648 (UTC) FILETIME=[F5CA8200:01C91E56]
X-TM-AS-Product-Ver: SMEX-8.0.0.1259-5.500.1027-16176.006
X-TM-AS-Result: No--10.682600-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96644>

Shawn O. Pearce schrieb:
> Once the history is split into a new "doc+html" repository have
> developers _only_ edit the docs/html in the doc+html repository,
> don't make more edits in the source code repository.

The problem with committing into 2 repositories (only merging from one 
side) is that the docs/html also contain localization files which make 
it hard to work/test the code because localization strings are initially 
added by the developers. They would then have to change in the 2nd repo 
and pull for testing.

> You can use git-submodule or git-merge with the subtree strategy
> to pull changes from the doc+html repository into the main source
> repository.

Would git submodule work with this kind of layout? Same folders 
containing different files. I thought submodules only work with 
subdirectories which are itself a git repo.

cheers Heiko
