From: Thomas Gay <tgay@tokyois.com>
Subject: Re: Crash when pushing large binary file
Date: Fri, 16 Nov 2012 15:54:04 +0900
Message-ID: <CA+AoP-keNcjGLtxbb9t7sggur1e+XmbMN5apVJfEdfhqU2-JGQ@mail.gmail.com>
References: <CA+AoP-n07k0r11O6ShOT8jHiX+TL+=p8sZoei+Gi+9gG_YyJqA@mail.gmail.com>
 <CACsJy8AAd0odtLDiZ+A+MhX1En_G97gF2uoHjVeJvekznY3JSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 07:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZFp2-00019a-1S
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 07:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968Ab2KPGy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 01:54:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:53317 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab2KPGyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 01:54:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so3180369iea.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 22:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=vgCuci4qzjlO7IQQj2EFXY8F2EvpFk+m6bN1C0aMNMs=;
        b=Sz8QJmc6UaHYSLbsqwAAhVMokDOGsLw3h6Zr1YEDjkRaD4VE6Ve/fxunMtwUL4UE/r
         QK1lmGOfLZGHaSN9HfY9M8F/5Q5TrIFHB6HTfbKSoMK4HtUBu1XkqNoh4VnNlrSvufGf
         E/jBXTpycazYv4YJE2ZlAzZiUnelo4yKm/IUGiUboRK2JxWE3pMXr7V5k8rhE4Mr8nUB
         bRHrK53NIxcNCf08dQYuGq5X7nX94GKxqWM00Igyy5zHjnIqmSUg1DqvgDb1e3fsXGFv
         CjfWt74EnfsoDuhuz446J4LhrYoJkMdBRiReGUljz59KuBbZhsVB2E5geO6YOVmlS38D
         l/Kg==
Received: by 10.50.178.106 with SMTP id cx10mr2323944igc.24.1353048865372;
 Thu, 15 Nov 2012 22:54:25 -0800 (PST)
Received: by 10.64.41.37 with HTTP; Thu, 15 Nov 2012 22:54:04 -0800 (PST)
In-Reply-To: <CACsJy8AAd0odtLDiZ+A+MhX1En_G97gF2uoHjVeJvekznY3JSw@mail.gmail.com>
X-Gm-Message-State: ALoCoQlCaCLP/JcJR1jUfoU30bjtlv+ajZa7nksJPSJK7PnqKsJdm7Rr4VI6Y1yV1c2Kln4YrSmO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209865>

Thanks for the quick reply!

On Fri, Nov 16, 2012 at 3:25 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Fri, Nov 16, 2012 at 12:44 PM, Thomas Gay <tgay@tokyois.com> wrote:
>> Using Git 1.8 on Mac OS X 10.7.5. I just added a large binary file to
>
> How large exactly?

2.46 GB

> If you set receive.unpacklimit to 1 on the receiving end, does it still crash?

Yes. The crash log looks the same too.

-Tom
