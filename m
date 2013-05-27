From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: contrib/git-normal-to-bare.sh
Date: Mon, 27 May 2013 19:43:13 +1000
Message-ID: <CAOsGNSRm8QChOupsY_Z++qDOMh4hXq-9A_Z2X6uY5o-tFMNj0A@mail.gmail.com>
References: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
	<vpqr4gs23u6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 27 11:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgtxW-0008LQ-T1
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 11:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406Ab3E0JnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 05:43:14 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:34064 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab3E0JnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 05:43:14 -0400
Received: by mail-qe0-f50.google.com with SMTP id x7so3669360qeu.9
        for <git@vger.kernel.org>; Mon, 27 May 2013 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=vg7IY+7hS4g4zRD00XaH9wSi0yE5HLncLFb0lQ0hayY=;
        b=hgHXE41NEW0g1VqRIPxw3zAMGhVoBDkNIIYPeCc68JUeSKBK3ND5K71nJjaKBy1L1q
         I9QbQoTHZnY21T7N3fPZEb7cDKb4eZNgFOLYwTLVGLGuxEtj9BSkOjLkP3IGXzcZP2ng
         90rctZA2lfjOmDEMrTFkFMohaQE6rFxVcghnMx/Ejte8n5q8pDZkuH3xylnZp1mfEysv
         hgq8X4CbYEgKo70udGZgH2KGK5YpIEpRWdUqPt/3jlhvMtwnLquIOKmlXKCSjGurcFUZ
         QJiXsfIewXwXk2f8x54NQUuAFqpxc4pzRm2t2utFqbXJYVu6+Xi0t6TiamMqM2E2krz6
         guTw==
X-Received: by 10.49.97.163 with SMTP id eb3mr31425256qeb.31.1369647793417;
 Mon, 27 May 2013 02:43:13 -0700 (PDT)
Received: by 10.49.103.201 with HTTP; Mon, 27 May 2013 02:43:13 -0700 (PDT)
In-Reply-To: <vpqr4gs23u6.fsf@anie.imag.fr>
X-Google-Sender-Auth: thG7H4htu4Top8QPmOm_JazJZgo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225582>

On 5/27/13, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Zenaan Harkness <zen@freedbms.net> writes:
>
>>    rm -rf $repo
>
> The user would appreciate if you check that there are no uncommited
> changes and no untracked files (at least no untracked and not ignored
> files) before running this.
>
> Also, it's "$repo", not just $repo, or you'll get surprising behavior if
> $repo contain spaces.
>
> The safe way would actually be stg like:
>
>   rm -fr -- "$repo"

Thanks.

In my later email, I changed it to mv - should have highlighted there
was a change. I got bitten, on a small repo thankfully, where a perms
or ownership problem caused the whole repo to disappear. So mv it is
:)

BTW, I've subscribed for a little while now...

Thanks again
Zenaan
