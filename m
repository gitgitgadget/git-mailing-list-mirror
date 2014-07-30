From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/5] refs.c: write updates to packed refs when a
 transaction has more than one ref
Date: Wed, 30 Jul 2014 12:20:02 -0700
Message-ID: <CAL=YDW=W3m9Vg=eGffgJNMo1gPqqugLaySmGhHh=je7qyhMdNw@mail.gmail.com>
References: <1406310926-4080-1-git-send-email-sahlberg@google.com>
	<1406310926-4080-3-git-send-email-sahlberg@google.com>
	<xmqqzjfr27m5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 21:20:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCZQ3-0002jY-CV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 21:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbaG3TUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 15:20:05 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:36652 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817AbaG3TUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 15:20:04 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so2625295vcb.9
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K0YjNM7UJ8FUa9qmlD+jlFYR1dLxMeRwClQ4ZguIGJU=;
        b=WzfVFzTo4Ar4tC/l6Vo/KEtXkMJgYek5WVnOGDgqEvxGApGXBm4kuC/tlZBlSOmCq+
         RrWro8vbM8QCZv2gJlGF6mQvu7LhXHd3VwDXQ0L6W1yRAnd8jgmpUfiW6ZW74ffHDJ7u
         puOOQsJrK4dYQ/dQUSU4atio4WBTkh5TFXDcEeh28QcS3T1cVTT7RSB+Unz1BrKPSQFz
         xqkrpOS3gV6CpwS8ZL9XnM0m3Tu7dGo25p4+iwWDhDyPNpqAoiGSQUIWCZWcT7GUahim
         Esti2tbkQ/JTTj/ezRc0luLmMg61MDvm45AsV22cYY3cq1SvllJecjzMF6JiUyUClcnd
         xlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K0YjNM7UJ8FUa9qmlD+jlFYR1dLxMeRwClQ4ZguIGJU=;
        b=WZPmvL0WuwGLOxLU3r/WzVujNxafC87GaTduwTyatJEorucqCs+53Bnxv0mJBHKf4g
         crTIXuq7QZpnVkqPhchaYLHrcRfTIQoIaNslXT74KNll+aETa+XsgZGkND2s/4DZesXM
         YBXdNgs/uZgsJQNvaPnOQZeXEgGCNWtPWv0xKunrrVlDC1PgvraphaUA7Fe9UJ2G6cH8
         c6CS3sg7lmS7Mdk+FZeKHABr1rsabK+zt3SZJr6JRBUwRaI2k+uWpWFnHUqVh1jYvAE1
         Ef02yXo3veXPh8eCs722JVzf8vPucC1+PqgqRiyYwMOXohSxrAY6wt83i8WbjBhSRcJ2
         mqNg==
X-Gm-Message-State: ALoCoQm9N+k69641v4wEu0iuKuDeg0OBAhxEylVf+ykFg4EkYnlsnZU7eGWAr06VOv8pLrkXGPgJ
X-Received: by 10.52.9.35 with SMTP id w3mr10204053vda.12.1406748003082; Wed,
 30 Jul 2014 12:20:03 -0700 (PDT)
Received: by 10.52.180.6 with HTTP; Wed, 30 Jul 2014 12:20:02 -0700 (PDT)
In-Reply-To: <xmqqzjfr27m5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254512>

On Tue, Jul 29, 2014 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> +             packed = get_packed_refs(&ref_cache);;
>
> s/;;/;/; ;-)
>
> Sorry, I couldn't resist the urge to type many semicolons ;-)

Fixed, thanks!
