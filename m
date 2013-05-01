From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 06:12:05 -0400
Message-ID: <CAPig+cSQeU8BaaPm7GfCUxtsVj1Ce31ygBLdkb5WN8o4aNMAow@mail.gmail.com>
References: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 12:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXU1G-0005yb-CD
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759075Ab3EAKML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 06:12:11 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34428 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab3EAKMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:12:09 -0400
Received: by mail-lb0-f173.google.com with SMTP id v5so1331579lbc.18
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=mtJIDuqZkBoX4QMF/1C+vaGjeU1/EbOtjtpdd72b3QA=;
        b=SM8xkDgYvLRiV6OQ3/HQxvAzFBNRgyWEbbTVq15GmQmBlDTZNQIolTAQny2cfN3MiR
         IxAK3KPg7f45qNGCB2bWMQiBOYf5YW4qrc1tsc5TekuqZ0yGGPeJllZMnXoBrZkz3rw4
         tqOsedn+c9PCLDgo/VbSBn/K76zWeUU0Y8SADUJyX+0rfw55nsp6uVTSJ/tI3AlYZdJR
         YwSJSzIuZRVCHoX/nZPie3lntGni1RnxYFK2IuJgO/YojVDrpDLM/RoEoqTASEIpulP/
         gxvrzC6nWq4Di8eQBGtQcEfP6wNZJw2PPxwvaDQGSYDIYdFXoxzSWAFUw3lQfAnny0w3
         fMUQ==
X-Received: by 10.112.137.9 with SMTP id qe9mr947254lbb.64.1367403125958; Wed,
 01 May 2013 03:12:05 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Wed, 1 May 2013 03:12:05 -0700 (PDT)
In-Reply-To: <1367401888-21055-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: 21BXNoA5NsuRW5teyzNmLo0_KtQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223078>

On Wed, May 1, 2013 at 5:51 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
> remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
> can't remove '{0}'?
>
> This patch allows '@' to be the same as 'HEAD'.
>
> So now we can use 'git show @~1', and all that goody goodness.
>
> Until now '@' was a valid name, but it conflicts with this idea, so lets

s/lets/let's/  (contraction of "let us")

> make it invalid. Probably very few people, if any, used this name.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
