From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Sat, 24 Aug 2013 22:41:42 -0700
Message-ID: <20130825054142.GM2882@elie.Belkin>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
 <20130825044108.GA21300@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, phil.hord@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:42:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDT5Z-0008My-SO
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab3HYFls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:41:48 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41224 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755994Ab3HYFls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:41:48 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2222557pdj.1
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2xOrNI3l5pcoyZ435IsxBltRldj+khD8K17Z0dSH93M=;
        b=IQ3THjmQwCV+dGfODMooQ7JHfJx4trTxQu1dZHBlcvEW6Oe0Sb1QlhgWvZ6uFp5H0W
         XM1L7R+amrPBU0g+HXv5Le8BsBXCVh1W+6zmy49FpPQakDhhALXhh620I5Dm3NOIH+p6
         gmqWA7w34CTPDdngwRSKtDdaymWWRqxGqF/RZi3tx+QEGhaWpEfmauly1dN0R3/KRdhc
         lPkMqYlGuTKXfNXaabE1shGQ7At4PdmdOebqVp+NhmvZ3Y1Z55VgAZJePYuKAcbmMiwb
         7mLfyGA/b2x90LG+XhFbTWhbh5mesS/hxL8s/omSfOsMsipntwMvbrm7aIl6z9nCzxD/
         PqxA==
X-Received: by 10.67.1.101 with SMTP id bf5mr7620203pad.50.1377409307285;
        Sat, 24 Aug 2013 22:41:47 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id xn12sm11586231pac.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:41:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130825044108.GA21300@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232923>

Jeff King wrote:

> So we are necessarily reconstructing based on what we know of the
> syntax. And I think that your rule is OK, because we know that refnames
> cannot contain a colon.

What happens with expressions like HEAD^{/test:}?

Jonathan
