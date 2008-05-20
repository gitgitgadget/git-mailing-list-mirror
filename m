From: "toby.allsopp \(toby.allsopp - NAVMAN\)" <toby.allsopp@navman.co.nz>
Subject: Re: [PATCH] Add a --dry-run option to git-svn rebase
Date: Tue, 20 May 2008 12:19:30 +1200
Message-ID: <87hcctygah.fsf@nav-akl-pcn-343.mitacad.com>
References: <3c20080519141036.GV396@ziti.local><1211206844-29842-1-git-send-email-seth@userprimary.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <normalperson@yhbt.net>
To: "Seth Falcon" <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Tue May 20 02:24:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyFeX-0000hn-FD
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 02:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341AbYETAXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 20:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYETAXj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 20:23:39 -0400
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:1907 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754068AbYETAXi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 20:23:38 -0400
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 May 2008 12:23:37 +1200
Received: from nav-akl-pcn-343.mitacad.com.navman.co.nz ([10.112.8.136]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 May 2008 12:23:36 +1200
In-Reply-To: <1211206844-29842-1-git-send-email-seth@userprimary.net> (SethFalcon's message of "Mon, 19 May 2008 07:20:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-OriginalArrivalTime: 20 May 2008 00:23:37.0078 (UTC) FILETIME=[BEF0B160:01C8BA0F]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.500.1026-15920.001
X-TM-AS-Result: No--9.294000-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82457>

[resending to correct Eric's email address]

On Tue, May 20 2008, Seth Falcon wrote:

[...]

> diff --git a/git-svn.perl b/git-svn.perl
> index 2c53f39..de52c12 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -176,6 +176,7 @@ my %cmd = (
>  			  'strategy|s=s' => \$_strategy,
>  			  'local|l' => \$_local,
>  			  'fetch-all|all' => \$_fetch_all,
> +                          'dryrun|n' => \$_dry_run,

s/dryrun/dry-run/ perhaps?  Also, it looks like you've used spaces
instead of tabs.

Toby.
