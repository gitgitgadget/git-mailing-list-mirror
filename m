From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 19:34:16 +0200
Message-ID: <CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
	<CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
	<CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 19:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJSq6-000798-NG
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 19:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802Ab2JCReS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 13:34:18 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54152 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932767Ab2JCReS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 13:34:18 -0400
Received: by vcbfo13 with SMTP id fo13so8587831vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oT3IkLL6iFrrRrEyf2HskSXMPy1ur/irrH4+sPfTTRo=;
        b=Bqk2mS8XPu2UgZV3X00Wb39xJ/j9ze9tCcUkpFif2kZnVqm5pSZqq9uWRLFheekUKl
         3A0Ml4WHIsGP1xJjdzUGSA+ux0otgCJeYcEQXk+8NRu9jSuAGMsPYnSd8JW9+8GI6smb
         Z7Bs+KuHlAC7pXC+2zUUZ+8hH4hZivs9nnE/xi07IZr1jnQZJKCbOSS1zEevj0VbNO5+
         qh/GFED3rbZBgCvQ5tKMvkr/ndSYjrEJyyPbQx5wAjEeW1802wX6bcutVlRu31vCBYLE
         ej5lVExyJCK+RlXyfn2iq3sWE4DIiRmjQJZDAtU2B62tNxI7r9OyfVsHhYs8lsIUDXsm
         NKlQ==
Received: by 10.52.90.147 with SMTP id bw19mr1011828vdb.17.1349285656173; Wed,
 03 Oct 2012 10:34:16 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 10:34:16 -0700 (PDT)
In-Reply-To: <CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206914>

HI PJ,

take a git commit without --allow-empty: if the trees are equal, it
creates no commit,
and if the trees are different it creates one.
Take then a git commit --allow-empty: if the trees are equal it may
create a commit or
not depending on the parent, message, author and date; if the trees
are different it
creates a commit.
So, the statement does not apply to commits in general.

-Angelo
