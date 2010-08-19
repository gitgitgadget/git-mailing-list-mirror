From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Thu, 19 Aug 2010 15:27:19 +0000
Message-ID: <AANLkTi=Q_fTMqwx83S0SFwOZnLfL5w6_q1u+A-syUxwV@mail.gmail.com>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
	<AANLkTim9AHj0oLkbdQ8dnjWYxDNnVQQ7q=7AfhZynetN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 17:27:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om71e-00018N-MA
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 17:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0HSP1W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 11:27:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44511 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab0HSP1V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 11:27:21 -0400
Received: by fxm13 with SMTP id 13so1128138fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8enDhTwADmWHuQs0FN4CfbJrReX2BFW+UG5r+9r9J/E=;
        b=l6FIkLp09R1Y1djUvyz7goqk2Srj6hWxKhFxbgc6JXmh5lbL6fJmqUc4zDXCj1Fjk1
         QWOPucy4MZuah/d3gFzhs7MDotUjPBAWwmX/ldsb86rGAas7kRnkroI+wQsQbL6aW6O4
         23QufxP63EJ6l8gW/r2ksFkYnh/FaaxA73CbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g9Wcag247tVHN6IYor47yAd/eMBwOt/odWe+hoq5WPAoUVzhVKCT1ofhLsKzMQOWKt
         EXrElNoBVX6MX2UfWuLcpJkehiI/WnaZ2FnpB/eYI77ZQYWP4rk6V0lWbyqB3u8emtFV
         jKDT0ac8wWTYDalK+yo3Nea/bUU0bxBx0cHcw=
Received: by 10.223.109.2 with SMTP id h2mr9480433fap.95.1282231640150; Thu,
 19 Aug 2010 08:27:20 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 08:27:19 -0700 (PDT)
In-Reply-To: <AANLkTim9AHj0oLkbdQ8dnjWYxDNnVQQ7q=7AfhZynetN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153927>

On Thu, Aug 19, 2010 at 12:53, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Wed, Aug 18, 2010 at 22:27, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Not merged to 'pu' as it seemed to have broken something.
>
> What does it seem to have broken? I can't fix it if I don't know
> what's wrong. It Works For Me.

Actually no. It's broken. I deployed the wrong series to my test boxes
before sending it. The breakage is ironically enough a runaway shell
quote.

I'll send a new series that fixes this shortly.
