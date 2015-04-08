From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] submodules: implement synchronizing of remotes.
Date: Wed, 8 Apr 2015 08:46:28 -0700
Message-ID: <CAPc5daWarayCBKyzrcNoh07RtPZhu4WjaT8QNsuHDtphxvz1DQ@mail.gmail.com>
References: <1428490705-11586-1-git-send-email-ps@pks.im> <1428490705-11586-2-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Apr 08 17:47:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfsC9-0007gU-I4
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 17:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbbDHPrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 11:47:09 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34780 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbbDHPrH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 11:47:07 -0400
Received: by obbgh1 with SMTP id gh1so136549659obb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aZp2x3Ua60jZ4Gc6Rn9/nFIr9Nq6LGjR6JJwdT6xIv0=;
        b=qHE4L/8ldMnFBubcqEfJgFdTpSIwSDIxpyo3SZ4bOIKsfDOY9tK1I1hv2YYr1NXHfh
         kFzTPLrx5Jex5GHL6Cp69Bi97KWlJmB3y+UF3f2iwD3ouEOCcgpOwGUf80qQZzBRggSA
         IFIZmedKYUyN7rxv01PXhd5JBNslkyrjqXmSie3lAaZNQoOxzG0801RP7jQXkBeFxPZj
         J9RxJ5KTdAq25mYDj0bg6RjwhGqX8QVZ+k9iD/b5wGW45iueyq37tHVo3vTYfnji3Q6w
         53CZeT2QYINDk6D34yfU/yQW7zmQ+H1bobsBmwGPzwTUMn+z+1ww+clwUx/+F76h8747
         rNCg==
X-Received: by 10.60.70.161 with SMTP id n1mr16126281oeu.28.1428508011204;
 Wed, 08 Apr 2015 08:46:51 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Wed, 8 Apr 2015 08:46:28 -0700 (PDT)
In-Reply-To: <1428490705-11586-2-git-send-email-ps@pks.im>
X-Google-Sender-Auth: Xh3ToocHSY12eOUCyNm7WW8RD20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266965>

On Wed, Apr 8, 2015 at 3:58 AM, Patrick Steinhardt <ps@pks.im> wrote:
> Previously it was not possible to specify custom remotes for
> submodules. This feature has now been implemented and can be

I am not going to say whether it makes sense to add this feature or not,
but I'll just react to "Previously".

Let's stop saying "Previously we couldn't do X, now we can".

Instead, let's consistently say "We don't do X. Being able to do X is a
good thing for such and such reasons. Make us capable of doing X by
doing this and that."

Some people even say "Currently we cannot do X. Teach us to do so",
which is equally bad but that is primarily because some people say
"Previously" and they feel the need to clarify which reality they are
talking about. Once we stop saying "Previously", they will stop saying
"Currently", and the world would be a better place ;-).

Thanks.
