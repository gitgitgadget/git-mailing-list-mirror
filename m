From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v5 1/2] mergetool--lib: set IFS for difftool and mergetool
Date: Wed, 20 May 2015 11:04:22 +0200
Message-ID: <CAHGBnuM4CcT9FVKJapzvvtrvFV6SxaGJKgzRtqQDNRroptH_Rw@mail.gmail.com>
References: <1432112562-400-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 11:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuzvR-0001Y9-LE
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 11:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbbETJE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 05:04:26 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37355 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbbETJEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 05:04:23 -0400
Received: by igbsb11 with SMTP id sb11so34701511igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iU2zIunXLqmhr2X+0MdZg2PTNRdiYF3uDeILeqD8LJc=;
        b=g35B+kL2dlsWgb5/aPR3jOkHXbM2cGxvHlYn283oN6NTSPfJcU2ZVnv1kfy5+kSMCq
         qXGOtCc4Zd1jWAr+4VcXj899EugX2mVjNo4GWaFvlflTiHP004iu70Xqf2Zsdgxnq4RS
         9jYTi5AuIaJ7ExARyasqDOQlNBNeg1yphivR8XeXWMAg5sRjqw+1hYquGLstyZtwtB/X
         UZLEfz/89JNB/EgXtTnpPr4RLjbHHkhafrXRwiEAKWw/i9HNU0GzSZyKYSLa/vRZROGV
         Kr3u7P+HGb0XLs1UmCLTJzATQdwoXirrkwa3PKLCdP8Ggedaxzb42pkEnkLVmXQAGyPr
         DzWQ==
X-Received: by 10.50.93.69 with SMTP id cs5mr5981510igb.4.1432112662430; Wed,
 20 May 2015 02:04:22 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 02:04:22 -0700 (PDT)
In-Reply-To: <1432112562-400-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269455>

On Wed, May 20, 2015 at 11:02 AM, David Aguilar <davvid@gmail.com> wrote:

> git-sh-setup sets IFS but it is not used by git-difftool--helper.
> Set IFS in git-mergetool--lib so that the mergetool scriptlets,
> diftool, and mergetool do not need to do so.

s/diftool/difftool/

-- 
Sebastian Schuberth
