From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Fri, 21 Jun 2013 12:49:26 +0530
Message-ID: <CALkWK0=xL-o3tHLK8iqyB+KTt8S7QA=Ln8o8kwW+fisY7D_TeA@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
 <CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com>
 <CAC9WiBgmswSqDHS3XOubvkY6GhBqrQ3YdwgKR4npqHM-kLJuMA@mail.gmail.com>
 <CALkWK0k_2jzQNBjLKZ4SDc9vqoZuQ7937dnO6Z_Ye4Ha+FNcag@mail.gmail.com> <CAC9WiBieEG9zhiAqC+bwCAN8qutRr0L_-Fo19ORBqjecnBynhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 09:20:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upvdl-0002bx-TG
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 09:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757736Ab3FUHUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 03:20:08 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:54333 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab3FUHUH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 03:20:07 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so18883859iec.27
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ykVIkM8NWrR9QvacDL6ztANB99XvI9eB9DnsqqpWhaA=;
        b=KsSvd+HDCwM6bWkuI+QLRbvp/+e4d6+xPOkLVncg3YPG2cooi0DZGxY8iEje1xvQTV
         ZUKvqEiBlcoguTpczmoqUMyyttoWA51EUkg1qqvWbRtMQOIhZV2wD9ZP/XHAQ4K86V4A
         GIgSX2Vlp0O2Luyl21McTvqoHy7vfXDp8kMqhmtKAaO987qCEBgsXDfodMKcVq8tYq9A
         OwWqKt/0CCwrZU76Wistn7PofumrspKphHhE+ZBghDWyOMV8SDeIY6XSnBYiy1oTVzc+
         tG9G7Cs2WY7V1WkHQjfHtWagDMDhDZ8GOvr3apNa/Q0vttx5HRb5NuMUBOEGicjO0r5x
         H/2Q==
X-Received: by 10.42.190.74 with SMTP id dh10mr5361873icb.35.1371799206511;
 Fri, 21 Jun 2013 00:20:06 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Fri, 21 Jun 2013 00:19:26 -0700 (PDT)
In-Reply-To: <CAC9WiBieEG9zhiAqC+bwCAN8qutRr0L_-Fo19ORBqjecnBynhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228583>

Francis Moreau wrote:
> Slower ? why do you think Thomas' solution is slower than the obvious one ?

There's really only one way to find out: try it and see. YMMV
depending on your data.
