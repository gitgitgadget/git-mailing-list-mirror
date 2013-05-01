From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] refs.c: make @ a pseudo-ref alias to HEAD
Date: Thu, 2 May 2013 01:21:56 +0530
Message-ID: <CALkWK0=DajZwYuDYoVS7tJwHO276HXXZ2_z69FeY_w=Kk0V3hg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-6-git-send-email-artagnon@gmail.com> <CAMP44s3nzuecoM+h+pNknV4A68R1gZ6DZpehp3uKcJhppXo+1w@mail.gmail.com>
 <CALkWK0=WjctcYv30V9b3NMb5motYz=57OqmLU7pdW_fbOP40MA@mail.gmail.com> <CAMP44s3D3yPx6mfLvnkf3Ef55=kP1Jtx1P947uG7pg8_HrH3Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXd4y-0003CO-Uc
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab3EATwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:52:37 -0400
Received: from mail-ia0-f177.google.com ([209.85.210.177]:42859 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab3EATwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:52:36 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so1671254iab.36
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aNBdkuyjZx8VIgUxy8FlAzKkD20kqq38eHhWS3xJR00=;
        b=nUp0nQMoSOoHMW6HbjmJVWUXFBi6PYah+JeOBdE4MdM6EjgACh1NwFQ9aKf/sm81ul
         3fgjjiX3V6P1FM6G6ghl8KBHoRh48oBDd/3k/0Tp9eF3PTFIP8GiYPBHAGZsNXV2oaxW
         7xRQ6JSwlboch82r0k3juF5m/CjqFV1Cfld9LpaKoRkWH/43B/IY32g8thnnia4xB4Tf
         bBL1DgqvXmWJ1sbMYXpT3jIH2oBFeIX4p3DqMZ5VL8fe2ok6RkdAGKMIbxs8xgeWOQ1i
         +I6MVEnRipWgHEf3UEXPIuQhv9cpHE42oi5YDis+PNK0sfmq8rVcSYoJNucBZlugubQp
         np/g==
X-Received: by 10.50.73.65 with SMTP id j1mr2492827igv.49.1367437956106; Wed,
 01 May 2013 12:52:36 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 12:51:56 -0700 (PDT)
In-Reply-To: <CAMP44s3D3yPx6mfLvnkf3Ef55=kP1Jtx1P947uG7pg8_HrH3Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223132>

Felipe Contreras wrote:
> If I put my user shoes, I don't care how @ is implemented, I just care
> that it's a shortcut for HEAD, that's what it means to me, the common
> user.

Okay, we'll change this.
