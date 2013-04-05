From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Fri, 5 Apr 2013 05:45:13 -0600
Message-ID: <CAMP44s3eMe9O12Jp7LRoVYy-Hf_9+cuVTcex5u51yERj+xKO8w@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s02PUGctgacuGRw3p8uEXhowZJWJjdq0g9aO9bBbpnv2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Sat Apr 06 18:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFf-0002u6-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765819Ab3DELpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:45:16 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39699 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab3DELpP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:45:15 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so3589987lbh.41
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LIvFOzkuMySEJoDna9uSeGbXRoYeqeNZqcvbZSTCYQA=;
        b=Nhm5Y6N/+Ijn3yr7tipw9mZTVOHBrR5r8wj7M4FhhmzSq/Og890/+94Lss/Gt/xPUr
         rxZSqoqwNsUuSQ2Ey45nGmnwiDUbhm0eEFbO62ZKzPHRqSe9bGCVTZhEy0UxoxkvhhVR
         WXqwwbosWchjB/SY88GwN7701UzEHIz7HwQu+YfxoHVtTgOJAvTsEzLyb0DgARzvQla9
         l3LPmZ9mL+7C8FEJm4o2Dtmda+3PeSwcNciBQXUDcJ2oUdOoQRCCxLvX/LiWartJ8AZu
         Z4iZ6TvZeapbzBFpJB7a/9VvMQAyTItup3zFRaDN8jWB7WTdOv/ap9GstL2U4XnL8N2h
         WGbQ==
X-Received: by 10.112.41.136 with SMTP id f8mr5698358lbl.121.1365162314059;
 Fri, 05 Apr 2013 04:45:14 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Fri, 5 Apr 2013 04:45:13 -0700 (PDT)
In-Reply-To: <CAMP44s02PUGctgacuGRw3p8uEXhowZJWJjdq0g9aO9bBbpnv2w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220168>

On Thu, Apr 4, 2013 at 10:14 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 2, 2013 at 4:23 PM, Max Horn <max@quendi.de> wrote:

>> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.
>
> I will investigate the pros and cons of this, but either way it's not
> something people are going to immediately need (I doubt the
> semi-broken states will happen again).

And another one bites the dust:
https://github.com/felipec/git/commits/fc/remote/hg-noteids

-- 
Felipe Contreras
