From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] git-cvsserver: fix duplicate words
Date: Fri, 6 May 2016 09:59:55 -0400
Message-ID: <572CA35B.80807@xiplink.com>
References: <1462536570-17199-1-git-send-email-lip@dtdream.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mmogilvi_git@miniinfo.net
To: Li Peng <lip@dtdream.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 16:07:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aygPt-0002C6-5B
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758141AbcEFOHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 10:07:37 -0400
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:55925 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757430AbcEFOHh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 10:07:37 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 May 2016 10:07:36 EDT
Received: from smtp1.relay.ord1c.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp1.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 8A89A3805D8;
	Fri,  6 May 2016 09:59:56 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp1.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D40F2380601;
	Fri,  6 May 2016 09:59:55 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 06 May 2016 09:59:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <1462536570-17199-1-git-send-email-lip@dtdream.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293782>

On 2016-05-06 08:09 AM, Li Peng wrote:
> Fix duplicate words in comments.
>
> Signed-off-by: Li Peng <lip@dtdream.com>
> ---
>   git-cvsserver.perl | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 02c0445..392e59e 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1156,7 +1156,7 @@ sub prepDirForOutput
>       # FUTURE: This would more accurately emulate CVS by sending
>       #   another copy of sticky after processing the files in that
>       #   directory.  Or intermediate: perhaps send all sticky's for
> -    #   $seendirs after after processing all files.
> +    #   $seendirs after processing all files.
>   }
>
>   # update \n
> @@ -2824,7 +2824,7 @@ sub statecleanup
>   }
>
>   # Return working directory CVS revision "1.X" out
> -# of the the working directory "entries" state, for the given filename.
> +# of the working directory "entries" state, for the given filename.
>   # This is prefixed with a dash if the file is scheduled for removal
>   # when it is committed.
>   sub revparse
> @@ -2935,7 +2935,7 @@ sub filecleanup
>       return $filename;
>   }
>
> -# Remove prependdir from the path, so that is is relative to the directory
> +# Remove prependdir from the path, so that is relative to the directory

This one is a typo -- it should be "it is".

Did you write a script to find these?  :)

(Also, I agree with Jeff that putting all of these changes into one 
patch would have been fine.)

		M.
