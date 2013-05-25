From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Sat, 25 May 2013 17:18:33 +0530
Message-ID: <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com> <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 13:49:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgCyP-0001tv-Bw
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 13:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab3EYLtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 07:49:15 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57950 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab3EYLtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 07:49:14 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so14206701ief.26
        for <git@vger.kernel.org>; Sat, 25 May 2013 04:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YAKrm73ryTnHmrqNmgWhFCQ4kmkTh+NRCIEhiM9OXzo=;
        b=mCn1UhfpVL0ofWx41dK1Dr7U2iOg+AnyJlzooISICT6A5VRzqn0GjU55YRmfFJo52m
         6BfjvkWwQ42MfjlbHP0XlJU2zlXmaNz2qdhSV0Zx19sehpX0u+9NLHU2w4Hxc5ttAd8f
         uZzT9ETCA1GW68Z43y3YjBejqHHyaX8tdiOA+lEGJ+p8VkzGqlUFrGTeyCQSani0Djr5
         cZOILcn/UqJT/ropolYVqTiU3VvaHiIORtDiDpJleqvsaUzAk/hAvk3V9UGY/N4+KBtQ
         H9T7c5MhVfg/jFW7nC/kWh2TksemA6cVN7lkyDVsmAyFYFVRJdOj62MZHVl40dRH+4YI
         /91A==
X-Received: by 10.50.66.140 with SMTP id f12mr1474864igt.63.1369482553812;
 Sat, 25 May 2013 04:49:13 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sat, 25 May 2013 04:48:33 -0700 (PDT)
In-Reply-To: <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225521>

Duy Nguyen wrote:
> Ram, fetch the url above again. Its tip now is 5b4aa27 (for-each-ref:
> introduce format specifier %>(*) and %<(*) - 2013-05-25). Those
> changes make for-each-ref --format a superset of pretty. You can add
> new %(xxx) on top and resend the whole thing to the list for review.
> You can remove "branch -v/-vv" code as well or I'll add some patches
> on top to do that later. I have some compatibility concerns about the
> "superset" thing. But let's wait until the series hits git@vger.

Great work Duy!  I see that you've used format_commit_message(), but
there are some concerns about pretty-formats conflicting with f-e-r's
format.  We'll iron it out slowly, but I like the overall approach.

Thanks.

(Very sleep deprived at the moment; will review and collaborate after I wake up)
