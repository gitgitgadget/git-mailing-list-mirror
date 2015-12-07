From: Stefan Beller <sbeller@google.com>
Subject: Re: Problems installing git-for-windows
Date: Mon, 7 Dec 2015 10:52:31 -0800
Message-ID: <CAGZ79ka_Gwz20WN8g6Akcm7btuLy+A-S+-kBjenN6-w6E1BRhw@mail.gmail.com>
References: <323868295.20151207124400@ptoye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Toye <git@ptoye.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 19:52:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a60tp-0001pE-PP
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 19:52:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbbLGSwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 13:52:33 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38894 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbLGSwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 13:52:32 -0500
Received: by igbxm8 with SMTP id xm8so89651775igb.1
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jZLoOypP9mz3Z6J0J1TqQcG2vN6EMsZi7/1aznjRsZc=;
        b=VepfQyyJUkXyLQ6K4JIL4seAE8W3FvWR4shR11EV5we15LxgZ8H/tp0wNY6epJA4zt
         2nKxUrAkq6d6OG+hsbo0pM5UIBpiHXKYfHDeVJkY7D+ig5TQo85Nh2XVNCGowMqd4LtZ
         n4+cnlKdkyUkamNPuREFRWMPyRJb25ccPuoE/KRwarP0ZziPND54OeWxnuoELmKNY+dq
         OOqBIlZGjOv8GSZxnctPK7jeDffGz5heBFXYGECnSHbEkqPO6coKtFci3SGDG2IjidYF
         1aPhIRlI77XgWkkzI5GKQI7IdBUSOIztaIVCouamHVfTlla8r04DXCNzHW/NE6WrTLww
         XriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jZLoOypP9mz3Z6J0J1TqQcG2vN6EMsZi7/1aznjRsZc=;
        b=dgKPkTlYDd+y7Es9J3DpDvDmKfWY3TOeLnlHLfOFjQmyXcmjpIMZLfMAlQlGZtZgkf
         RLF2MsYEbynNJImB3MT5oR66rckO/Vj/jxDwSydqU9NuvpUBbWzzXWnfwO2RQyw9cXl5
         wcjhj/dBv01uvMenCaQiTtkhdI2pooFP7mlCoieJBEMmjDTMhZvkuSI9VQSvtQvN70Ca
         IpmIHh5dU4PmJbeQDMDTs66spLCq/Sgu31eYDx389FWm0GdoX+GdGrM3ACt4ZMIE7MYO
         UhhmMe43/nGayhqAiDSaFRxJqGrtGdkMLncnbutp0k/ObdSd2uXdjPrA8X+VrZiba0Kq
         yJZQ==
X-Gm-Message-State: ALoCoQnSxXHVqb5fURKcX1Q5J99T4Y76Ew7nR1KPo8JGHhCJUH+EB0Vym0psg98tLnIUprIJ2caOFZaU9zvnF8GaAyOTpgQlQoVN/ycfSKGcRau1ZpELlPI=
X-Received: by 10.50.20.8 with SMTP id j8mr11468091ige.94.1449514351496; Mon,
 07 Dec 2015 10:52:31 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Mon, 7 Dec 2015 10:52:31 -0800 (PST)
In-Reply-To: <323868295.20151207124400@ptoye.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282104>

+cc Johannes

IIUC Git-for-Windows specific issues are handled in
https://github.com/git-for-windows/git/issues
instead of this mailing list.

On Mon, Dec 7, 2015 at 4:44 AM, Peter Toye <git@ptoye.com> wrote:
> Hi,
>
> I've just downloaded git-for-windows. It uninstalled an earlier
> version that I had (about 5 years old) and I got some problems.
>
> 1)  It wanted to install into my User directory instead of the
> Program Files directory, which is the best place for all programs.
> The installer told me that this had access right problems, so I
> installed it into another directory. It seemed to go OK.
>
> 2)  However,  the  icons  on  the desktop pointed to the place that my
> previous installation had been ( C:\Program Files (x86)\Git ) - that's
> where I'd have hoped that the new installation would go!
>
> 3)  I  uninstalled it to see if a cleaner installatoin would work, and
> the  GIT-GUI icon didn't disappear  from the desktop - minor bug I
> suspect.
>
>
> Regards,
>
> Peter
>  mailto:git@ptoye.com
>  www.ptoye.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
