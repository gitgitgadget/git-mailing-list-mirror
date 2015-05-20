From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 0/5] group common commands by theme
Date: Wed, 20 May 2015 15:31:02 -0400
Message-ID: <CAPig+cSDR2qCGbAgzFm40qmBGf7cvR_ougvH9Oq-phv_q0ekNw@mail.gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:31:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9hs-0006lC-9b
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbETTbE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:31:04 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:32910 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbETTbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 15:31:03 -0400
Received: by igbpi8 with SMTP id pi8so142983737igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=kmIV54DM/s7ohfxxAgmjcPp6/7oiTNKo7y0US5Ikgcs=;
        b=DJuBJ2DdWYRBoe68eGHrqmC/Orqj06rAAu/u6h86UWGYYPKyhFRwca6a9AQ9V7ECsU
         okMv0D/cmW1H+FS8VHCgggifTsi2krn4ocI4ZR7PUCp/RkD68aeF7iuJPGfEiY7x4AWl
         7RDWsnsU0Xtp8NYeWspprlXNsyFUoj92CEZG4FoYVWkPaE8ffBK1T9Gy/6ykIPRVofCO
         ELpAyJq569URwT6WzfBPortxAKG3uboZoWFgZYqayQytBRFevHJsbnb+Jt+rLWO2+ubZ
         YmjFsX5JZkfquTvyDIt1ycqKjhh5y2/kbLutymqJVUiRBC5pcNqJTPbF4Vc6K3FSfcWt
         oIBw==
X-Received: by 10.107.151.75 with SMTP id z72mr41357726iod.46.1432150262346;
 Wed, 20 May 2015 12:31:02 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 20 May 2015 12:31:02 -0700 (PDT)
In-Reply-To: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: nb9IzRJ3M_HmTK0qU_o2MIZh0ss
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269503>

On Wed, May 20, 2015 at 3:22 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> The major modification of this reroll [1] is the use of the perl vers=
ion
> of generate-cmdlist instead of the awk one.
>
> help.c:
> 1. change the introductory message from:
>         "The typical Git workflow includes:"
> to:
>     "These are common Git commands used in various situations:"

Which is just a longer way to say what the original said:

    "The most commonly used git commands are:"

I don't care strongly, but the terseness of the original has a certain =
appeal.
