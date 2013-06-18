From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Re: [PATCH] Remove pdf target from Makefiles
Date: Tue, 18 Jun 2013 11:14:35 -0700
Message-ID: <20130618181435.GB408@google.com>
References: <1169504685.1649588.1371576637888.JavaMail.ngmail@webmail20.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 20:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up0Qa-0008TH-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 20:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254Ab3FRSOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 14:14:44 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38604 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932812Ab3FRSOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 14:14:43 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so4178155pdj.14
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fZPgJq7hfTBOqQcwgoU4tSFhBwFkuBDcETRRA38DhrM=;
        b=n26pdRR7gify81Z8xXMlsgHndC3nFwYMv28Ys6mTMpxnArFi2bTN99Mkou2hPigB+9
         wo3T5qaXcIM1jj0H13oK8tFGlSwdXV1XVP453hVOMEz0SaJJloE7PKYx78ovT5FACWdC
         mdijGvl0DhXey2Y1CA39MhHGd9vOVYfnLlrCoyimfYKjK66Uhhh3TRqC0jWmOfG9QrwE
         0dqZb+plcUAHpQQ9NONpKbFR0ApKEasn9PmbpPJMrih4vJqXgiyJYv9MYSU7hLDw7HBx
         b21UBr6fNQ4ia37Jahpsq5xFsTdOPR/bnjUlBnCikxOrfj0ioxTYvVQVN/aNw3Q9ubUd
         z8hQ==
X-Received: by 10.66.219.1 with SMTP id pk1mr3177047pac.29.1371579283262;
        Tue, 18 Jun 2013 11:14:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z5sm19328299pbk.0.2013.06.18.11.14.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 11:14:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1169504685.1649588.1371576637888.JavaMail.ngmail@webmail20.arcor-online.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228289>

Thomas Ackermann wrote:

> When I want to tweak the html generation rules I also have to tweak the pdf
> generation rules because html and pdf should be as similiar to each other as
> possible.

Ah, *that's* what I missed.  Thanks for explaining.

I think it's fine for the html and pdf to look different.  After all,
a better way to get an exact rendering of the HTML as a PDF would be
to convert from HTML to PDF (or to print from a browser).  I always
assumed the point of the PDF was to look better on paper than the
HTML, so as long as you're not changing the source document in some
way that breaks the PDF, I don't see any harm in it.

Thanks again and hope that helps,
Jonathan
