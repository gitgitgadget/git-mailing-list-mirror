From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 11:35:08 -0400
Message-ID: <CAD0k6qQnaR_yiWvUw4XL64VufHwZQiUGokH0CqyotCg=sgsceg@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
 <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 17:37:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8SX-0003Az-GT
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbGFPfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:35:33 -0400
Received: from mail-vn0-f52.google.com ([209.85.216.52]:45229 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbbGFPf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:35:28 -0400
Received: by vnbg7 with SMTP id g7so23843750vnb.12
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZEfeoUa4MIO+UuuW+lM3y/q+BA6PN/JsbY9asHiJRL0=;
        b=eBbPqtkTgsS3RT8TRjsQWzJYOgFIxhbV0ZZGQWXXJys4TR1q1lXh9r4r5FRsWsP6hQ
         cmsOvi0+KE5bLjkLKIWxw2Ewx11ZaLVAzisLw8Kjf6FmzNQhPe4z5nRgZHajvMlnBa/E
         m1bJ3UZSCYQYBbpp6bIZzxKHdiZ356sMdCNzdwotu9McOXrwEXnfS3GkxUnoL4Chsmon
         1bPeLwGP7siHaK0a6np6/vOkY7TDbLCCoKZ4yOQ07DnsfWY81Ju+zRKZb3TAw9Nm2slq
         GKJ4GXs7L2ROpSRr+v5zL+30sNXazUxAtmd4/VBsfBhDYbIFzR6z6Wf1gD9vAWYyqXZp
         NDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZEfeoUa4MIO+UuuW+lM3y/q+BA6PN/JsbY9asHiJRL0=;
        b=TGiP1ohaGU4xv1uH3xnA9hqi+zm25WwQGjgpqPeImqsqH+74ciFfKdYQFlm7Q1ISKu
         Nx9x+Bc2q37PagTFoP1cndbSCP+hHkRZUfL/yOv6heskiodrurQJWs6+MpWKgKQlNJ+1
         TbZesVn7ez1wOyDiZs3+vBB9b0WilpfMLUtYjewmxtYbd9GS/R3SW6q9IxU5WQJoJO86
         qRCMeooSOcLqLuKxyO9SQyRa1TMlR2oIUnlC+PQyhOb2mzjM9R9+5ZsVtLWbkj51N2i5
         tn4MPVU/PKlLy0Z2dnBLOPQJDGo7CXVWtyj360IyboqrADv55So8cvKHmEHHRaB7Cm43
         7DGQ==
X-Gm-Message-State: ALoCoQn1EKM7gNOiMkOWkuANHrSFOcwy1NAouEkr4iop8+lw4KChNxUliO87qPNq5wH9/ksxkLFX
X-Received: by 10.52.52.114 with SMTP id s18mr52280132vdo.9.1436196927706;
 Mon, 06 Jul 2015 08:35:27 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 08:35:08 -0700 (PDT)
In-Reply-To: <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273389>

On Mon, Jul 6, 2015 at 11:22 AM, Dave Borowitz <dborowitz@google.com> wrote:
> The alternatives for someone writing a parser are:
> a. Store the original pkt-line framing.

Or obviously, a2. Frame in some other way, e.g. JSON array of strings
(complete straw man, not seriously proposing this).
