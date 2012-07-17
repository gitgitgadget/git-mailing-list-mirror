From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [ANNOUNCE] Sharness - Test library derived from Git
Date: Tue, 17 Jul 2012 20:31:52 +0200
Message-ID: <CACBZZX6QZACjkFPEsNgAkKgnkZHDsCOEAm=-9rs=PLiSfgsXBw@mail.gmail.com>
References: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Mathias Lafeldt <mathias.lafeldt@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrCZH-0008Td-2b
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 20:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab2GQScO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 14:32:14 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:33798 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab2GQScN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 14:32:13 -0400
Received: by gglu4 with SMTP id u4so714146ggl.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 11:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YE/Q4m+La+IebvbwNxf0L1egiO3EFRRn5JpcDcUpe1c=;
        b=WzLDQ+cupHKaoy2ONEFJfZ99sILezOipKGezKAZvY+lWsbpWVzCDTg2Qevk2J8AGvP
         jyGQtmiYVAYgOpIbRySrTsXA8F6t7tLh5ztq4YjZiwkK8i9gPNcl94J05N+Gwsgv/me0
         EA0M/xCHa9LKDS2k6fpoK1r/1Ae3PaEkh5kjlv51nnKVCzWpEIDpGIr3mU5afeUYxp1U
         Db85z24Zi5nbqQwq7gAPFNhb6JnvN26nVz6QTbDAEZa7f14+DxCrHT1CIjg1sWPSd+LG
         uYQZh+ob0AkEvfqprtkppN/Qo2CMENxfPRH7UK1CrsDxZ677lIO+09jAnRLHzb8DtQES
         WxHQ==
Received: by 10.60.11.9 with SMTP id m9mr4851530oeb.5.1342549932592; Tue, 17
 Jul 2012 11:32:12 -0700 (PDT)
Received: by 10.182.133.38 with HTTP; Tue, 17 Jul 2012 11:31:52 -0700 (PDT)
In-Reply-To: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201618>

On Tue, Jul 17, 2012 at 10:06 AM, Mathias Lafeldt
<mathias.lafeldt@gmail.com> wrote:
> I've been wanting to announce Sharness [1] on this list for quite some
> time now, but never managed to do so. With the release of version
> 0.2.4, I think it's about time to change that.
>
> Sharness is a shell-based test harness library. It was derived from
> the Git project and is basically a generalized and stripped-down
> version of t/test-lib.sh (I basically removed all things specific to
> Git). So when you know how to write tests for Git, it should be very
> familiar.

Nice, I thought about doing something like this myself but never had the time.

Perhaps to avoid duplication we could move to this and keep
Git-specific function in some other file.

Do you think that would be sensible, and would you be willing to
submit patches for that?
