From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: git pull issues...
Date: Mon, 25 Apr 2005 19:43:26 -0400
Message-ID: <118833cc050425164311f0bbbc@mail.gmail.com>
References: <118833cc050423142573729ce2@mail.gmail.com>
	 <20050423220049.GC13222@pasky.ji.cz>
	 <118833cc05042514076221624d@mail.gmail.com>
	 <d4jn91$n4f$1@sea.gmane.org>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 01:38:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQD9l-00037L-Hx
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 01:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDYXn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 19:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVDYXn2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 19:43:28 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:26065 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261280AbVDYXn0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 19:43:26 -0400
Received: by rproxy.gmail.com with SMTP id a41so1018431rng
        for <git@vger.kernel.org>; Mon, 25 Apr 2005 16:43:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jcXH+dK5jQjDBm6R7bUR1WKyx6MVJy+S3Rr4pIadHajn6y8SB5hZ98YoqznqFjTj8p/1YIgNHtF8F7nCMldkDgOBZI6lRAcIFy05Lf+bcQqh8L8DD3z5YmsngrvOtff5qp8+lNW7rjq2uReSlQ2QzGnoRTK7YtIeOADfWWAqs38=
Received: by 10.38.10.66 with SMTP id 66mr7041043rnj;
        Mon, 25 Apr 2005 16:43:26 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Mon, 25 Apr 2005 16:43:26 -0700 (PDT)
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <d4jn91$n4f$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The two approaches are very much alike -- there are only so many ways to
skin a cat, after all.

I actually first considered the -K approach, but then realized that only very
new rsyncs support that.  My version works with rsync 2.6.2 (and maybe
earlier).  It could be made to go further back by not using -from0 which isn't
really needed here.

But I like your check-for-HEAD detail.

Morten
