From: Davide Baldini <baldiniebaldini@gmail.com>
Subject: Re: Fail to push over HTTP with MySQL authentication (Apache2)
Date: Sun, 30 Dec 2012 01:27:29 +0100
Message-ID: <50DF8A71.8040909@gmail.com>
References: <50DF4A78.5000206@gmail.com> <20121229210128.GB21058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 01:28:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp6lf-0001g4-OA
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 01:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab2L3A2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 19:28:20 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42038 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2L3A2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 19:28:18 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so5618234eek.5
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d2c8LAgus8nqP5W2lhgAHSxlNm4bQIpQxgQ0qCc+b9Y=;
        b=W/QDpVG5cmUyrb4GWiS3VH5hvzMUu0u5KU5DUhYMVfpy3YALpdvv2fsxydnNoV+dYi
         YRMGRBoDPL2KWKbiTamynBOBnUwx95+R87S8ou7ie44RgSM9ZksLGQwU+G9GbGsd1OBJ
         tirClkESAiLYYUGCM3hrBPigZdBOAc1ijNkhUbD9VvDu9hE2oLDMKL3il7KkAfnDwL6c
         TuS18i5iTmq7fAHSanwXn1D2kgy/XL+9CeOj0u53IwQXUiYNQaf20jaTYPrJER0K+7m2
         /L4j2Us1nYS7Yxh3zVlCa1+nmd3IeCySTYiJS1y9JqCu7rjB33PoK73NUwh5tlLszqWx
         4lqA==
X-Received: by 10.14.178.196 with SMTP id f44mr98772316eem.14.1356827297347;
        Sat, 29 Dec 2012 16:28:17 -0800 (PST)
Received: from [192.168.1.11] ([87.19.240.177])
        by mx.google.com with ESMTPS id v46sm75266276eep.1.2012.12.29.16.28.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 16:28:16 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20120507 Icedove/3.0.11
In-Reply-To: <20121229210128.GB21058@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212322>

On 12/29/12 22:01, Jeff King wrote:

> However, before trying to investigate that avenue, have you considered
> using git's smart-http backend instead of WebDAV? It's significantly
> more efficient. You can get details and example apache configuration
> from "git help http-backend".

Thank you for the suggestions, I've been able to have the setup running.
I abandoned the horrible WebDAV in favour of Smart HTTP, and it's been
quite straightforward to configure and run successfully.

There is some documentation on setting up DAV here:
> 
>   https://github.com/git/git/blob/master/Documentation/howto/setup-git-server-over-http.txt
> 
> but I have no idea if it is up-to-date or not.

No it's not up-to-date. It should refer to Apache versions <2.0 .
Some of its config directives are inexistent in modern Apaches.

- Davide
