From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 16:00:52 -0400
Message-ID: <CAD0k6qS9qA2vrrxF6SQJ-RsX01rryCuZ0zPn4k+OP__TOPR2gg@mail.gmail.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
 <xmqqbne9ivry.fsf@gitster.dls.corp.google.com> <CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
 <xmqqwpwxha4r.fsf@gitster.dls.corp.google.com> <CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
 <xmqqtwrxesqa.fsf@gitster.dls.corp.google.com> <CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
 <xmqq614deoq8.fsf@gitster.dls.corp.google.com> <CAD0k6qRPxkdOgAo=0+_f8bcFoL70MSvLDJ_OjrFtVMKtcqVV_A@mail.gmail.com>
 <xmqq7fotd71o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:01:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQat-0003vf-96
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbbHQUBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 16:01:14 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35961 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbbHQUBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 16:01:13 -0400
Received: by iodv127 with SMTP id v127so148805700iod.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 13:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1QyKvN754GlF3jLOJMtFN8IiRCqSlGfEB7ddL+BJ1bc=;
        b=pt+/Yr26uRg0MYQ2bWTVb5kuMq3Ka6ZCk2di3Cg+YmuQ9FrQyKkG08A3bF7Qre4gp1
         KMMvTI1yAMNu4e00uq6yZMMpKqIPo6Dyl9og/VSxkEvYspxEJ3zeQw90SGvdY9NE/Uji
         hJXoUnuCTaKjEBYf9Rw2GdHaoAc1JJw5oVspq4AdG41Uss16+VgzZMK4for7uHat7eHl
         V5puJJCKjmzWyhOMHk8DxlIkNlAdCIBkmu3jm7msMfAjac44PoezwqLpKvhktinMHd+4
         LvttVM0eVyC7gjl7rHnJcc7K6BwVmRuFl1HSxBTfTICeZIMjuJs6uXfzId4CqwrreNSm
         KS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1QyKvN754GlF3jLOJMtFN8IiRCqSlGfEB7ddL+BJ1bc=;
        b=g3VetZK4JK+TF3NZ9xPH6Xy6avxJc7uhVPzx/dc4hqdn0Ef0M+U51ZB+vCruMTfZeR
         yzWw1t7PXvOx4htZyX0h3ZkwhgLiECMahDN7AuxtU7X3XXbXV6iO44vCx17pdNHgNPtp
         1P9kKL0m9/ec0T8CSxkzxCkTw4/E3iZ0N8VumlattymyiO238QyZt1x/A1dHqfrlAPPT
         l/+Q7jK8cvX1O28GA2pom6qh+iqlTe5vnabSifVDLblxmC/e5NUKa2qbpnWuYAwLYSnf
         JJdE4lIRly73u7V2CHdF1RcbSTxWYHL/GRwxP6RiBVmDppmVf45vSHUPYmYyD6Xe+efo
         LE/g==
X-Gm-Message-State: ALoCoQlrsKPac8h31B5lKjcvTQOAYXcDiMLDRGEO1kICq2f3Ef9BX5psLZkaLl+7rpfm2fPI+Hrc
X-Received: by 10.107.136.66 with SMTP id k63mr1032291iod.194.1439841672468;
 Mon, 17 Aug 2015 13:01:12 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Mon, 17 Aug 2015 13:00:52 -0700 (PDT)
In-Reply-To: <xmqq7fotd71o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276087>

On Mon, Aug 17, 2015 at 3:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> In the shorter term, at least we should be able to introduce
> git_parse_maybe_bool() that does not take "name", use that as a
> helper to implement git_config_maybe_bool(), so that the existing
> callers of git_config_maybe_bool() does not have to change.  And
> that new helper can be used as your "Basically it, but not
> specifically about configs".

Will do, thanks for the suggestion.

Slight digression for a question that came up during reworking the
series: would it be reasonable to rewrite option parsing in
builtin/send-pack.c to use the options API? That way we can easily
reuse the option callback from builtin/push.c. (It would have some
side effects like making --no-* variants work where they did not
before; I assume that's a good thing, but it's marginally inconsistent
with some other plumbing commands like receive-pack.)
