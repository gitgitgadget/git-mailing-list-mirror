From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 16:11:46 +0100
Message-ID: <CAHmME9qdK-NQ7Kz3JmH5PDwU9JnCG=TC1ipCisd0qffTMwAxYA@mail.gmail.com>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
	<20160223061517.GA3252@sigill.intra.peff.net>
	<CAHmME9pVuo+Wub3=DuY-4Zy0Gjm1qM6empt3vvx9JcarF-rbcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 16:12:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYEd8-0005KP-7y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 16:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029AbcBWPLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 10:11:51 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:58962 "EHLO frisell.zx2c4.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969AbcBWPLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 10:11:49 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6911e747
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
	:in-reply-to:references:date:message-id:subject:from:to:cc
	:content-type; s=mail; bh=qpxF9gmbtbVD4IlJmCuqLOvioFE=; b=A2u09n
	eVmserW8pLx/yZ0+350r+/zFkxw05D6XSv5uglmeN4WUzgNLvkx8fKf1AmRPqGbg
	n5C+ydUgTKsRqeWhhMfFyTnaoUIGi5js2/CoJt5xDmifcVIvqc6X30ALhWEGEVCv
	zuES6u6MWV7iOaTA0gSw5VepdRkKfqtJlVyt/ZdhzaC/3y9Ni9nUFwmr5K7+p6DX
	fac6d7hyQxpz13Jvpg9l/uuQYaOEMAKhAV3bnI0qfTce79qGeUmYUXCc+p+ZGLbz
	NVe3YnycGdb3unijZhiigXWGAEWDepmty1WEbkrD5h511NkMMT2ljgjfJEd5Yc7l
	Vlf99KWZeEY1Ktig==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 735d27e8
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=YES
	for <git@vger.kernel.org>;
	Tue, 23 Feb 2016 15:11:30 +0000 (UTC)
Received: by mail-wm0-f42.google.com with SMTP id c200so225362887wme.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 07:11:47 -0800 (PST)
X-Gm-Message-State: AG10YORmB5tpJKwFfWY5knsy9AviFUlfsuNy0J4h1FcKuOP/4qzgYo6Ywi8WcySoixbU0zQk4SRaR8ReZ7QxMA==
X-Received: by 10.28.107.140 with SMTP id a12mr20130356wmi.77.1456240306935;
 Tue, 23 Feb 2016 07:11:46 -0800 (PST)
Received: by 10.28.180.6 with HTTP; Tue, 23 Feb 2016 07:11:46 -0800 (PST)
In-Reply-To: <CAHmME9pVuo+Wub3=DuY-4Zy0Gjm1qM6empt3vvx9JcarF-rbcA@mail.gmail.com>
X-Gmail-Original-Message-ID: <CAHmME9qdK-NQ7Kz3JmH5PDwU9JnCG=TC1ipCisd0qffTMwAxYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287080>

On Tue, Feb 23, 2016 at 4:11 PM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> That's interesting. I didn't realize that even the smart protocol was
> not as efficient as HTTP

Can't type today. *as efficient as git://
