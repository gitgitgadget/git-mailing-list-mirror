From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Fri, 9 Aug 2013 13:01:01 -0700
Message-ID: <20130809200101.GX14690@google.com>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
 <1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:01:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ss7-0004jS-3K
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030974Ab3HIUBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:01:07 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55867 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030899Ab3HIUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:01:05 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so5311596pad.16
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=h+r/Zol33ljIP+761yYN2l3Imnh0hgOHwftvNIxh074=;
        b=E0oLjE2rbEAq83E3Q668JnftUbF8QKQ+jbnopfOwM2y8hJnrMA/JbiC1t+wc2Z4Tz2
         UVGk2q7F5Ea0Q3tTVYaOVzAw+VwMvk48HnF5yiFVV7YA+Z+Z2oRYleC+i0+8ctO+t7ta
         3iItESm9rZpHSQlA+gTwPrCJE9aLTY9u2RUyg6qdqdLzti2iGD4Ohn8k6VPb628kdXM2
         K3LBh/d6KP6AStAg3Yb3swHvGJbe7YB7UqJX5p1udVQZlwk7Jun3vTzIx3q1FGs3tITn
         /7lLJMkaH0Ke3Lz6c9Efayq22/ZhaEY2lCojW6YqXqE0kv47l+DI9ax0ETDlw0hindMH
         D0Rw==
X-Received: by 10.68.133.71 with SMTP id pa7mr13184056pbb.133.1376078465244;
        Fri, 09 Aug 2013 13:01:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ib9sm21704564pbc.43.2013.08.09.13.01.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 13:01:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232016>

Hi,

>From a quick search for homepages:

Stefan Beller wrote:

[...]
> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
> +Amos Waterland <apw@rossby.metr.ou.edu>
> +Amos Waterland <apw@us.ibm.com>

>From the history of http://people.seas.harvard.edu/~apw/sreplay/sreplay.git
this looks like the same person as <apw@debian.org>.

[...]
> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
> +Daniel Trstenjak <daniel.trstenjak@online.de>
> +Daniel Trstenjak <trsten@science-computing.de>

<daniel.trstenjak@gmail.com>

[...]
> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
> +Jason McMullan <jason.mcmullan@timesys.com>
> +Jason McMullan <mcmullan@netapp.com>

A search at http://search.gmane.org/ by name sorted by "Newest first"
finds a candidate email address.

> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
> +Jens Axboe <axboe@suse.de>
> +Jens Axboe <jens.axboe@oracle.com>

<axboe@kernel.dk>

> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
>  Nanako Shiraishi <nanako3@bluebottle.com>
>  Nanako Shiraishi <nanako3@lavabit.com>

I don't know how to contact Nanako these days. :(  Maybe mailmap
should learn a way to say "there's no current public email address for
this person".

> +# The 2 following authors are probably the same person,
> +# but both emails bounce.
> +Rutger Nijlunsing <rutger@nospam.com>
> +Rutger Nijlunsing <git@tux.tmfweb.nl>

Probably <rutger.nijlunsing@gmail.com>.

Thanks and hope that helps,
Jonathan
