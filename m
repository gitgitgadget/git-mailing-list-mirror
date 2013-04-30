From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 13:20:51 -0500
Message-ID: <CAMP44s28aQ7aDCBk=TwPJsb4xoyQMfx85DhaNB4P+XzbgctoPw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
	<CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFeP-0006nU-7o
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060Ab3D3Svh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:51:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34755 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054Ab3D3Svf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:51:35 -0400
Received: by mail-lb0-f172.google.com with SMTP id o10so842406lbi.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tjJuIN5KIYchS9hPKiLT0YtmD2LWcY20ym+LyZRgrn0=;
        b=gwLS81nnNcewQvdHSVTCaL1vr7JR/H+LEjd2MMdo4kU4Hq0Wc6LVkfHin7vaCGMd2d
         iDye9wjiwd0ZJv0/oROBoYNkomqIWla+8W+u0B2U8KLuAa6WIiTF407yQz9bD+8Qp0GN
         IULF/m+4P9uyC0IevO43Jfz6548cNdBrDEheySDeaxVsl8sLaW0Yr3Tk3uDmLxNoA+Kn
         b7iWcbIpb7XYclR/UZP6Slt6P6/1a728dMqKGDeic/BlqZvU+hEwLXFq/yr3Qv+GYKgs
         JmZLNSV1RfMliq1mGbkuYxhOrijZHuD6duByKmChu0W49vmQ0AFAYiOGPkk2AXGUmVJR
         POlw==
X-Received: by 10.152.20.134 with SMTP id n6mr17845179lae.19.1367346052153;
 Tue, 30 Apr 2013 11:20:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Tue, 30 Apr 2013 11:20:51 -0700 (PDT)
In-Reply-To: <CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222989>

On Tue, Apr 30, 2013 at 12:40 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>> If you accept only "@" but not "master@", that behaviour needs a
>> wrong world model to understand and justify (one of which is "@ is a
>> synonym for HEAD").  If your rule is "In $anything@{$n}, you can
>> drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
>> becomes master@, and @{0} becomes @ naturally.
>
> Besides, you're going in the wrong direction this time.  You are
> trying to fit an explanation to something that is useless.  How is
> master@ useful?

It's not. The same way master^0^0~4 is not useful, yet it's works;
it's a logical result from the syntax.

-- 
Felipe Contreras
