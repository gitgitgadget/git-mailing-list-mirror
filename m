From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/7] shorten_unambiguous_ref(): Allow shortening
 refs/remotes/origin/HEAD to origin
Date: Wed, 8 May 2013 00:37:19 +0200
Message-ID: <CALKQrgeFZPM3xczxyiN_vjjhaJ_tevqPRPoAh7BBSWpCp1F0=w@mail.gmail.com>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<1367711749-8812-2-git-send-email-johan@herland.net>
	<7vy5bsq9m9.fsf@alter.siamese.dyndns.org>
	<CALKQrgcoz-+5Kb-Y1Ui9LhE=+pvcRUdAS+iRWXAfsYnV6+k34w@mail.gmail.com>
	<7vy5bqiij3.fsf@alter.siamese.dyndns.org>
	<CALKQrgdaXOjXFeWSpGtgqKhALqpRN0L7VEMbNf+93UJEBTD9ig@mail.gmail.com>
	<7vtxmeigw1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 00:37:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZqVq-0001mK-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab3EGWhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:37:25 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:58353 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab3EGWhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:37:24 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZqVf-00081r-4q
	for git@vger.kernel.org; Wed, 08 May 2013 00:37:23 +0200
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UZqVe-000K5L-Tv
	for git@vger.kernel.org; Wed, 08 May 2013 00:37:23 +0200
Received: by mail-ob0-f181.google.com with SMTP id ta14so1117943obb.26
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Lokxp208UxHiWq3BD3e1RAARFdYER323poUa1rPP1XU=;
        b=BF/ZNTpe1ve5HmgjRTz3BGrGWuwE7EBbpZniJFkHjakRJUJvbP4NvF7KxOWdTW5Y3m
         Dk+AnPHATWtUdfA0ab3U4o92oUVfg7hr59RKVvJ9yXloUCOE2GlnGgfpQjy2TnFuvpL+
         GHd9XDK1M4Ny9+hwTNlgdkmUg5GSm2yrEQkkFtubhlInOuONpzisQoB9vwFxAFBGA6nd
         LwvW4BUg23RhOBUDRubQeY/skZCKkVYU4+ny/1ogae6ZCSlPXHhfewZUeYN8fJf/7grH
         bekXL6QSUO90wt/bWbJVnLPzF02Zov35a+AgMozcXthZeBn4BXAIg/isHXXu9MDUv98u
         KMUQ==
X-Received: by 10.182.28.68 with SMTP id z4mr1163240obg.36.1367966239515; Tue,
 07 May 2013 15:37:19 -0700 (PDT)
Received: by 10.182.129.110 with HTTP; Tue, 7 May 2013 15:37:19 -0700 (PDT)
In-Reply-To: <7vtxmeigw1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223626>

On Wed, May 8, 2013 at 12:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>> ...oops, I see I forgot the trailing && on this line. Do you want a
>> resend, or fix up yourself?
>
> I've pushed out a heavily fixed-up version on 'pu', mostly for
> styles and some log message changes to describe "when it is not a
> symref".

Looks good to me.

Thanks!

-- 
Johan Herland, <johan@herland.net>
www.herland.net
