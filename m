From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document failures
Date: Thu, 2 May 2013 22:39:46 +0530
Message-ID: <CALkWK0mhHDN3fAydTQN_wDhVzfiqo-UiRFG3eajAWk+S2dHGSw@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com> <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CAMP44s31jyuGGG1Wn9D=D9udkJJdXQfwVAnHuOg02FWinpmn7Q@mail.gmail.com>
 <CALkWK0=B_Ym_ei181eV-WeqJZJyHPv-AmLzYwajm13wftJkB6g@mail.gmail.com>
 <CAMP44s1x8pu2B2h3wKmuBDXz3Tqyk9qyijshcD6iN+NpYDCQdQ@mail.gmail.com>
 <CALkWK0k5zyGwZaP84YMON8VZbfjRxQ3PG2ML2ds8GdQY38s7SA@mail.gmail.com>
 <CAMP44s2nqLrLRFM1bH028FpV+tPYUWYDz_AffaBhVfwwm4h=kg@mail.gmail.com>
 <CALkWK0m=gmf9g_O3uHmpGkSa165G-5VGROTgjQx87XwvDDQKSg@mail.gmail.com>
 <CALkWK0nqoffHD3mfRqzanEuh4yG-cCO-YBGw8ApnG2uLKJaenw@mail.gmail.com> <CAMP44s2suBKMxKTPsOC15PxNrVZKCxDVz=0aaYc2v5h-DMHKRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXx1k-0007Co-EX
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760342Ab3EBRK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:10:29 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50588 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757385Ab3EBRK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:10:28 -0400
Received: by mail-ie0-f180.google.com with SMTP id ar20so941095iec.11
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=SScKsRs/HgoXdkmqxJ43SDqsLDgAC2YLuJL9d1Zi1cU=;
        b=hoejsOGovM6VBnc5HoPZXF3qHztoA+/CPVr9LW4B8pKczyzz+ylKRSpPXlAPYUOOem
         kxtdArVxumtbCbHR5qftAH9fMm0D6VlbTvM8YM5OQJao3TOuxq6TP2Wp9xmvpzP3ZHDD
         rRUp7YMuS4bcjMk3x+jdPaNUQzXtvxppzL8ZdGOG717keu8pkiZE291bf4LRCDZ6Az87
         djMBwvopcO/Fxqfrb9tys3/7RfAKDnZBuBqJqWHv16ZTnbX+dR1adadTiW/nU2Lp9FwQ
         Mpm7BWsBYykllsiG2FjciHKhT+dGCJstIDTtx4WLPzbg0a44LVF8e4xQGmmNh7BEXE9k
         F0RA==
X-Received: by 10.42.123.66 with SMTP id q2mr3551267icr.12.1367514627855; Thu,
 02 May 2013 10:10:27 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 10:09:46 -0700 (PDT)
In-Reply-To: <CAMP44s2suBKMxKTPsOC15PxNrVZKCxDVz=0aaYc2v5h-DMHKRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223228>

Felipe Contreras wrote:
> We probably should fix those, but that is orthogonal to the '@' shortcut.
>
> We can have the '@' shortcut *today*, with minimal changes to the code
> and the documentation, in a limited and understood scope, with no
> surprises.
>
> We can fix the symbolic ref stuff slowly, step by step, no need to
> delay the '@' shortcut for that.

Agreed.
