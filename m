From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] config doc: improve exit code listing
Date: Tue, 26 Apr 2016 20:11:14 +0100
Message-ID: <571FBD52.4040206@ramsayjones.plus.com>
References: <20160426181058.7901-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: john@keeping.me.uk, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 26 21:11:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av8OL-0006Yo-EI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbcDZTLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 15:11:21 -0400
Received: from avasout07.plus.net ([84.93.230.235]:54276 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbcDZTLU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 15:11:20 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id n7BH1s0062D2Veb017BJRW; Tue, 26 Apr 2016 20:11:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=1XWaLZrsAAAA:8 a=Ckq2gQmuiSninn3YF6gA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160426181058.7901-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292649>



On 26/04/16 19:10, Stefan Beller wrote:
> The possible reasons for exiting are now ordered by the exit code value.
> While at it, rewrite the `can not write to the config file` to
> `the config file cannot be written` to be grammatically correct and a
> proper sentence.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-config.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 6fc08e3..6843114 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -58,10 +58,10 @@ that location (you can say '--local' but that is the default).
>  This command will fail with non-zero status upon error.  Some exit
>  codes are:
>  
> -- The config file is invalid (ret=3),
     ^
I don't see why this is capitalised, so ...

> -- can not write to the config file (ret=4),
> +- The section or key is invalid (ret=1),
     ^
I don't think you should transfer the capital here. ;-)

>  - no section or name was provided (ret=2),
> -- the section or key is invalid (ret=1),
> +- the config file is invalid (ret=3),
> +- the config file cannot be written (ret=4),
>  - you try to unset an option which does not exist (ret=5),
>  - you try to unset/set an option for which multiple lines match (ret=5), or
>  - you try to use an invalid regexp (ret=6).
> 

Only a minor point.

ATB,
Ramsay Jones
