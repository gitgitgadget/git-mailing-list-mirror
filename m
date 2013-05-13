From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 10/10] branch: Fix display of remote branches in refs/peers/*
Date: Mon, 13 May 2013 08:55:21 +0200
Message-ID: <CALKQrgcMj4-YD-tEgirmAWFKSB6s7yzK=zigaR+FyjdSRPjvrA@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-11-git-send-email-johan@herland.net>
	<CAPig+cSRnsiYRQhX8Gz41D43005zgF9ysNTNSNn-C27nB9HftQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 13 08:59:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbmjT-0001s8-50
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 08:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab3EMGz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 02:55:27 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:57062 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab3EMGz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 02:55:26 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbmfN-0005hK-Gh
	for git@vger.kernel.org; Mon, 13 May 2013 08:55:25 +0200
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UbkcY-000FeU-06
	for git@vger.kernel.org; Mon, 13 May 2013 06:44:22 +0200
Received: by mail-oa0-f48.google.com with SMTP id i4so7094428oah.35
        for <git@vger.kernel.org>; Sun, 12 May 2013 23:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NF1xj3xAfh69ecJ65/5VdE63xY43V2QwsLTaz5/Avp8=;
        b=oSRn751Jn5nVUZ7UC91lEfOGEXeBYMQGpjku1vXof09vo02DB4eEwZSOS6OTr89b6Z
         4Id2fPjHFWC2Uv0PmTD/ziF7fNgskLBQGjqggPMdO4c3vKRjifhSVc7D2qswRZ+tu9P0
         CrykKZNshNyQTJSH6JJdMb8p2bdJylzVNYzG/iXRqHPxHe76kJr1lW+LGy84YAv4J/oT
         IBG0zzwsA2OoHh/no1udrTJk71Yfq7tg3RZW4N9uoQp4TWAQuMm4Zc3Z8Z85ahRCJOAi
         C1dUvmyGWeZahJp3TMOqlUCQY/dimUFm8X3tGpqafiFzyKvDkfT1vPpM6RdKrsIMwHX8
         xOJQ==
X-Received: by 10.60.55.231 with SMTP id v7mr12029774oep.135.1368428121934;
 Sun, 12 May 2013 23:55:21 -0700 (PDT)
Received: by 10.182.113.66 with HTTP; Sun, 12 May 2013 23:55:21 -0700 (PDT)
In-Reply-To: <CAPig+cSRnsiYRQhX8Gz41D43005zgF9ysNTNSNn-C27nB9HftQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224097>

On Mon, May 13, 2013 at 7:19 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, May 11, 2013 at 12:21 PM, Johan Herland <johan@herland.net> wrote:
>> +        * When displaying more then just remote-tracking branches, make the
> s/then/than/

Thanks, will fix.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
