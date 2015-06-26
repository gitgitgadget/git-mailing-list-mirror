From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v8 1/5] setup: add gentle version of read_gitfile
Date: Fri, 26 Jun 2015 19:53:01 +0200
Message-ID: <CAMpP7NbW++B-_OjXN6M3Z1+LW3TJJCnq2L_Jsr-U-Q-rJA5mSg@mail.gmail.com>
References: <1434397195-1823-1-git-send-email-erik.elfstrom@gmail.com>
	<1434397195-1823-2-git-send-email-erik.elfstrom@gmail.com>
	<20150626090331.GA4196@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:53:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XoJ-0002eq-LK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbbFZRxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:53:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34698 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbbFZRxB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:53:01 -0400
Received: by obbkm3 with SMTP id km3so71604870obb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yEXCGq78UrMTyCSeSx43g4grcXLbexc7tov8QFGh0SY=;
        b=ke24U8l+Yg5EkBijnvaQoTU2ffkB3FyuSSNjhY9fA8K2xb58Tsl/qNUm5ZQO5zN466
         EWtRKM/SauKdYB3x035ZoWTr+S6KNCS6X/gPJBYq16E+iImfphzJv1pe7ZUCvmKgQMC+
         xh0oTy1tytfw97w8Q103UPFwLVs2s13PjEF3C6UPjwJaxHf+hBZelGlDRy65rhIeVEfn
         G32vDTmElzL4xvzqJFZuQjChAd9yAfYZO9/f3aO39lor9ZgEKlBdY/s9INeHnQp1TqJy
         ZZYZyFL6fQtkzfWD1DgLygc4RKGo85NpjQD/dNyyrHDAN5jEMWfSgyUsWW17+plqiaPA
         zGRg==
X-Received: by 10.60.123.51 with SMTP id lx19mr2519797oeb.46.1435341181191;
 Fri, 26 Jun 2015 10:53:01 -0700 (PDT)
Received: by 10.182.116.35 with HTTP; Fri, 26 Jun 2015 10:53:01 -0700 (PDT)
In-Reply-To: <20150626090331.GA4196@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272806>

On Fri, Jun 26, 2015 at 11:03 AM, Jeff King <peff@peff.net> wrote:
> I happened to be playing with clang's static analyzer today, and it
> noticed that there is a subtle use-after-free here.

Doh, sorry about that. Thanks for fixing my bug.

/Erik
