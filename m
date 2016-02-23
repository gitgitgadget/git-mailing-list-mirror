From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 16:11:10 +0100
Message-ID: <CAHmME9pVuo+Wub3=DuY-4Zy0Gjm1qM6empt3vvx9JcarF-rbcA@mail.gmail.com>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
	<20160223061517.GA3252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 16:11:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYEcS-0004mO-Ct
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 16:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbcBWPLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 10:11:17 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:56103 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbcBWPLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 10:11:15 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id b95e5fcd
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=mail; bh=pNGNm0B7JToEIFVHcSbNv3ANhIA=; b=MBvlqi
	em3DO+2oGmrbDrxzc9sAmEmDZo+qxWlpQWMuNhEEmP1pjxiQQvv+A848PZr46Bqj
	qNQsTS409y0fhunS28d8sx/GFfyNs63gn/ZbSMl2A5QdBcNDy5vXglm4k0eMqmZa
	WDwT2RlHmXO78TwdKS3T9AW7XCRquG/m3nmY+EunDXsiw+pdyFNyvkFaZiALFH8u
	h6StOZ+abpi7LP7iVAkH0IFDsFRWARieBH7xodKon4VFmRQQVK0h0ekDFo0rRybf
	8mZEdJLmBAEfpq/tWjV8hTa+vsp+VcnG2iOENXAHGrk7Yj+urHcLhvXht8CesnWz
	ZVnrU2+DGUVGPeXA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f905c2d0
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=YES
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:10:54 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id a4so213552345wme.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 07:11:11 -0800 (PST)
X-Gm-Message-State: AG10YOSkDaYmqOFQnEOa8noEkJQ/BAL3DsKLwkH+BixpfwSSuWUcdg1VpGHR8DuLA75KLFDsKaK/sy6P/9vbFQ==
X-Received: by 10.28.111.202 with SMTP id c71mr20123666wmi.77.1456240270447;
 Tue, 23 Feb 2016 07:11:10 -0800 (PST)
Received: by 10.28.180.6 with HTTP; Tue, 23 Feb 2016 07:11:10 -0800 (PST)
In-Reply-To: <20160223061517.GA3252@sigill.intra.peff.net>
X-Gmail-Original-Message-ID: <CAHmME9pVuo+Wub3=DuY-4Zy0Gjm1qM6empt3vvx9JcarF-rbcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287079>

On Tue, Feb 23, 2016 at 7:15 AM, Jeff King <peff@peff.net> wrote:
>
> Yeah, the existence of HTTPS (and the fact that the same URL can be both
> anonymous and authenticated) is nice. Unfortunately, git-over-https is
> not as efficient as the other protocols, because it's not asynchronously
> bi-directional. It would probably be relatively simple to make a
> "gits://" protocol, but I think it would be more interesting still if we
> could do git-over-websockets, to get the ubiquity benefits of HTTP.

That's interesting. I didn't realize that even the smart protocol was
not as efficient as HTTP, but that makes sense. git+ws:// would indeed
be quite nice!

> Darn printed books. I thought the Ministry of Truth was supposed to take
> care of keeping our facts up to date.

:-P
