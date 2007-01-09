From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Tue, 9 Jan 2007 18:25:13 +0100
Message-ID: <81b0412b0701090925p158e87an14da5cde33436f30@mail.gmail.com>
References: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jan 09 18:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Kiw-0005C5-Lv
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 18:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbXAIRZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 12:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbXAIRZQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 12:25:16 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:31074 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272AbXAIRZP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 12:25:15 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1640351wri
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 09:25:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PhPangt5fV3DFzBmQnrM6jUuGlDCmrOYOZbYahreg2hGGInW7Fivoi4yh/YL8jy24ZbLiel+tFNR4UL2FCcrLCMUcR5Pv7meO9VvGyXy/p3xAKTN+FabGwUXw64LRKgibtmnTCVZMiUW9BHXftJC9nruL96IbwJ91V0KuzAfH0M=
Received: by 10.78.149.15 with SMTP id w15mr5953433hud.1168363513947;
        Tue, 09 Jan 2007 09:25:13 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 9 Jan 2007 09:25:13 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701091502030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36378>

On 1/9/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 	'tis a resend of an earlier patch, but without support for the
> 	bogus ":." as equivalent to ":/".

Thanks :)

> 	I find this feature highly convenient when I just want to see
> 	what files the index contains.

I find it very useful too.
