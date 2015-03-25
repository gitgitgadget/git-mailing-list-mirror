From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 25 Mar 2015 02:54:42 -0400
Message-ID: <CAPig+cQ-yLnjrsB1E-7=UXfGzuJHat6YtfS8EVRNP2dcjj_6TA@mail.gmail.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
	<1427174429-5876-3-git-send-email-pyokagan@gmail.com>
	<vpqbnjivi2n.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:54:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YafDF-0002ci-7w
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 07:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbbCYGyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 02:54:45 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:32769 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbCYGyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 02:54:44 -0400
Received: by labto5 with SMTP id to5so12278446lab.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mo/bZG91eUGlxNkdn+2wiji1lnDC565Af0aesRT3ClA=;
        b=wZipKatpWFBEeWFxMSpI7BkEVd2JOloAl9/m+8sWMcJGNfwWBh6WIHClxTADHYu++c
         43P6bE6LzTt2WftMWSrB3y04b/hBZ5S2jc1phBeDPvg3Dp+5B7VKs0ihjlAsqYpF7UYk
         /jjWZ8uoyJh/Ez4hifjzEqZcuFqCKGI9S2Ptl5XB67TUcuPyp74PqzPHKgjqklhqbjTK
         IjUalhHZQ41tiWF5s/E47X0AApEiztRtEe6XRMLJJpksAmbEg1WV5Nhnx4v/tgyKaHHi
         DSTCMz12gseWPnMM/4IogfVl7R59mkqd2plMKo0pm/WDqZBNdGXzhrJhdLzGTpAGa//L
         L/aQ==
X-Received: by 10.112.73.104 with SMTP id k8mr6863028lbv.120.1427266483031;
 Tue, 24 Mar 2015 23:54:43 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 24 Mar 2015 23:54:42 -0700 (PDT)
In-Reply-To: <vpqbnjivi2n.fsf@anie.imag.fr>
X-Google-Sender-Auth: 0u2F2QNqCcMkxigjZ29qkwLeRuY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266267>

On Tue, Mar 24, 2015 at 5:52 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> Matthieu and Eric: I know I said I will try to re-order the patches to
>> put the tests before the implementation, but after thinking and trying
>> to rewrite the commit messages I realised it seems really weird to me.
>> In this patch series, the implementation is split across the first two
>> patches. The first patch should use the old tests, and ideally, the new
>> tests should be squashed with the second patch because it seems more
>> logical to me to implement the tests at the same time as the new
>> feature. However, since the tests patch is very long, to make it easier
>> to review it is split into a separate patch which is applied after the
>> implementation patches.
>
> No problem, your version is very good. I was pointing out alternatives,
> but not requesting a change, and your reasoning makes perfect sense.
>
> I had reviewed v4 in details, and checked the diff between v4 and v5.
> The whole series is now
>
> Reviewed-by: Matthieu Moy <Matthieu.Moy@imag.fr>

With the POSIXPERM issue[1] addressed (if necessary), patch 3/3 is also:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

[1]: http://article.gmane.org/gmane.comp.version-control.git/266265
