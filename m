From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] fetch: Use the remote's ref name to decide how to
 describe new refs.
Date: Mon, 16 Apr 2012 11:10:48 -0500
Message-ID: <20120416161048.GO5813@burratino>
References: <20120416150036.GA15009@sigill.intra.peff.net>
 <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Apr 16 18:11:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoW5-000421-5i
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab2DPQK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:10:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62707 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2DPQK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:10:56 -0400
Received: by ghrr11 with SMTP id r11so2539203ghr.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m9r/UVWNoiq8Do8xFDFgYgRV8cD8G3GWUpnd7dd2Zdk=;
        b=L/8ioZzwdjda7ysezMam1WGhqMQg4XCj9IqQgzPPiHobNJ5Jkuk4wnQneKxfdJY3fl
         r91nI8ZYZ76aoBRlRK4+x574L68l9A+/x7ASAYrGY2xoskl1BxXSMNPXhkZMfLjW9DUw
         uN+gl5wEvVglPwS8zAwQ/px/6n1ibCQB1YwB/8NFxYP7nntfwhggcIfUHPrjKh4JswAr
         /JkBS4PFb9ilFC4S9+k26EeHe7yQ7XJiv/smUmP2kvqM8928Ch61P3HAlettYPA3ZPrk
         TBdhu+UbWswxRat7VJJsoppi8toP9kXxSWkurG+suQRrOyOBXaNUoVDlRvf0HY9pVqd+
         Wi2A==
Received: by 10.60.20.10 with SMTP id j10mr17554687oee.33.1334592655428;
        Mon, 16 Apr 2012 09:10:55 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id aj16sm15836280oec.4.2012.04.16.09.10.54
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:10:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195659>

marcnarc@xiplink.com wrote:

> Also, only call a new ref a "branch" if it's under refs/heads/.

Looks good (though I haven't tested it).  Perhaps some new tests would
help make sure this doesn't get broken in the future.
