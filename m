From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Thu, 17 Mar 2016 20:02:55 +0700
Message-ID: <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
 <alpine.DEB.2.20.1603151517590.4690@virtualbox> <1458151880.9385.1.camel@twopensource.com>
 <alpine.DEB.2.20.1603161923380.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXaO-0006ht-FT
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935662AbcCQND2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:03:28 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33503 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935604AbcCQND0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:03:26 -0400
Received: by mail-lb0-f180.google.com with SMTP id oe12so68152029lbc.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2BmBQ/vGZ/Ho3xm0oOm6A5DtMtXPdtVcmh+Rfz+otc=;
        b=pYn+KoSOZOMa7Ig3tzsIzAaCWvMj2iKvEjn5VJMmu2BL/aqOe6J9GweY+izlJ2pin0
         GhRhbFnPvcQxI3PfjhnhrqiCPoeShV+62zkIW64hCNwgWI0RdOOQyCuVvxkNBtNXewuj
         BjJOHvUdf0bFaye7VsF5X6j9QX/V0sS+wbQSXZdryVaZVUzqiLQhYNRUlyfye4/y0bl2
         MIuA+xKs/NLtWM1V6Dstoal8RI0ayEMZ3dI+zhGi955nIyUucHFzWS6JAmhzDZkewbWs
         dpaebEv5sO5cNVX4CcneRje+J3DnxnQJUw6vVhGT9KKqAHYn1h9SL/h/j+/avw3FiMSj
         uaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2BmBQ/vGZ/Ho3xm0oOm6A5DtMtXPdtVcmh+Rfz+otc=;
        b=S1PSfOMazX2aedJwO/uJjKdR3yLMWTto9fj2GIrlUI3RGFE3eQPYbNQxuYxLq1Sn1n
         Zdi+oWuC/mR8jMkvyfK37OLq6OB0hzfnbd8m8VP/tIN1AbodlRUHWecvoFEnl1jxxSwi
         aMmh7xyp+7S5kyWbt74DkIenPVwmByeLmJ24sZcAyRXu2TJChiwiJeIH/JeqLvmuIlS0
         +6guyiybXN2X0Xjl7aaYxeoQDJbpTqLsCKBDocDd4ZOo9UGGI5/BBsf8t8kqt1Ou90e/
         VyMOXVvxT2+3VPxhhRvWAkxmURxIjHocYjpWHa+JYL5yzUGoFSeFBFSP3911TXJ9qCG5
         k5pQ==
X-Gm-Message-State: AD7BkJJWVtJaoUGm6wcXmxK1Te6rAKkg39sidWFykth8D4G2E77wJvcLr0r4rkX/6qURva9O3HF/EFMLwyOTog==
X-Received: by 10.112.171.163 with SMTP id av3mr3572859lbc.145.1458219804772;
 Thu, 17 Mar 2016 06:03:24 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 06:02:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603161923380.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289108>

On Thu, Mar 17, 2016 at 1:27 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I am much more concerned about concurrent accesses and the communication
> between the Git processes and the index-helper. Writing to the .pid file
> sounds very fragile to me, in particular when multiple processes can poke
> the index-helper in succession and some readers are unaware that the index
> is being refreshed.

It's not that bad. We should have protection in place to deal with
this and fall back to reading directly from file when things get
suspicious. But I agree that sending UNIX signals (or PostMessage) is
not really good communication.
-- 
Duy
