From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Fri, 26 Apr 2013 15:28:50 -0500
Message-ID: <CAMP44s0YBQfq0RCJCSO8r8jjn1F7ZV+7W6K9qhOHVNmxQHmsFg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<7vip3a2vq0.fsf@alter.siamese.dyndns.org>
	<CAMP44s1RdZ19y8v+_=gwBzq1Tg5v8+TWAYCAVR-ZzNwZ0_m_Ng@mail.gmail.com>
	<CALkWK0mRfj1FGYymDrBqQ=d02mhPkevJKr5Ozhgurp8DMhiNjQ@mail.gmail.com>
	<CAMP44s3WkfAuPjJ5Z91Hjx7Vp5P2C7n5Wh+7Rd49k9N_n+SxkA@mail.gmail.com>
	<CALkWK0=J2_mAViDwu2MJNvLsUbVpoR68-sQR9fs=4of+E5wAjg@mail.gmail.com>
	<CAMP44s1RTm3LRaL71U1LQ=RvA1qyOSQKsk1ptXeNP-GRk3rVrw@mail.gmail.com>
	<CALkWK0=O0kp-d5pUNxMpAp4MzxORSod2H9wnMz37dLicm3mOZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 22:29:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpGM-0003yH-Sx
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 22:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab3DZU2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 16:28:54 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:47999 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161Ab3DZU2x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 16:28:53 -0400
Received: by mail-la0-f54.google.com with SMTP id es20so3953042lab.27
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZWGNshaKzbqlxF+Xd397DIgWNBMTvPB+bn3lbZgTgU0=;
        b=iUhOGYQI+4xq1qVoLGmk1sPIMM1f2ZqloqH+V6W92fgTIsqpf8U4x4jxH7gqkL8jPn
         OoIW2gk+gQbdoQLuMxy+o61pdSywp8cvQnwrskQtkt8Xku2/mGu/JLKpQZoyOmEczxWB
         d6H/UjgvfJj/QLa4j/YDTw2wC+vt9f/omFJ8s1vZhya0rTQyy9GHV8PhJsYA1gkdvYex
         vBWuNiofuniB+4ixp7EbGlefv5c8GU8X/Rd9ePO5WKUVytezAldi3OaKPj59pdyhIN4L
         /N2pUyDNNLmUINZK+u/en+hHlSh/ZjNatA80/WYC8HZmpeagvGfmUv91woiDk4RRaUDD
         VkkA==
X-Received: by 10.112.139.226 with SMTP id rb2mr21885767lbb.12.1367008131079;
 Fri, 26 Apr 2013 13:28:51 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 13:28:50 -0700 (PDT)
In-Reply-To: <CALkWK0=O0kp-d5pUNxMpAp4MzxORSod2H9wnMz37dLicm3mOZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222576>

On Fri, Apr 26, 2013 at 3:03 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> A fine way to start is to not rattle away in trivial inconsequential patches.
>
> I have something from Linus (TM) this time :)
>
> https://lkml.org/lkml/2004/12/20/255

I happen to agree with that, specially in the context of the Linux
kernel, but I don't see how that applies here. Linus is talking about
trivial patches from an entry-level developer, who has much to learn,
and this is one the best ways to do that.

But in particular, he is talking about the fact that prominent kernel
developers don't spend too much time on these trivial patches from
these entry-level developers, and that can be frustrating for these
entry-level developers, which can be problematic.

Nothing at all related to what we are facing here.

-- 
Felipe Contreras
