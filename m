From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 48/94] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Tue, 24 May 2016 10:15:48 +0200
Message-ID: <CAP8UFD33fnHWgjKds5s65kpS_KjEH35yGqCG4Hvww7_cOE4drA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-49-chriscool@tuxfamily.org>
	<xmqqbn4bdp8f.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD2i9rDi4K=2_hKmEwjtCgnkP6Bi6gFMymPgu2t-qsdA6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 10:16:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57W2-0002NJ-2B
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbcEXIQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:16:15 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35316 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbcEXIPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:15:49 -0400
Received: by mail-wm0-f50.google.com with SMTP id a136so59794794wme.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=T9miIlZGXvOJdX4wS7R6MsLITykAtLp+tNrmy6WC9vg=;
        b=o8/kGes3mukXoZttuggmazNYigqi/M9Bak4nXgEue/V7FJy28bMApCSbBLApAje+G/
         P7jdc/VQqZ0rK2v71Lv9dCGzIlcg2vA0KN3MlGtpSMpDrLNNewLzKNPNGDyXKOJwLLqT
         zNDJkx6HpiuKbA11eYZP/7FuwVEa0qs7oRE/hL/jMy1+crnNDh/eMgXUANML2ZgNGlLA
         ywk5yO7Mxzv5FI2zrpH87I88LZCC69xbNHcWKjzjOS7KZ+Oovv2CUi8OZGd5JsArLnW1
         FsRpuSVErj3bhyJuhkrXpOS7CfPJUdVkMZYBfwjvRkQqF+wolvOYhAQM9BRIPaRRZrnC
         ydYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=T9miIlZGXvOJdX4wS7R6MsLITykAtLp+tNrmy6WC9vg=;
        b=S6uOi1yoH4Fow8HeCEF7WIn/uONFAgQ9XDiqaOi772nDIhKPagTQNov3Rqn8S4FIRG
         c8w7YXQre65LejTJNoT8uJcpW46HY9iXhMpExsZUILWEXQTBsKg4jYwT4faKX3fz8hUM
         NWfFwNfFG4UsCp00usS+tbdN0G9jYDapMhbrpNbpvuAdvh6pCm0wut/WtNiQtuCxkHLx
         jA9kxSxNRSvdHQr66p8l/2JLUhT7jKP067GMjMq0aJTCkcUIOW7LJuNz1+EHOLCwCSp8
         AvfVxJ+QbyH55tkcDF+L3Q1npqX1sqarNdpVIiwTTxjYU6zuzncExabE2AAr6X+JroH3
         hN6A==
X-Gm-Message-State: AOPr4FXjMnGQewgVzM5UvEDvzzoE5zGcCFCG3yoIcmpPgeuduMmhXwol7mDufSBzdj7lWUcSJP6/Vfp7oGdZtQ==
X-Received: by 10.28.45.9 with SMTP id t9mr22440986wmt.89.1464077748274; Tue,
 24 May 2016 01:15:48 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 24 May 2016 01:15:48 -0700 (PDT)
In-Reply-To: <CAP8UFD2i9rDi4K=2_hKmEwjtCgnkP6Bi6gFMymPgu2t-qsdA6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295477>

On Fri, May 13, 2016 at 9:42 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, May 12, 2016 at 9:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> This is just a small cleanup.
>>
>> ... which may have been better happened at 09/94.
>
> Ok, I will squash it in 09/94.

This has been done in the v3 I just sent, though I forgot to mention
it in the changes.
