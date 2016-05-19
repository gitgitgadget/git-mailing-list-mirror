From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 14/21] i18n: rebase-interactive: mark strings for translation
Date: Thu, 19 May 2016 13:49:45 -0400
Message-ID: <CAPig+cRWn+6B-+ZLEX03okOSt76iww1vzP+e_FoQZVHarCrW_Q@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu May 19 19:53:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3S51-0005Hs-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932873AbcESRtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 13:49:47 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33410 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbcESRtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 13:49:46 -0400
Received: by mail-io0-f179.google.com with SMTP id t40so24800482ioi.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=F8DA4e6LFA54AAuza1r71dTGkQ1Un95ngJ50z85xF+Y=;
        b=RZR2ewhsOGvV+LBSXLkaSu4qg0Q/55j5PgKq3FNd1LS7379YpwBA6Y078O0cbLpluC
         dVJD2ur/0qjHrwAhWSxoHp0J8+6Mm1/8VGsrBiIo4cw2sw8ucvKIVy/U7eQjQSKeYwcn
         MT91HnPQWIcwdjUVB0G/i7zFgEDJN6baT7LHaw2y6lQCPsHbBQxXNEl0U2E14a0o5sKs
         SD3Fb8wDJ7bK9R56Fv6cDTjdDO/n7WmE1trmf7xnclEsbtXxYK+jRpeZNgg2a2m9FrX7
         n2WaiVD6auNK/qBHiQQ+0vABwHmhkAYu7GSZc1xF5UMJSaecIGdqbvGpr5fbrqvCYv8Y
         4+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=F8DA4e6LFA54AAuza1r71dTGkQ1Un95ngJ50z85xF+Y=;
        b=O5dajitMHfWJG6vFRAqQg5oQ6adjYQoNLxEKOZQu2T/DxPcBmpSSng8gt7jSXoCd+X
         swqqnpZMD8zSdxRnCYpRAoGiUXlJCP/8MRACOYTMSNBBT5YVmfqsHPXQ/tmRxhGKJx05
         jdNxi1HLCa77M69J4aw17kbO8bPx3nctZB/1BbQDPHUU+ctotHK66Hbcdfwc921CLeEw
         h7aW5jTkxU4QaVVvHlmKefMrW1xdBmPiaCdspMzsaqtA79rHfnz3BxS2HUwEW5HSRSbt
         i4i/we5z8Alyd6kb1bTCYqwYcNeql+ftDtdMe8rLZ7ssOxRcxWlxz2mF5boA3oCs9r53
         I1UA==
X-Gm-Message-State: AOPr4FXlcRJkJHoGz5s94fLwYp25lIEgyJpQyNmnwNpoYi8j/jvrBP8eLtB4waLahBtR12cIe9AO4YEt7oFcrw==
X-Received: by 10.107.47.37 with SMTP id j37mr10394591ioo.168.1463680185401;
 Thu, 19 May 2016 10:49:45 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Thu, 19 May 2016 10:49:45 -0700 (PDT)
In-Reply-To: <1463585274-9027-15-git-send-email-vascomalmeida@sapo.pt>
X-Google-Sender-Auth: PEq0lv-ajfDnv6YhCenRg287cmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295082>

On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> Mark strings in git-rebase--interactive.sh for translation. There is no
> need to source git-sh-i18n since git-rebase.sh already does so.
>
> Add git-rebase--interactive.sh to LOCALIZED_SH in Makefile in order to
> enabled extracting strings marked for translation by xgettext.

s/enabled/enable/

> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
