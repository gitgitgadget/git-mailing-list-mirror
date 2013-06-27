From: Colby Ranger <cranger@google.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 17:53:26 -0700
Message-ID: <CAFFbUKJTh79-u-D89OAZxjCnfvyZ40DE_iwQ6e+zXSw88AY6PQ@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
	<CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
	<20130626051117.GB26755@sigill.intra.peff.net>
	<CAFFbUKJZ1w2puKFLjPNZmMhSLo3_1kpfA1upv7K6qZV256vTyQ@mail.gmail.com>
	<CAFFbUK+emr44o_2EHW2Y4o5fs8Livif_5D=G=NLDzE=2MEx6NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 02:53:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us0Sy-0001KK-8D
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 02:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab3F0Axa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 20:53:30 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46997 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab3F0Ax2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 20:53:28 -0400
Received: by mail-lb0-f170.google.com with SMTP id t13so111745lbd.29
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=44TNeXeF13imYGx5mgFlNwOGAPIKqbuuqr5wV3aS57A=;
        b=JWEsi5nn2OBqNKUvKkM72dcF2Vbdix6xJsKpPyceFWrXqD+Fo4s+J2YIa8fn7Kpue5
         PSt+PLGeVQmBc1Z4SC1hd8RlV5IylKe2WrNI7P7b7ytq3wXgIqmZNwAU9swKWRmqJr+i
         jKvOCw7FUXX46MVIF9s54lMvGTV0sUr9QT9t1HnKct088HlqCo6vBgm28Dw4yxEaB4cn
         AkCTeQHKl3R7tSZ1KxQg8iY4WFcnyiMfpoUOuEF75S1GiaHkxg7pzDn9i7xKlLZcjDQ9
         uai7RWNJ4MLYHWYHpRNeg4pBTymvD7iGFdYZ5jGtR1jzyqqJXKiWphzMWbBryrrgWjw6
         5eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=44TNeXeF13imYGx5mgFlNwOGAPIKqbuuqr5wV3aS57A=;
        b=WABvoDADUuadLrB+n2WD2yG7x96Uwr1qN7/YIjPF+xvLT0UGDXHYepRWtTpeQbfW9H
         ghfH8w61bvvjuKQqDGQVV3rSKjDUg+KVW8fLNflDL7bjXgFyMGrt8GGxRYkS0gdzc6Iu
         aU5Y6vSJMv/0Ajqbw7E+tLoRRCY2C0zRIZRGcbaiOk/yfKjJL+rGdkrsUH4tF80gvVDS
         C1y64pHExsP41+E5Oxv9y4Bk0aWXFlCyqq0JEFaU/p3S+Oki80pbUTyBXb0FG8ltgKbQ
         87GV+m5awfVC0UlJ3lOEHvYKUC7MSd/zWiNJpvHChaVbSRPwcN9UjDkopzh2Wl9/RICP
         b0zA==
X-Received: by 10.112.219.102 with SMTP id pn6mr3197675lbc.18.1372294406471;
 Wed, 26 Jun 2013 17:53:26 -0700 (PDT)
Received: by 10.114.161.230 with HTTP; Wed, 26 Jun 2013 17:53:26 -0700 (PDT)
In-Reply-To: <CAFFbUK+emr44o_2EHW2Y4o5fs8Livif_5D=G=NLDzE=2MEx6NQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQnatPYSpiZqhDCDCROzbyOmEAfub2KNj1g1Q2uODWEPk9fejuKD24deS/8WF1EEb2aN4CbqQxxgrWBjmV9WcirSKBfzxOOSjmbgWdq3qAMWYjIogXn5sSqV8ARyEsy4tXCZGihS1s2XSpCqY9D1T00uvgpVIG2BB47OzbgytJ+VJOkZrKxEfH3fHG6Ai/2DCk0j78YU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229075>

> +  Generating this reverse index at runtime is **not** free (around 900ms
> +  generation time for a repository like `torvalds/linux`), and once again,
> +  this generation time needs to happen every time `pack-objects` is
> +  spawned.

If generating the reverse index is expensive, it is probably
worthwhile to create a ".revidx" or extend the ".idx" with the
information sorted by offset.
