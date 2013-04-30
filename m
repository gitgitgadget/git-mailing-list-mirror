From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 23:34:05 +0530
Message-ID: <CALkWK0kXSugXTKWy7_6WT_3UnwVhzyCJNR=QS-4K6vWrU61m4w@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <7vppxcdjd1.fsf@alter.siamese.dyndns.org> <CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
 <7v1u9rewc1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEv5-0001c3-GL
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761138Ab3D3SEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:04:47 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56525 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760840Ab3D3SEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:04:46 -0400
Received: by mail-ia0-f179.google.com with SMTP id p22so691342iad.24
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HpTX0CRuoE9E6Nu7uO6HJj1NCfZZu5EvqJG2L9ia1s0=;
        b=JEg5odkm9gxDFdCuMNq0gkEPwyume5NS9aqPsneffH6VJmr0jxBgYiTJ1bUH7fp6fN
         BQOP7eDHVkMQYjTJJUXrS18PufPKtfU7SO1spujMmHzqcdWXP6nYFrrlyZZdPrFKYbop
         3NrfaQb3zErNlzWrzdFku1LnUj5Ohcf6g97+cZDojYvvsHI9OJaSLqZAQPWNO1AKv5dx
         f+L7zUjAEVplfNtRWGnmZwxEL5SbdahkdyODTCCwFYTTta7UpLzDJpKzIjCudrnMQ5Pw
         URqvmNpXqGOGDv2ZbMsqT5S+XY9H8VOMonTBgAaAL7lkKc4KZYrk8NqcX5mUrs/yGxFq
         XPxA==
X-Received: by 10.50.72.65 with SMTP id b1mr11075023igv.63.1367345085767; Tue,
 30 Apr 2013 11:04:45 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:04:05 -0700 (PDT)
In-Reply-To: <7v1u9rewc1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222977>

Junio C Hamano wrote:
> How else would you explain why "rev-parse --symbolic-full-name @"
> does not make sense

It does make sense.  (Try it with my patch) [*1*]

> and "update-ref @" does not update HEAD?

Why should update-ref update HEAD?  I'm asking it to update the
symbolic-ref override .git/@.

[Footnote]

*1* I made a mistake in the commit message when I said that git
symbolic-ref @ HEAD had the exact same effect.
