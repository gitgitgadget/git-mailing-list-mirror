From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 11:57:20 -0500
Message-ID: <19174A63-BE44-4898-9CAD-935BE1A28FFF@sb.org>
References: <1210774947-27995-1-git-send-email-ian.hilt@gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Hilt <ian.hilt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 18:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKJ3-00056G-HN
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 18:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbYENQ5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 12:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYENQ5a
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 12:57:30 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:37362 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751895AbYENQ5a (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 12:57:30 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id 672A1195A42;
	Wed, 14 May 2008 09:57:29 -0700 (PDT)
In-Reply-To: <1210774947-27995-1-git-send-email-ian.hilt@gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82109>

Sorry for the double-posting, Ian, but my first email was rejected  
from the list because my mail client attached an HTML part.

On May 14, 2008, at 9:22 AM, Ian Hilt wrote:

> Made description more readable.
>
> Signed-off-by: Ian Hilt <ian.hilt@gmail.com>
> ---
> Documentation/git-describe.txt |    7 ++++---
> 1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git- 
> describe.txt
> index d9aa2f2..f3f07e4 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -13,9 +13,10 @@ SYNOPSIS
> DESCRIPTION
> -----------
> The command finds the most recent tag that is reachable from a
> -commit, and if the commit itself is pointed at by the tag, shows
> -the tag.  Otherwise, it suffixes the tag name with the number of
> -additional commits and the abbreviated object name of the commit.
> +commit.  If the tag points to the commit, then only the tag is
> +shown.  Otherwise, the number of additional commits on top of the
> +tagged object and the abbreviated object name of the most recent
> +commit are suffixed to the tag name.


I disagree that this is more readable. Specifically that last  
sentence. In the original description it tells me what it's doing  
(suffixing) before it tells me what objects it's using. In your  
version, it tells me the objects, then tells me what it's doing  
(suffixing), so I have to effectively process the sentence in reverse.  
In other words, it took me two readings of your last sentence to match  
the one reading of the original last sentence.

Also, you should use a more descriptive commit description. At the  
very least, do something like

git-describe: Make description more readable.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
