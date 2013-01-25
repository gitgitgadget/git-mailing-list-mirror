From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 12:39:04 +0100
Message-ID: <CAHGBnuNWo_+HY9Vwrze+zxDS9zh6BBR4q6Av0q=TaDibHpaPzA@mail.gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
	<1359107034-14606-7-git-send-email-davvid@gmail.com>
	<51025D1C.2030307@gmail.com>
	<CAJDDKr4yb1-C9W1ZnKxHUk7WKpq-EN_YiR6diHCm5DVtQWzeCQ@mail.gmail.com>
	<CAHGBnuMPQWr8Z9jeQmHs7wFN5kf=MwBEEDy_M-QeY0mRnSke_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 12:39:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyhd4-0006wG-Pq
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 12:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab3AYLjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 06:39:08 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:55696 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3AYLjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 06:39:07 -0500
Received: by mail-lb0-f175.google.com with SMTP id n3so532085lbo.6
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 03:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MW+JfrdF8EbicCC1P5d9HwWtBJT5exJH2CtiMbw58kE=;
        b=Lh2OUiXsRQqZsjcqtiUB9oHF95PlINeSEIve4AP2X4voqRONFof5tJ18Cp97r94NUB
         ZtcwYbilasVkE/HUlY1zyu2Elwo/WrMRlIZWKIqsdNkqcYObqTd/PHHwUzatMy3FZApr
         aoFmHu3wQllmN9Z0FWLEtTiKmJwmvKzai1vcV1Mq2D0hxis/qdddasr44ebuICMsNajI
         D+zAp+P/7plO9GLlvy0VmMsgNzU5bMTsVxnNURcG7QoPjurYBsUlz/fTTJXLO2oh9ba6
         qlYoC0ZtsTLo5kC0yyCF2RyPV/vQ3KtJKFvkmXCejwowCjYX4UnGjVEBoAJRoPr/CyQu
         fglg==
X-Received: by 10.112.28.105 with SMTP id a9mr2050201lbh.66.1359113944359;
 Fri, 25 Jan 2013 03:39:04 -0800 (PST)
Received: by 10.114.22.73 with HTTP; Fri, 25 Jan 2013 03:39:04 -0800 (PST)
In-Reply-To: <CAHGBnuMPQWr8Z9jeQmHs7wFN5kf=MwBEEDy_M-QeY0mRnSke_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214546>

On Fri, Jan 25, 2013 at 11:34 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:

>> I thought Git did something sensible there like create a normal file?
>
> It does not. Also see my answer over here:
> http://stackoverflow.com/questions/11412028/git-not-storing-symlink-as-a-symlink-on-windows/11412341#11412341

This one might be the even more appropriate answer:
http://stackoverflow.com/questions/11662868/what-happens-when-i-clone-a-repository-with-symlinks-on-windows/11664406#11664406

-- 
Sebastian Schuberth
