From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] remote.c: simply a bit of code using git_config_string()
Date: Mon, 18 Mar 2013 18:14:48 -0400
Message-ID: <CAPig+cRGv9b6HVbk4pcx38-UXQu6Jgi6sfiQ+Urp4V9tv5+zUg@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com>
	<1363612575-7340-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 23:16:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHiLm-0001uO-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 23:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3CRWO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 18:14:59 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:42084 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3CRWOu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 18:14:50 -0400
Received: by mail-la0-f53.google.com with SMTP id fr10so6719362lab.26
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=i5kgUJ5bv6b/01W53G3P4ajQr3+wMCqr7QCPk77+fdo=;
        b=KDNhhjT3J8tgUaB0/yvu+ee4XmbNcmHb2npZSH/XjLUQBVvDs71VHmw8FNs7VLa0zg
         SsyyNWVP4y9DcA7p0emea/0uTCYu7wTLMvIp1b5j7VQcK2uvixEb4rJBSxbd9xVPTDY0
         AUaibQgfp71Rc1rSmyg2LqRVh4YSHm5qLU8t8FhQG7DhukdYJJ6maWTgMt7UuF4Z81cx
         mIf3DRY+Da7P3w3A12CJWNUXu4Q0p+FUtmz63wfl69wC8oCOFpqZ7sPMyXrYhVCSp+Rk
         WdG9tSJYgyUX92o7cGIAWzHeOttpfzg7kA5ms+vZsg98FfEiiapuP2JZSX+krSFCFKnf
         9oBA==
X-Received: by 10.152.105.109 with SMTP id gl13mr16089063lab.40.1363644889007;
 Mon, 18 Mar 2013 15:14:49 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Mon, 18 Mar 2013 15:14:48 -0700 (PDT)
In-Reply-To: <1363612575-7340-2-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: wmwEsTiHXIbKRqvyg6NlFre7WD8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218458>

On Mon, Mar 18, 2013 at 9:16 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> remote.c: simply a bit of code using git_config_string()

s/simply/simplify/

> A small segment where handle_config() parses the branch.remote
> configuration variable can be simplified using git_config_string().
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
