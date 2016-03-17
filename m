From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] builtin/apply: exit when parse_binary() fails
Date: Thu, 17 Mar 2016 10:34:25 +0100
Message-ID: <CAP8UFD2NgSfVVZrshimM+=7dFmhjqGmUVsTymgoQOXvhegr_1g@mail.gmail.com>
References: <1458206614-2898-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 10:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agUK7-0008Hb-Vc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 10:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935223AbcCQJe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 05:34:27 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33770 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbcCQJe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 05:34:26 -0400
Received: by mail-lb0-f178.google.com with SMTP id oe12so64696189lbc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 02:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ICJoEwOiQTEje5SST1Q9eWLCDnCjtbVDI8j5kCY/8SQ=;
        b=v8ZIYmn9ZqKIXn1Ul5vTyp8RbsRcSFhOm+zmNIw1XmCDKG7ggbb1hE6npHg1g6+9dh
         qvhhmCz5bROMRvmAEkl60H/85XePWqq+JHnX0M8HF/J2PQSZVqhjLU8Bj2JOHMP6NNgw
         WFVJHJZn3WNSyDdBQeCsfkBFqp8P2BLEhSWotoyPBF5Zmz9CDjn/6+N0GtDYq6xWmY+m
         c6vB9oY5Qkvtz9Il3RbLuuKxECMZZ64QzZS3uverSOrBFH4KMpeXyYCeBmM6KGVRFSqP
         L5JOAjHHy9WzLFlbZQxCpaNwHMydDvHfq2Mb8DVHycTnfYbHwAbrjBlm7HnCWaj9vaBd
         +eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ICJoEwOiQTEje5SST1Q9eWLCDnCjtbVDI8j5kCY/8SQ=;
        b=RgYTicmEkgyV2UCXQw8TmHcUS3JRU9c1wlGD2Fv5L2xZ+kaJX63G8Rk9sYT9+reXbb
         jQ67Q7rtlavlk293KjcrxeXKuCdlxN7CWS7+QCV10fB6xkVynkOhPrpEoUy9Hx7oNzr+
         0fvS8IhasVrn0Mj8+olC8jIrjXoAHKkMC4Z8SCK5SZwAYqWIZgzDu5MvRINJCJ4IvOWG
         APGx1WsBcJaiLi8TjZNh6E49TWoIphIdWeT4rSxI8sHMPppWgAy0svF30xYYfCtKXQ1L
         jwmIdvSxNx50czkD+RAGgE0vwExs3b3QqoTDhzejB9NRF08TsGIOjpUPOWR17tro5XCw
         k3eg==
X-Gm-Message-State: AD7BkJK/v43yMT5IYU+G7aT4gwG5yWk7SFmz8J5bVMPkthxo/ug3+3r8NXq8PkFwt+65UDLWxYz+ysSDrunGkg==
X-Received: by 10.112.97.162 with SMTP id eb2mr3166316lbb.132.1458207265186;
 Thu, 17 Mar 2016 02:34:25 -0700 (PDT)
Received: by 10.25.137.130 with HTTP; Thu, 17 Mar 2016 02:34:25 -0700 (PDT)
In-Reply-To: <1458206614-2898-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289091>

On Thu, Mar 17, 2016 at 10:23 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> In parse_binary() there is:
...

Of course just after sending this I realized that I should probably
change the title of the patch to something like "builtin/apply: handle
parse_binary() failure".

I will resend a v3 with the above change later...
