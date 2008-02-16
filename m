From: =?UTF-8?B?TmFneSBCYWzDoXpz?= <js@iksz.hu>
Subject: Re: [PATCH] Correct git-pull documentation
Date: Sat, 16 Feb 2008 09:20:43 +0100
Message-ID: <47B69CDB.7070908@iksz.hu>
References: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:20:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQIHc-0004FR-9s
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbYBPITk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbYBPITk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:19:40 -0500
Received: from smtp.aranyoroszlan.hu ([195.56.77.57]:64477 "EHLO
	smtp.aranyoroszlan.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYBPITj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 03:19:39 -0500
Received: (qmail 38868 invoked by uid 263); 16 Feb 2008 08:29:02 -0000
Received: from 213.178.103.79 (js@iksz.hu@213.178.103.79) by tcb.aranyoroszlan.hu (envelope-from <js@iksz.hu>, uid 256) with qmail-scanner-2.02st 
 (clamdscan: 0.92/5779. spamassassin: 3.2.4. perlscan: 2.02st.  
 Clear:RC:0(213.178.103.79):SA:0(-1.9/5.0):. 
 Processed in 2.214876 secs); 16 Feb 2008 08:29:02 -0000
X-Spam-Status: No, hits=-1.9 required=5.0
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on tcb.aranyoroszlan.hu
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RDNS_NONE autolearn=no version=3.2.4
X-Envelope-From: js@iksz.hu
Received: from unknown (HELO ?192.168.1.100?) (js@iksz.hu@213.178.103.79)
  by tcb.aranyoroszlan.hu with SMTP; 16 Feb 2008 08:28:59 -0000
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <1203137441-52448-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74029>

Jay Soffian wrote:
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 179bdfc..f734f18 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
>   
...
> @@ -28,17 +29,12 @@ include::merge-options.txt[]
>  :git-pull: 1
>  include::fetch-options.txt[]
>  
> -include::pull-fetch-param.txt[]
> -
> -include::urls-remotes.txt[]
> -
> -include::merge-strategies.txt[]
> -
>  \--rebase::
>  	Instead of a merge, perform a rebase after fetching.  If
>  	there is a remote ref for the upstream branch, and this branch
>  	was rebased since last fetched, the rebase uses that information
> -	to avoid rebasing non-local changes.
> +	to avoid rebasing non-local changes. This if the default if
>   
... This *is* the default if
> +	`branch.<name>.rebase` is set.
>  +
>  *NOTE:* This is a potentially _dangerous_ mode of operation.
>  It rewrites history, which does not bode well when you
>   
-- 
-jul-
