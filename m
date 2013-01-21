From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 22:42:03 -0800
Message-ID: <20130121064203.GA3265@elie.Belkin>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130120234205.GC3474@elie.Belkin>
 <20130121010643.GA25437@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 07:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxB5W-00063S-QN
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 07:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab3AUGmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 01:42:13 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61736 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3AUGmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 01:42:13 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so3202964pad.26
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 22:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=93AE9rI0vNY31qpTCOvQuqEK5Bal+Wg8HCWCjqX29Kk=;
        b=OejW+xp/MgZQIEls+oeVgO+s039QtMjUBCrXb4oLo2JcNScV7GeamY/G9v57xxeG0i
         tBc01QHQQtycyH7sFKnRgNpzQk2RdOqOPK7ulbQW7JDBSqSnu3Iz6tWexDcVSNkKF+cs
         hyYCEGadxqOERXhb8HhaD3qb9mOdQBYbOSSK3PPaSWIGnsK97ZazA5VWMFDMX0uTwUtZ
         ZL6vYpVgxr24g5pHrf29p6luadysVz0xW7K1pTxiFsSX8jphHXkfym70W/d2dckFK2H+
         ziskTM5oPnxcmRQlLQeAIeKc0+wLQUjLPUui98RqJAuz3i2Y5DBRM+yZ2dWaCghpikUW
         EZsA==
X-Received: by 10.66.72.97 with SMTP id c1mr44702385pav.48.1358750532755;
        Sun, 20 Jan 2013 22:42:12 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bg6sm8675429pab.33.2013.01.20.22.42.09
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 22:42:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130121010643.GA25437@thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214087>

Eric S. Raymond wrote:

> I have said everything I could about the bad effects of encouraging
> people to continue to use cvsps-2.x, it didn't budge Junio an
> inch, and I'm tired of fighting about it.

What I think you misunderstood is that Junio is not the person you
would have needed to convince.  (Nor is it me.)

[...]
> I will continue to do what I can to make cvsps-3.x and cvs-fast-export as
> bug-free as possible, given the innate perverseness of CVS.

That's all anyone could hope for. :)  Thanks.

Ciao,
Jonathan
