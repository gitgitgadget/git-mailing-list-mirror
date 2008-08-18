From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Enable diff=java for all *.java source files
Date: Mon, 18 Aug 2008 07:38:21 +0200
Message-ID: <200808180738.21572.robin.rosenberg.lists@dewire.com>
References: <1218814822-23307-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxUB-0005Hs-M6
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 07:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYHRFjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 01:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbYHRFjr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 01:39:47 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:43683 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbYHRFjq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 01:39:46 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 77F783A42C; Mon, 18 Aug 2008 07:39:44 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 33CB33A426; Mon, 18 Aug 2008 07:39:44 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 25BB937E46;
	Mon, 18 Aug 2008 07:39:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218814822-23307-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92680>

fredagen den 15 augusti 2008 17.40.22 skrev Shawn O. Pearce:
> This (usually) gets more reasonable function headers to
> appear in the header line for a diff hunk.  Its slightly
> better than the default C rules.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .gitattributes |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 .gitattributes
> 
> diff --git a/.gitattributes b/.gitattributes
> new file mode 100644
> index 0000000..f57840b
> --- /dev/null
> +++ b/.gitattributes
> @@ -0,0 +1 @@
> +*.java diff=java

Is there any reason this isn't the default in git?

-- robin
