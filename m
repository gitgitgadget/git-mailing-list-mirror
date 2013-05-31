From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Fri, 31 May 2013 03:14:33 -0500
Message-ID: <CAMP44s1z8CvF_K4uTn=p2c2pbjv8TKRyMo7QXR2CAqopOnyg_g@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
	<CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
	<CAMP44s0peXDtFB31pEqF49xM8z5OtDKAWaOR65aZSkCndL2bhQ@mail.gmail.com>
	<CALkWK0nVDBv9bfFpAJ+pzON-uD_4HQ0Bcg=CN32fgFvNJnnjgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:14:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKU1-0002XQ-VG
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab3EaIOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:14:41 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:45481 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3EaIOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:14:35 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so1093675lab.20
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l0W02ExGes6YxWKWV4wonSBEUF6nC5iGOGqjjKcUBAc=;
        b=WYyuMSR6s0JF2+lqLnUUfa9yfRwgpAzpL9gaX9PMOq3mIqwPPeqA2kd3KHuvR55yUJ
         vEwA9+SCzLjlqCTfjOJbRC8etEzLEq4OW+l3eoRxDZzWcZs16FMLu8rGNKeP/vD5pMNj
         oksKa0qTsNMfBrUf5DHAtb2Zp7PE1K5D+dAAop67AvjMXP9dtLW6fuixGdPOJXcq97vT
         /ItdQrmkzwVqmGKgmiSzplijkahxd6A41OIL6mPhXqzJDyLKMkY8O4U3MfrjePBUhSjo
         EeIUTW3Irca1EV1z0Wj6QWyKSV81e8f3sTsmSqTh122zUy63jbxaNisC+hL9t8wBYYCE
         UH3Q==
X-Received: by 10.112.133.129 with SMTP id pc1mr2440804lbb.49.1369988073887;
 Fri, 31 May 2013 01:14:33 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 31 May 2013 01:14:33 -0700 (PDT)
In-Reply-To: <CALkWK0nVDBv9bfFpAJ+pzON-uD_4HQ0Bcg=CN32fgFvNJnnjgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226074>

On Fri, May 31, 2013 at 3:03 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> I was going to make these stylistic changes to make you happy, but
>> then I realized the only that does really make sense is to change msg
>> = nil to msg = false, and it's not even worth to waste a thought on
>> changes like that.
>
> We don't have existing Ruby code in git.git to follow, so what I say
> can obviously not have more weightage than "personal opinion".  Don't
> do things to "make me happy"; I am nobody.  Have a good sense of style
> and defend it instead of flaming me because you thought I was stalling
> work.

I already defended the style, only to hear the same comment again in
the next iteration.

>> So I'll move on to the next patches, hopefully Duy or Junio would have
>> some comments of actual significance, or maybe you would too, but for
>> the moment it seems pretty clear you are only stating opinions about
>> what Ruby code-style you like best.
>
> I've done reviews of several iterations of this patch, and stylistic
> comments were all that I had left:

When a reviewer reaches that point, (s)he usually says: other than
cosmetic preferences: Reviewed-by: me.

-- 
Felipe Contreras
