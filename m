From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 16:10:01 +0100
Message-ID: <CAHmME9qeSEzgw9k8u53O+oCks-dqvfeX_6eXGwCbWD9866sjCg@mail.gmail.com>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
	<20160223105159.GJ1766@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 23 16:10:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYEbN-0003vy-9y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 16:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbcBWPKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 10:10:08 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:54039 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbcBWPKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 10:10:04 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2a022afb
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=mail; bh=5NORyJ+suLxzbWatMc4PKQjjxgI=; b=otariz
	6PDqBR1/6zA/z2i+4kTFu0yBAWQm7SqkzuF17QxGUu11NUGh5oPk/FHg/ZC7Xtjj
	swwkVSYIDizUg/eK3tWqbj1MAOWndCLIoW+ZJU9Z3U2HvstBdJKz3sxOBFtTH9vk
	MNvmfHEOLdA0NQjlU+lfJQGZGks2AO+hptqutXpMWvZLURCKcpJ6zBN/JS5bkm1g
	JYcIkJquObMmou50mhPy8LvON4ol/zGvfQJ/QJdRJ7GBJkh3/doRSgDpzlfAw1zZ
	covdDcRP/P9N+3aOnLWe09WCWJh2PZFB3ssript/UAauTXWEOgECnw7t6eGBTP6q
	yTnYVr0hLlBSRZdg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f1d3572d
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=YES
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:09:45 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id b205so203826607wmb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 07:10:02 -0800 (PST)
X-Gm-Message-State: AG10YOTpPhqnyodA+vKEXKd1M/wFrcC5iEW2PLcXXYuuy+zWNYXdRblfNVUQ7gb6a5gBpBpOKi1tH6TVz15j+A==
X-Received: by 10.194.123.102 with SMTP id lz6mr38949936wjb.2.1456240201998;
 Tue, 23 Feb 2016 07:10:01 -0800 (PST)
Received: by 10.28.180.6 with HTTP; Tue, 23 Feb 2016 07:10:01 -0800 (PST)
In-Reply-To: <20160223105159.GJ1766@serenity.lan>
X-Gmail-Original-Message-ID: <CAHmME9qeSEzgw9k8u53O+oCks-dqvfeX_6eXGwCbWD9866sjCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287078>

On Tue, Feb 23, 2016 at 11:51 AM, John Keeping <john@keeping.me.uk> wrote:
> On Tue, Feb 23, 2016 at 03:32:02AM +0100, Jason A. Donenfeld wrote:
> There's no license specified in the repo, it just says "All rights
> reserved" in the .c file.  I'm sure you intend it to be open source, but
> it isn't unless a license is specified.

https://git.zx2c4.com/git-daemon-dummy/commit/?id=a7ebbf5ab63cb2e95c38a58197cd2805a2deb56f

There you go.
