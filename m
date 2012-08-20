From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Mon, 20 Aug 2012 09:43:10 -0700
Message-ID: <20120820164310.GC168@mannheim-rule.local>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <8572000.QUVXl8yetS@flobuntu>
 <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
 <6231669.WggyDX4Xa3@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:42:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3V3q-0004D7-C6
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402Ab2HTQmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:42:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54438 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab2HTQmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:42:35 -0400
Received: by pbbrr13 with SMTP id rr13so7173210pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JAC7N2aTrFyHQ1cr1jnlYH9yZXsOWjyt7rAHMnCIVuo=;
        b=wVQeiAoUdyG8AEJpseuZAWBjzcc1h+OkgtvxGs1Lqho6aLgiVzoMUeT/GdVwhv8Wvx
         OO6A9DCGE/zQuedbRTMDut508tt+4ZMFUafd5FD2NP+xeAG2HR7ysqR0i2zsg7AUgpcL
         /HSesRkS+Hu5Jzn9fh8RJINcnS2N0x27V0W5W+inKo3qhYfFc0GTJ2IZHeLX54+kkKXe
         h6eqZy6VRwbjX5o5fI9gJnoDG8MvZiYjniqWSdCqUDJn85H8wTeT8h2rhwtqg0wOSVjz
         pY3zJ2SYUl0b8L/i2Jn2qof+83uN4xNKXYDz4wUOB267XIXb9s1MmKuoAez7kaZpd3Uf
         0XFQ==
Received: by 10.68.235.236 with SMTP id up12mr35616815pbc.79.1345480954576;
        Mon, 20 Aug 2012 09:42:34 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id tq4sm11414624pbc.11.2012.08.20.09.42.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 09:42:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6231669.WggyDX4Xa3@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203855>

Hi,

Florian Achleitner wrote:

> What version would you prefer?

I think git-remote-svn should move out of contrib to the toplevel of
git.git (as I think I've mentioned before).  Since it's just a new git
command in incubation, I don't want the maintenance hassle of keeping
it in contrib/svn-fe.  It can be a test program for now (e.g.,
git-remote-testsvn).

Hope that helps,
Jonathan
