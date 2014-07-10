From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 22:43:53 +0200
Message-ID: <CAOvwQ4gbaK8x8fQ7DbHpSGmDuvW6bpvFLJRM1fDE21yPYhqOwA@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <20140710202318.GC15615@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:44:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LCo-0004JB-ES
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbaGJUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:44:34 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42043 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbaGJUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:44:34 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so154357obc.26
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GiMZ/ZNohX67px+F2KXGhtldenpFgJPyWQa8wZbk1WE=;
        b=y18AwwKExwVPASLOkIGvYAn+M5/RA1tRNDxJjL58HSOF5JP2GRCOAc/nx/VREGGizE
         KGXnT99DngzCSO937rwky2330bNpU3X6KawctC+9FBN7RrxsRmkuP+jKgjcXtY7Gh2bl
         Ld6VU7ajVNjlVknQ15ipkwxvvTBx5Sq4f9UZTi9uHxqdUIHjQIID/YNV+GQaoYa19c8W
         bu6Nst+ARZ1ytooYbwEK34gOUDhHNIHUJcGxn0Ib/oYopTs+Vziw/CDyHp5ajcLWxdne
         rwT5TENOrEBKpeNgyTOaUyyJMun1WhUypxUwel963wXzXHkPHbaAvLGOZtpOb+xAh7ff
         fOoQ==
X-Received: by 10.60.94.169 with SMTP id dd9mr57138242oeb.58.1405025073518;
 Thu, 10 Jul 2014 13:44:33 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Thu, 10 Jul 2014 13:43:53 -0700 (PDT)
In-Reply-To: <20140710202318.GC15615@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253214>

On Thu, Jul 10, 2014 at 10:23 PM, Jeff King wrote:
> On Thu, Jul 10, 2014 at 09:59:37PM +0200, Tuncer Ayaz wrote:
>
> > The changes in 745224e0 don't seem to build here with gcc-4.9 on
> > linux x64_64. Any idea what's wrong?
>
> Weird. It compiles fine on my x86_64 box (Debian unstable, gcc
> 4.9.0-10). Can you tell us more about your environment?

gcc version 4.9.0 20140604 (prerelease)

I normally use a custom config.mak, but I get the error without
it too, so it has no direct effect.

Let me know if there's anything to try out for finding the difference.
