From: Michael Migdol <michael-spam@migdol.net>
Subject: Re: stash-p broken?
Date: Mon, 28 Jul 2014 17:56:28 -0700
Message-ID: <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 02:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBviT-0006jH-AU
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbaG2A43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 20:56:29 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:39372 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaG2A43 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:56:29 -0400
Received: by mail-qg0-f51.google.com with SMTP id a108so9744204qge.10
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=+7sM3R9sZJWas2WnBQ/keaCq67J2Ui4Ei/1qhTMPFpk=;
        b=Z6JkJoONC+xfxCl/zqXbk5xkxN4z25L51Ufa9hRmcZpBWxiYb5FucqcqBhFG38iARs
         9iNaeCrx+WN+3bbTRP18vEPpT3rgNoIVffFjsv3udb1r6NTb7KW4qiaDdFQ02IpjWrom
         3df2AfDljIzGZEQnJ4ead/NkLNsiyGlzH/cOiDTSkHqp1nBKXDO3YqNOaEB+Z/xHBbKy
         OPH8Xh2A6IRKWxSBCqmzM3Z+oH8Hl11RPgVTu3f01FBat2AzdUOlIpSRBE9bnpny+4Kp
         url28NCYDJpt+qfbjuqMjNOYHD+rLUrUPBqQYki/tPdYNfUNjTmt0AQBmpYRuEZoVksn
         HNOg==
X-Received: by 10.140.30.180 with SMTP id d49mr65888878qgd.63.1406595388599;
 Mon, 28 Jul 2014 17:56:28 -0700 (PDT)
Received: by 10.96.103.70 with HTTP; Mon, 28 Jul 2014 17:56:28 -0700 (PDT)
In-Reply-To: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
X-Google-Sender-Auth: qgtc0FV7RTkunJL95JEuaPOqQ5I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254388>

Sorry for error -- I meant: git stash list -p, not git stash -p.

On Mon, Jul 28, 2014 at 5:38 PM, Michael Migdol <michael-spam@migdol.net> wrote:
> I recently upgraded from Ubuntu 13.10 to Ubuntu 14.04.  After doing so,
> "git stash -p" stopped working.  (It apparently is ignoring the -p
> parameter).  I'm not sure what version I was using previously, but after
> some experimentation, I see that:
>
> version 1.7.12.2 : stash -p DOES work
> version 1.9.3 : doesn't work
> version 2.0.3 : doesn't work
>
> Osse on the IRC channel was helping out with this and saw some very odd
> behavior while trying to bisect where the regression occurred;  he said
> he'd comment further tomorrow.  But I thought I would send a note to the
> list for archival...
>
> Cheers,
> Michael
