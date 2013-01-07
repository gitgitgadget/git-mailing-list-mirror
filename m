From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push --force to update tag
Date: Sun, 6 Jan 2013 21:42:26 -0600
Message-ID: <CAEUsAPZGDrPZz1vzdAbKhyNja391+PAOEaWFJ92sbaGNxYZ74g@mail.gmail.com>
References: <CAHtLG6Ss=KE8j_VZWf77A9FXantnwJvdDi1uoN9M-XO0c9GgEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 04:42:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts3bs-0005IH-BD
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 04:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab3AGDm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 22:42:29 -0500
Received: from mail-la0-f43.google.com ([209.85.215.43]:60086 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab3AGDm2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2013 22:42:28 -0500
Received: by mail-la0-f43.google.com with SMTP id eg20so14330106lab.30
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f1MQDyRrOlfkZ/CvzsAbFPKv1TcTKvBbtTRgZUtTRvk=;
        b=dPntHIIXlTYohTEXkVU4QpBccpAfxvwX6j9jKxq+ctKuA3Iig6DlOzOx9rMR1Pa+Zt
         9AGI6GPm7hfR1nUOsQ4wug2FhPuy4YKm1IcOYzhpm9o7j5DjjYkWUzssCGG6+xVOaiZb
         v9OANCLjzVGwGwkUQ05ihehlJ5pacTGYVXGb6K+GpvQe7Jf7aZjuDiWqXh32NcZREdMh
         Ujjh2n9k1nCwCQhFW9G9I9Z8ez0WekdUBYBd1v0uJz3Vj3sZsd6HCGvBLltSqxslaGFG
         C57cL4jr+T1jzb4K8HqGRHfdPls9t+gAmULfXa6h3/RRwp6xGVFae3LtgoPp2CGgiWF9
         /PJA==
Received: by 10.152.125.7 with SMTP id mm7mr57318495lab.2.1357530146838; Sun,
 06 Jan 2013 19:42:26 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Sun, 6 Jan 2013 19:42:26 -0800 (PST)
In-Reply-To: <CAHtLG6Ss=KE8j_VZWf77A9FXantnwJvdDi1uoN9M-XO0c9GgEQ@mail.gmail.com>
X-Google-Sender-Auth: nYlyKBxsmtcUUZadRoJpUk3NxAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212874>

On Sun, Jan 6, 2013 at 8:23 PM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@g=
mail.com> wrote:
> about git 1.8.2
>
>  * "git push" now requires "-f" to update a tag, even if it is a
>    fast-forward, as tags are meant to be fixed points.
>
> Does the server side validate this? Do we need to upgrade git on
> server side to support this?

This check is made by the side doing the push.  There is no additional
validation done on the remote side so it does not need an updated
version of Git for this feature to work correctly.

Chris
