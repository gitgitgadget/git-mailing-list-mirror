From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 11:32:47 -0500
Message-ID: <CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 18:33:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud16r-0004ra-Je
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 18:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab3EPQcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 12:32:50 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39530 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3EPQct (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 12:32:49 -0400
Received: by mail-lb0-f174.google.com with SMTP id u10so1324042lbi.33
        for <git@vger.kernel.org>; Thu, 16 May 2013 09:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vP0ug17Cb97wRgRWEk+uHSoq2/jjWM5ojH8hTsANXQ8=;
        b=rLyHqC9o89vTD8y3TTQWsFWCYBjx2LarG8DOI5PgL4tGbVM3PKbe5vE5/luVXKGvTo
         t+hisFHA8tTTfSnm2UL1e2KjygOn9ho3uaxhfCjaJzqa4LP3T3k0pxN9n4ncvauYIB2w
         mzVNsnFjzd//M8m7EPoswC2/PSCoG66+a223uX6btSYqxHqBeEOsE8o7HGPxb7pQdSGu
         pNVDHLB5Y96t0UQLkmjfVFZWp39SFUcfG+dd9Ghi/qBhetXuzyFZew/m51+1Qb6iByJA
         rhgs1wN4fGlFaB4seVuMltfUtxtuY1XxRehyv/qo9FOq8IWWzsE9WiToVjwlIXOeuSM2
         gpmw==
X-Received: by 10.112.163.71 with SMTP id yg7mr10889360lbb.8.1368721967563;
 Thu, 16 May 2013 09:32:47 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 09:32:47 -0700 (PDT)
In-Reply-To: <7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224596>

On Thu, May 16, 2013 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I find it extremely annoying that an obviously correct patch is not
>> merged...
>
> A patch that receives "this breaks style" comments

*Invalid* "this breaks style" comments, because it doesn't break any
style mentioned in Documentation/CodingGuidelines.

If somebody dreamt about another style not mentioned in
Documentation/CodingGuidelines after drinking too much coffe, that's
irrelevant. The only relevant style is the defined style.

> and its author
> stubbornly refusing to fix what others pointed out, especially when
> the patch itself _is_ about style, cannot be "an obviously correct"
> patch, can it?

The patch makes the code follow Documentation/CodingGuidelines. Period.

-- 
Felipe Contreras
