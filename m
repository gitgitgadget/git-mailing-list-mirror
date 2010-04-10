From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git and Linux tarball size evolution
Date: Sat, 10 Apr 2010 13:31:48 +0200
Message-ID: <h2u81b0412b1004100431o8c543d4di7b6489211d053c98@mail.gmail.com>
References: <r2l1454bf6f1004090933g4e58277dh51c731ca6b097a45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Victor Grishchenko <victor.grishchenko@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 13:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Yuw-0001j3-Fd
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 13:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab0DJLbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 07:31:53 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:59304 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab0DJLbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 07:31:52 -0400
Received: by yxe1 with SMTP id 1so1757819yxe.33
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=nNSiOVgCdHamzVQA5bvBSqTY+c1brZDDhU/8tGYNZZk=;
        b=JTVp2SunQfS4HgyZQcxTAdIlGInuNhcj6CwIZIpLdSHITmZwEbSXYSMSw2j8f+MRFC
         P+D/WjcTo8Gh3ncfMALoHE3eLwBuLmbX9+ybynLEQORqo1VR4HZrurVIett0PUFftMIc
         VL1h3XGnV13u2F+H8YHM1TTMEMSAvoY6uCQb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qLlq+fCfRYjxYzDVfaOKMqsHvGjgEsrGwz/OoVvODwOBzxvDHNJ7IYEVTdWWUuksg4
         unk/BjxRA9zEDYsYB7ArmmXleJJh14yRKqRRZ9B46JA3ZHVqAMG3YE2w6Ws88uJYu6Me
         1GV2MfUXCuAfA1NTsy7LSOij8LTw2eBTt5CeE=
Received: by 10.100.212.9 with HTTP; Sat, 10 Apr 2010 04:31:48 -0700 (PDT)
In-Reply-To: <r2l1454bf6f1004090933g4e58277dh51c731ca6b097a45@mail.gmail.com>
Received: by 10.101.197.32 with SMTP id z32mr1948942anp.201.1270899108597; 
	Sat, 10 Apr 2010 04:31:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144540>

On Fri, Apr 9, 2010 at 18:33, Victor Grishchenko
<victor.grishchenko@gmail.com> wrote:
> http://bouillon.math.usu.ru/files/linux-tarball-evol.png
>
> I plotted sizes of official linux kernel tarballs found at
> ftp://ftp.kernel.org against their dates. (Yep, the methodology is
> extremely dirty.)

Could you try using the sizes of *unpacked* tarballs?
gzip/bzip2 will offset the real growth a bit (maybe even a big bit).

> It is clear that git has changed the release pattern. But was it the
> reason why the development (and tarball size) returned to accelerated
> growth? Another possible interpretation is that 2.5->2.6 stage
> involved too much of reengineering, so "normal" incremental
> development slowed down for a while.

There were a lot of cleaning up in 2.5/2.6.

> Do git developers have any opinion on that?

The was Bitkeeper before Git, but also the development process
has changed, with Linus becoming less of nexus of it. He does
more merges than ever now, with a large part of integration and
testing done by subsystem maintainers and people like Andrew
Morton.
Besides, you cannot ignore the developments outside of Linux
world, which percipitate into kernel (things like new architectures).
