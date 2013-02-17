From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Sun, 17 Feb 2013 03:23:34 -0800
Message-ID: <20130217112334.GH6759@elie.Belkin>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
 <1360993666-81308-2-git-send-email-davvid@gmail.com>
 <1360993666-81308-3-git-send-email-davvid@gmail.com>
 <1360993666-81308-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 12:24:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U72Lk-0003TS-8x
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 12:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab3BQLXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 06:23:40 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:56425 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3BQLXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 06:23:40 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so2045150daj.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0FsyZQFVRJZRyiOy6X0pxApyEoq7GOFKLJskWU7p5gA=;
        b=i+6DIr0kdD1pDKkKC0sLongwT7bIkGHBuW40jW2XdDz0NNkcI+L6Kwqyr40dpTpRa7
         iZpsYWqYERRT+dKpV3bbQBzTcs3epcfJneIHMe2ORIf2QxQyMGTZDK0GdGKrz9dXYWqM
         ZfU6PswE9OHQcSN1xKAZXkr74y8goLmCX0HX8UhX/3lYIuzqEDzsTMnGzw9nmHE14JGh
         R60AYaizpCCeEEiecKbAhLH5A33AXyMQ7WNnoZLu+TKWKMa27QTWL/eV/qjdvBBhSRTH
         AZIHtP87Y6tETD2ybwhwmPDMx7UpGwbFvpsH7MJJOSdyB3gOqDl2u32ebSwDaHPDH2Bl
         o7Fg==
X-Received: by 10.68.49.97 with SMTP id t1mr20855020pbn.125.1361100219801;
        Sun, 17 Feb 2013 03:23:39 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id x2sm100049530paw.8.2013.02.17.03.23.37
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 03:23:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1360993666-81308-4-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216391>

David Aguilar wrote:

> t7800 tests that configured commands can override builtins,
> but this test was not adjusted when the "defaults" file was
> removed because the test continued to pass.
>
> Adjust the test to use the everlasting "vimdiff"

Heh. :)

>                                                  tool name
> instead of "defaults" so that it correctly tests against a tool
> that is known by mergetool--lib.

Makes sense.  Thanks for a pleasant read.

Good night,
Jonathan
