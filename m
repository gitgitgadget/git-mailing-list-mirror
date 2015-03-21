From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 3/4] docs/git-credential-store: document XDG file and precedence
Date: Sat, 21 Mar 2015 13:59:28 +0800
Message-ID: <CACRoPnTqSk=v6ambpsr1+3yP27oVsz4PGkfY8iPrsqgNyyv+yg@mail.gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-3-git-send-email-pyokagan@gmail.com>
	<vpq3852ff5j.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Mar 21 06:59:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZCRt-0006sn-EP
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 06:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbCUF7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 01:59:31 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36689 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbCUF7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 01:59:30 -0400
Received: by lbblx11 with SMTP id lx11so66535007lbb.3
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 22:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qcH4/Q2Y9h3/4G0FVI3aCnQxlzRblfzfOi9D2TxwxRw=;
        b=yxcEazpXfyhMjuROqKnysm1FNXVwoXFj41MZScFK+geB20OpuiUcNA9AoaOmE9ln0h
         1WU39hyPwrzIlujfvC6EURvNXpauNXG7bR46dr2hQ4uZloGmN/Fn/5xmx/+xFWnB6uX5
         RrOArtX1Fju8S64AE9s+g7wtbgiF4pGAuMFg6qZz4/teJamhC8Ar/Ilc5I7hDoYG+6Va
         3VSYjxl62qFaAkwbp+dezOVe05uzNZmakyt6LloqgiJ/zT6viWUfxCnKC1PTEwADCRUg
         Tl5IzjncS39Yb1l1Teql/q4AgwIsKM497HJEu8idGtgPQfGG0yD6+3FbEwitF2MRTQC8
         7FZg==
X-Received: by 10.112.44.132 with SMTP id e4mr75549979lbm.66.1426917568991;
 Fri, 20 Mar 2015 22:59:28 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Fri, 20 Mar 2015 22:59:28 -0700 (PDT)
In-Reply-To: <vpq3852ff5j.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266011>

Hi,

On Thu, Mar 19, 2015 at 12:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> I would personnally prefer to see this squashed with PATCH 2/4: pushing
> the "bisectable history" principle a bit, the state between patches 2
> and 3 could be considered broken because the code does not do what the
> documentation says. And as a reviewer, I like having pieces of docs
> linked to the patch they document.

Yup, I can see what you mean. Will squash on the next version.

> Paul Tan <pyokagan@gmail.com> writes:
>
>> +Credential storage will per default
>
> Not a native, but "per default" sounds weird and "by default" seems far
> more common.

Ah right, that definitely sounds better. Thanks.
