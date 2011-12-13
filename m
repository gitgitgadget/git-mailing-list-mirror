From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] test-terminal: set output terminals to raw mode
Date: Mon, 12 Dec 2011 23:09:35 -0600
Message-ID: <20111213050935.GA32215@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <04a77f48dd5d5afebbe625ed25ebecd57b6a8840.1323713230.git.trast@student.ethz.ch>
 <20111212182318.GE31793@elie.hsd1.il.comcast.net>
 <201112122001.36303.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 13 06:10:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaKcr-0003H9-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 06:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840Ab1LMFJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 00:09:47 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57388 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab1LMFJq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 00:09:46 -0500
Received: by yenm11 with SMTP id m11so4488513yen.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 21:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EsqRrrFhXxvC9F8XANFsxK+Q4IfK2/mV5wW3V1wNMa4=;
        b=rqAh1aaZ888Apojal3lzJ3XeoO798CrEscny4eTZvlIPWQgDM7FqU3h7XzE8zdchz6
         1TXhCgGT8Td+qZ4WdE7x0uQD3zw2mbbdzvqeryBO5Yg6NvfWq8vuyU49AOjSOf5DJMHD
         xobVzoJug6jkmet4gnM+4yo0TdGuqvXdCj+7U=
Received: by 10.236.181.164 with SMTP id l24mr1478217yhm.22.1323752986092;
        Mon, 12 Dec 2011 21:09:46 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id u20sm56549618ank.9.2011.12.12.21.09.44
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 21:09:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201112122001.36303.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187002>

Thomas Rast wrote:

> I tested this tweak of the script:
[...]
> That's over ssh on
>
>   $ uname -a
>   Darwin mackeller.inf.ethz.ch 11.1.0 Darwin Kernel Version 11.1.0: Tue Jul 26 16:07:11 PDT 2011; root:xnu-1699.22.81~1/RELEASE_X86_64 x86_64

Thanks.  I've passed this information on to Apple (rdar://9046540),
though I have no reason to believe anyone reads the reports there. :)
