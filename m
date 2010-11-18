From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/3] Improvements to mergetool-lib
Date: Thu, 18 Nov 2010 13:22:47 +0100
Message-ID: <AANLkTimERiT1k9VqkMuyiWH7Df_LZFA9MC7yOrFbHpk5@mail.gmail.com>
References: <4CE50290.90600@gmail.com>
	<4CE50DBC.3090409@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Nov 18 13:23:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ3Vv-0002Wd-Kz
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 13:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143Ab0KRMWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 07:22:49 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37575 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab0KRMWs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 07:22:48 -0500
Received: by qwd7 with SMTP id 7so34036qwd.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iYsYKoRtzxan4S/HUVUlhDQK/NrQ1v1FWiBkRCVC7Dk=;
        b=o+Qudd2X8euCMfYFM7aQ4vsaTM+s84tyhMFIVC6njyQp0lx6RXqTLrQUC80qyNk+0g
         x/t3QxC7vOGsue/ZSS48RxqzZ8u9KLVY1h9UyvGiwX8pU5Rx3T9aKOL2gD3DiilHGlSb
         52JW8CR2f1E5LR5bD5b3d4bb79afVQB58KdW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MD/yQPQoRubXJ9K+U88+2L8wK7aJepANPH5HgqD+IiQanVVMN5cyNnyKP1cqavt2ZW
         Xt2NzSM2VDpfbAahNTYe3zO316eA26VbEr9jh8XfIXZ2sMcr3p0jz2JXquuAqxHraRJT
         Bua0KboilOmYrFDyO8qNgU6tmA+V3gkfZvnB0=
Received: by 10.229.240.4 with SMTP id ky4mr536970qcb.104.1290082968027; Thu,
 18 Nov 2010 04:22:48 -0800 (PST)
Received: by 10.229.230.198 with HTTP; Thu, 18 Nov 2010 04:22:47 -0800 (PST)
In-Reply-To: <4CE50DBC.3090409@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161665>

On Thu, Nov 18, 2010 at 12:27, Charles Bailey <charles@hashpling.org> wrote:

> I'm not an ecmerge or Beyond Compare user. The reordering of tools makes for
> a bit of a messy diff but I think it makes sense.
>
> This series looks good to me. Has it been well tested?

Not on all platforms. I'm mainly a Windows user where I'm using bc3 as
a difftool and ecmerge as a mergetool, and it works fine for me. As
soon as I boot into Linux again I plan to test the patches there, too.
However, I'd appreciate if someone else could test, too.

-- 
Sebastian Schuberth
