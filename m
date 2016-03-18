From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 13:22:14 -0400
Organization: Twitter
Message-ID: <1458321734.9385.26.camel@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
	 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
	 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
	 <alpine.DEB.2.20.1603151517590.4690@virtualbox>
	 <1458151880.9385.1.camel@twopensource.com>
	 <alpine.DEB.2.20.1603161923380.4690@virtualbox>
	 <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
	 <alpine.DEB.2.20.1603171536420.4690@virtualbox>
	 <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
	 <alpine.DEB.2.20.1603180752540.4690@virtualbox>
	 <CACsJy8Amdr-2WqwYjYjyaag0jR_pq=h36QFKMk3BYQmE_A-DOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:22:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agy6Q-0007PU-0i
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 18:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbcCRRWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 13:22:18 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:33544 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbcCRRWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 13:22:16 -0400
Received: by mail-qk0-f178.google.com with SMTP id s5so51874986qkd.0
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dpOeQXc55oGsMKicKnuUTn0LBowCohnqRX7B3ukTGyY=;
        b=MAI0sulsZ6cwQSu+pPFaT/fUbd7NS0+uf+RyKqy8IvgZGuQEHfJyiULpu4CWjPNUnE
         soRkgd6RVZgKEHwLsxg0KM8PMFyDybfIx3U4wP9HP5wGEV70J+Xp+k8J7YL4DdzQK67i
         /SEc0etX3YEZnb0BON1456p73ba5t7xdP3/5UpQAoCCA9qwWbA5+8oJMPARyTPv2qbI/
         fj/Kl6BFDbh+gJPPZqAiZoc7LwWOsqLhiOsB6Q0U0ZHookdjSdqfiROzmhVZwMZV1WgU
         jhQzWwN32obvE5uSepBk4I8MOE+eup/wTbnh1guaT7TwlA43nYAHmSQZCx89yaVmPG/r
         21vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dpOeQXc55oGsMKicKnuUTn0LBowCohnqRX7B3ukTGyY=;
        b=kUxpNcbl+qdZKKn1hid4BA7b1sh7cA8+kI9HmqP6O09sW3W2iTzUJko32RIo9iLB6p
         elir0DZ4D4L4pMdBkEytbvgCt7X+FXoSP/efrRv7ZcrTs4BjZO0ZIvg6lxf3evb1lzKl
         JQtRw4YHpTe4VDFNMUKRWtElMCCYRzxg5IVrf3RN8QmTAzuDv7OXX9jNDBPhlDQVQVRA
         PmbT+jmG+57qPml7ptJEDLh70Mc+VSlv0ViVE4ZaRw6J/YL3QLITo67dJLumARiS8E9d
         RljCGQbEBE1JlRZ5pSJ/kx1SS/O5a9HaG8Cr6j9B0sT1JS+fmPXgpmWhH26x7gucDkzp
         HzvA==
X-Gm-Message-State: AD7BkJKjvGYx/Otmk3gW90s8Ro1tSYDAcQurfXduUzq5SZkCORk6GLO9bTvWaNu/BivRyw==
X-Received: by 10.55.80.131 with SMTP id e125mr23787663qkb.62.1458321735782;
        Fri, 18 Mar 2016 10:22:15 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id o9sm6414973qkh.32.2016.03.18.10.22.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 10:22:15 -0700 (PDT)
In-Reply-To: <CACsJy8Amdr-2WqwYjYjyaag0jR_pq=h36QFKMk3BYQmE_A-DOw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289234>

On Fri, 2016-03-18 at 14:44 +0700, Duy Nguyen wrote:
> > So yeah, this is the challenge: to make Git work at real-world
> > scale
> > (didn't we hear a lot about this at the latest Git Merge?)
> 
> I'm all for making Junio cry by using Git for what it is (or was) not
> intended for, but this seems too much. A repo about 500k files or
> less, I think I can deal with,  not those in million range.

Sad news: Facebook's repo was already getting towards that size three
years ago:
http://comments.gmane.org/gmane.comp.version-control.git/189776
