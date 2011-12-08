From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 8 Dec 2011 11:03:19 -0600
Message-ID: <20111208170319.GD2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com>
 <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:03:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhNY-0003ke-3V
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227Ab1LHRDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:03:23 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51207 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab1LHRDX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:03:23 -0500
Received: by yenm11 with SMTP id m11so1274056yen.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qV5GvyMcCmp2biq0ihCU4Z3kU/oYGkJedXOh5sRSiEw=;
        b=t9Oyd8uP2aLDisdAkyfuh+eSb+RSw9omyT8PCb8E853GSJXlb8qtscA7G+JpHosQvJ
         UfUTTop0N5w4n20NJK0pmSoQ8Jr6lwSr3N0JzOBPHk/wdNITfAdeP0ZLMWVOW1cqoAhH
         LZXo8cV36qozwjZ5U0FQiSQFo9qO9inDp0IhI=
Received: by 10.236.136.167 with SMTP id w27mr5859210yhi.65.1323363802525;
        Thu, 08 Dec 2011 09:03:22 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id l16sm16008378ane.2.2011.12.08.09.03.21
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 09:03:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186574>

Ramkumar Ramachandra wrote:

> Sure, you can't create a
> bundle named "verify", but that's the compromise you'll have to make
> if you don't want to type out "--" with each option, no?

No, that's not a compromise I'll have to make.  I'm not making it today.

Having to type "--" or prefix with "./" to escape ordinary filenames
that do not start with "-" would be completely weird.  This is
important to me: I want you to see it, rather than relying on me as an
authority figure to say it (after all, I'm not such a great authority
anyway --- I make plenty of mistakes).
