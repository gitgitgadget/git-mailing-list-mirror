From: Samuel Williams <space.ship.traveller@gmail.com>
Subject: Re: Shallow Push?
Date: Wed, 22 Jul 2015 19:27:59 +1200
Message-ID: <CAHkN8V8hcdBD1oBYEpf74rsY2mpzxE08v+czue9ORzDB8ZGn=w@mail.gmail.com>
References: <CAHkN8V-pK3ngfShmTrAaR5gixhRKbWwDoM21QBVw6hp8AngTkw@mail.gmail.com>
	<xmqqmw2iardi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 09:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHoRi-0002JA-RU
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 09:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbbGVH2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 03:28:01 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:36472 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbbGVH2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 03:28:00 -0400
Received: by lagw2 with SMTP id w2so132503010lag.3
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mbDmXvdLP3cqoGtQu7NNAThwtFlBbz1mPODhktBxyvM=;
        b=knoq4GzzCpm07DDoMndN0g92XwYq4+lekwW3NmKiYHuPQZhNQI5dZChDzGsnyHWznC
         JZNbCrjpsai7srT6eExci71MchdbGJyrMV3+H4rX3BM83DbJRoC7x/0D1oZ6J32OyZE0
         zRUL4iPNRoF8CvSh5doIASRF9AuhdVIl2vehaWMWegoFXhraA3Sf8a8jRwLzdys33kIz
         dJi4/21D/QARyFmX6pHgRwhpgG2TOGXe7XzfZHIJP6Dbexwz7EC8av2TDwIILEmelXcR
         bXNU/OkqlGuifc7o3l1j+40Xk89iLOxWlRhZh6tURNmbi94EL3xFeRQRVwJgUJzTg257
         sL1Q==
X-Received: by 10.112.50.66 with SMTP id a2mr1016660lbo.68.1437550079294; Wed,
 22 Jul 2015 00:27:59 -0700 (PDT)
Received: by 10.112.137.231 with HTTP; Wed, 22 Jul 2015 00:27:59 -0700 (PDT)
In-Reply-To: <xmqqmw2iardi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274437>

> What is the receiving repository expected to have?  Does it have
everything that is required to checkout the back-then latest HEAD
the last time a push was made into it, and you are pushing an
update?

Yes, something like that

On 9 April 2015 at 15:54, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Williams <space.ship.traveller@gmail.com> writes:
>
>> Is it possible to only push what is required to checkout the latest HEAD?
>
> What is the receiving repository expected to have?  Does it have
> everything that is required to checkout the back-then latest HEAD
> the last time a push was made into it, and you are pushing an
> update?
>
