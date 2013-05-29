From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git init doesn't create master branch
Date: Wed, 29 May 2013 18:24:43 +0530
Message-ID: <CALkWK0m=m89QcnMNg9gEVeb7ZHSRd7ZMcL+y8gYuzn8YCTsSYw@mail.gmail.com>
References: <51A5F8E0.8060906@intland.com> <vpqk3migdb1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?w4Frb3MsIFRhanRp?= <akos.tajti@intland.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 29 14:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhfua-0002Yg-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 14:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935058Ab3E2MzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 08:55:24 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42208 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934616Ab3E2MzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 08:55:23 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so6292726iej.1
        for <git@vger.kernel.org>; Wed, 29 May 2013 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=akl1rYkFt+ph8yAQeJCXTFejgOYQDikA5DpCQkCYr4A=;
        b=Ny+GKm4Z/CnjXUg5Cnc4ZSAnwtcqhukTzGAdIAiENXM0stDPixNBCPh4fQwYxvLHK5
         rih2P6EPsM40Xzc2iiffaTUTjEfOyBdUHfSyO/FuJHsn8nPrBFYu1dnlPUQaMA3PSFMO
         2pwvpAXvHxIekiSAzqq0cUa5vMHvxOqHTj9YUDLxclT3THpPDQKpvtronX9eDT3eBxO5
         3kCt6wYN8lOMXUl8KcgPjgEFBClDWggzlTG6Tj7k+u2cDi1bl5CGwRPXR2he6CtOqYyY
         g3I+mk5Q8+D+UZDhJPzLirqUjFZYYZ3SntSa7VHVvBYC1zWOiTXPllrnO/UXmSZvQjeU
         QzEQ==
X-Received: by 10.50.107.6 with SMTP id gy6mr1154803igb.57.1369832123197; Wed,
 29 May 2013 05:55:23 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 05:54:43 -0700 (PDT)
In-Reply-To: <vpqk3migdb1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225806>

Matthieu Moy wrote:
>> the manual of git init says: "An initial HEAD file that references the
>> HEAD of the master branch is also created."
>>
>> However, after creating the repository using git init there's no
>> master branch.
>
> Right, but HEAD still points to it ;-). We sometimes call this an
> "unborn branch".

Right.  Let me also add that our prompt has support for this; on an
unborn branch, my prompt looks like:

artagnon|master#:/tmp/foo$
               ^
	       the # indicates unborn branch

Please consider using contrib/completion/git-prompt.sh to make your life easier.
