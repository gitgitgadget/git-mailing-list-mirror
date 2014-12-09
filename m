From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 12:32:15 -0800
Message-ID: <CAGZ79kZa5sPxbzURtGScCrfbTaCX_cHiRj7uew6Xk+1Df7oTEQ@mail.gmail.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com>
	<20141209202738.GC12001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:32:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRSG-0000pe-KH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:32:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbaLIUcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:32:16 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61118 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaLIUcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:32:16 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1316230ieb.21
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 12:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bJM0gIX1Icaky0r8/3fzUlq+1zhUTvxLBX3tZvMzAM8=;
        b=VeoRJo6ZR3Tquls3J6dUXthEomgzwC/u8Hky/JlIHrioMxBZlYdOv6FFPAIR5f4yrs
         yr/gjwEUsfgUMO1vNWu96zOv6J4Vp4kayBrLpozSUAyGOpT7wI7oflpiP44lgWGCPF10
         UJt1bntVz5adGrdFl6vkBcseI7rEdvAsKEdkM8sPryLrSRSMK3hRNeFJ/zG5uU/Jr2hE
         aTHVaBYZeIH+f4bkjyZLOOYi/6kffbIg3t2JdxmaSft9NSfeIU9l7Wz8d6WiGrfD0E60
         /CfLX10J8NEio9UQxkys3fUlB1NH/yvoSyH6i/PbllxrUYbkfulT8upEWlE4D3ocZfAj
         JmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bJM0gIX1Icaky0r8/3fzUlq+1zhUTvxLBX3tZvMzAM8=;
        b=UY3H2Za01QW8pjEx/4g4SZGZ9yqTrsLCw029BVMiE7etEA11YJn90LTLX+TXIKXJIt
         HES3a5XHox8PZ1iMJVCuJrCOSL5yMXisAtwCUmCwinCpCJIgg59efYECko/fTg/3a3u2
         aXAP7AycZub7jNKtTf1KbpefRepM6hqf48ybaNpRymGGPhfonq3DYv1m6PeV7mE02rGi
         WTMaHjDoW2jURP4uNOQbVRmL3ROs6Vp8XajfqR84oXt/2G/RAlg5+dbO1jVL6HpufcBo
         qOgA9oqKwbGeaCU5/6jt8jLG8yLwKk2DKYTkbfLJS77+HnbImf55YJwN+17pPYtThXme
         AoNQ==
X-Gm-Message-State: ALoCoQlz7ulNe3JTrK6xDiTm7UEyU2Op7uDQuYhURFMXSM2qQCOgDVojqmbddoLj8mw7zVt9uhix
X-Received: by 10.107.25.2 with SMTP id 2mr379705ioz.70.1418157135267; Tue, 09
 Dec 2014 12:32:15 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Tue, 9 Dec 2014 12:32:15 -0800 (PST)
In-Reply-To: <20141209202738.GC12001@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261163>

On Tue, Dec 9, 2014 at 12:27 PM, Jeff King <peff@peff.net> wrote:

>
> In which case can we simply start migrating api-strbuf.txt into
> in-header comments, without worrying about a parsing tool?
>
> -Peff

That would be my preference as well. Putting the API documentation
into the header files. Optionally if you're fancy you may enjoy the generated
API documentation. But I personally would rather look into the header for
the most up to date information.

As said above the Documentation/technical would only serve a purpose to
explain very high level concepts. So racy-git.txt or
pack-heuristics.txt will fit
in there very good.
