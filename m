From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Introduce git-supported-features for porcelain use
Date: Wed, 30 May 2007 14:04:06 +0200
Message-ID: <81b0412b0705300504h24c4c32ew8460dede4aeffd52@mail.gmail.com>
References: <20070530043113.GA12300@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 14:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtMun-00063S-Ld
	for gcvg-git@gmane.org; Wed, 30 May 2007 14:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXE3MEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 08:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbXE3MEK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 08:04:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:5792 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbXE3MEI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 08:04:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so169234ugf
        for <git@vger.kernel.org>; Wed, 30 May 2007 05:04:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y31kvI6n+F5g0LpgMD/5n/VgPq9YhMhKzDvpbMBwZGFtTFq4AJvbrkvp7CiIHxxCYPuiO+9BNwwcDN0DCUd5R7Tf+XyuOIrWj6fcaqGGS9kBEgUGp89VK/F9wSemttT68PIUxYK+Qt/NNDtN2ajElsI7QkN04Eay/AXIFaJ1Jgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jfNFEW6rwsAZd2XgvJM/oK9o8/m61vIDLxra/eBnDUUeMkf6G9IXJFd3YQgpflmrPNsLO1DDH9WUMIoEzTiKiqh3Xn6FtrJQDlxzCqIbTboM1S1RjOvzVq2NdcuLmHX+lkR+sgttwRHqQBVDN6Hsr8MC5oGK+ONpS+pnDBYQ3Ag=
Received: by 10.78.123.4 with SMTP id v4mr2229145huc.1180526646869;
        Wed, 30 May 2007 05:04:06 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 30 May 2007 05:04:06 -0700 (PDT)
In-Reply-To: <20070530043113.GA12300@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48754>

On 5/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> As a porcelain author I'm finding it difficult to keep track of
> what features I can use in git-gui.  Newer versions of Git have
> newer capabilities but they don't always immediately get newer
> version numbers that I can easily test for.

git-version --features?
