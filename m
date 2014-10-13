From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Mon, 13 Oct 2014 07:09:53 +0200
Message-ID: <CAP8UFD0Fx455GiM8EphkG=-vswR-GOD169EOgf2gJsGzTHS=SA@mail.gmail.com>
References: <xmqqbnq6jm0s.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0kfSBhSwu5Mb46XEHqYCE0SEsZd_3c0Sm4WzEc-NNc7w@mail.gmail.com>
	<CAPc5daUTKU1JepLuyVC1Nk6LG4AZ2TA5SEYLsTSPbPKkauzNyQ@mail.gmail.com>
	<20140928.133623.1635797151132857721.chriscool@tuxfamily.org>
	<7viok7k0c0.fsf@alter.siamese.dyndns.org>
	<CAP8UFD1ATE-CtqXJyd7qDw-34RJ3ZQibHo6BSi+42hkaPNzz5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 07:10:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdXtP-0000GT-E6
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 07:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbaJMFJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 01:09:55 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:45648 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbaJMFJy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 01:09:54 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so9187939igb.3
        for <git@vger.kernel.org>; Sun, 12 Oct 2014 22:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sNsyo8yrFZSLnP2SdIuRsfbl0eZByNM0q1S+GUxfUa8=;
        b=HiGhzTAc/8yCX9DmkNQndXNnvFFY8/+DjzLxWULnFhaTDP3v4DyFqydeV3gvEoCdiV
         v2zvzjiWEV8FJ0FsM2JYeq/NH5TXtB+Tx2H0E3uVoydirWr9wCURQ7KFrs9FdxfFVrTv
         7dBBsI0wzdwtFsiWv315XnR/cgCF2hSTPmHw/Qa/Qa2Scx6l+8sV9H3N9kZLA6ec1enU
         gVYo0NFKsmDnGh/UxZBPODfA77bRXW07wA/EaEyozm+RFGzIiTn3lOnp/MA2FxUtEOhp
         GiXkkcsbKwSBPWxGvaBDiisugUWI8+txnVWH3tuYzAtI5YD/aF57BHgydcmAeOginTD4
         xMuQ==
X-Received: by 10.42.130.68 with SMTP id u4mr31751532ics.23.1413176993769;
 Sun, 12 Oct 2014 22:09:53 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Sun, 12 Oct 2014 22:09:53 -0700 (PDT)
In-Reply-To: <CAP8UFD1ATE-CtqXJyd7qDw-34RJ3ZQibHo6BSi+42hkaPNzz5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 12, 2014 at 11:36 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> With v16 you can easily choose if you want to have the S-o-b in the
> output or not, when there is already one, ...

By the way, I sent v16 just before the above email, but the series
still hasn't hit the mailing list.
Did some of you guys in cc receive something?
