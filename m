From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Versioning configuration files on a server: fatal: Unable to
 create '//etc/.git/index.lock': No such file or directory
Date: Wed, 24 Nov 2010 15:45:43 +0700
Message-ID: <AANLkTim_sPyVGK3XWEVseseRzcmNM-YS=aFSWZeBiB7n@mail.gmail.com>
References: <AANLkTikfg9fLtqC6V3hQkiSZ+RfWqViJsHPxrt6ycoRR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ilyas -- <umask00@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 09:46:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLAzq-0006vc-28
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 09:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab0KXIqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 03:46:17 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39373 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab0KXIqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 03:46:15 -0500
Received: by eye27 with SMTP id 27so5190357eye.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 00:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=wJvW/VTzxb/NrrGJs+tnT2Uu3slvR2tkKtd6d8SucMk=;
        b=MJX46OkuE93O3/6DLvj41qAU5/vzLEiZmzVXaQk5/D8rx39NmhOtlT3Yz9KIdIOYPH
         o6jsG+SP0bXHf93Qj8tOtd18+z7Iyjfed7Ft3XzqW3Gu+r5M1mSvALpho6ibianDvkoZ
         LLVLuQNB6LV1/tIP0TjWK8vnDUY+2H/8bX940=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=fS3L7o+Fh9q4lY+GlxiH6oVgBx/JIefW7xzExZiNzTLLoMEGyh7OTpzqrD7rDSUXq/
         b1rZfChNzWZryTNaCJPWsa05XYWmNe0EPZTbh864qAsthy2yVjpMLm/J0lBIM/wOYFII
         hB42ph4r6xq/9Imb97rTj9hiRbpbuN5nZh1uQ=
Received: by 10.216.255.148 with SMTP id j20mr7860886wes.11.1290588373934;
 Wed, 24 Nov 2010 00:46:13 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 24 Nov 2010 00:45:43 -0800 (PST)
In-Reply-To: <AANLkTikfg9fLtqC6V3hQkiSZ+RfWqViJsHPxrt6ycoRR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162053>

On Wed, Nov 24, 2010 at 3:01 PM, Ilyas -- <umask00@gmail.com> wrote:
> Hi!
>
> The patch bellow for problem 'Versioning configuration files on a
> server: fatal: Unable to create '//etc/.git/index.lock': No such file
> or directory' works fine on FreeBSD/Linux.
> Please fix this problem in upstream.

I also have another patch to fix this [1]. Hopefully Junio will pick it up soon.

[1] http://article.gmane.org/gmane.comp.version-control.git/161825
-- 
Duy
