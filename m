From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Change GitResourceDecorator to use isAccessible
Date: Fri, 29 Aug 2008 11:01:06 +0200
Message-ID: <200808291101.06253.robin.rosenberg.lists@dewire.com>
References: <1219968506-30437-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 11:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzu0-0005ee-CY
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 11:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbYH2JDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 05:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbYH2JDQ
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 05:03:16 -0400
Received: from av9-2-sn2.hy.skanova.net ([81.228.8.180]:47996 "EHLO
	av9-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbYH2JDP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 05:03:15 -0400
Received: by av9-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id B03BE381D7; Fri, 29 Aug 2008 11:03:13 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av9-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 910E637EC6; Fri, 29 Aug 2008 11:03:13 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 79DAA37E46;
	Fri, 29 Aug 2008 11:03:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219968506-30437-1-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fredagen den 29 augusti 2008 02.08.26 skrev Shawn O. Pearce:
> f3a6ac20 says it switched to use isAccessible() here but it
> changed to exists().  We can only use setSessionProperty if
> the resource is accessible so we must use the correct test
> here in order to fix the issue reported by Robert.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  I just pushed this out to master since you clearly meant
>  for this to be the case.  :-|

Thanks. I had a fix, but noticed the attribution was wrong so I fixed
the patch again and forgot the fix.

-- robin
