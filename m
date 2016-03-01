From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] Documentation: reword rebase summary
Date: Tue, 1 Mar 2016 15:01:07 -0800
Message-ID: <CA+P7+xp-YZJQh9=kHKnTEo-_k4xxniykH7pJ1neYbOS9em4N_Q@mail.gmail.com>
References: <1456872598-32571-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>, pdewulf@lyra-network.com,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 00:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aatIK-0005Zw-Oi
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 00:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcCAXB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 18:01:29 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38222 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbcCAXB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 18:01:28 -0500
Received: by mail-ig0-f178.google.com with SMTP id y8so30016879igp.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ktOXO3k/zaPwLMtGyAXFYwMj1Bzyg7XKDLIBPt4uFFM=;
        b=oey1IuVGuSe3jMKpTbg33XLlfLKeez38gp2zENmtWtEU49iJt/lSJS+OxtSzqj1Npn
         UF3PDCCyoZTSK77QCbdlGzk163jPhtGieHfUMeaM7dH7CFL6PN0+Y0C8aFCZXdoWcf36
         pYJ1H6m8dooCJ6vwlccTTpVxkeD+hpILR65kLuLsTAB7ScPj507eaEUeBe9XidVoyDGv
         EzqdDTCPAReVfROsV6sRFEpfRr7TlxtZeADSSmWs9il8MBnQy/YYV/3BFAGtfhCYZmMq
         EOHiGNOZ9s/XVyZsH0hTFVD9ZYbRAiB/c/NQtVuFzAgXMLwVcArOFYOj568sMp72WLJS
         PE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ktOXO3k/zaPwLMtGyAXFYwMj1Bzyg7XKDLIBPt4uFFM=;
        b=f9egqTB6YTF8uTrEJHWdbx5RdOTq/ETxqguadK/jOpIx6bkytDFsQe6rc7sGot7mR8
         9b/FAHJD5OWiD1lDBhnugRA3gVIJTsgKazuqFtQnxa878PrQkkVCPeF2I0TJnTQIkWE8
         hzDqoBdk0UWc+nqTETF+/VWbifb0wkNcZ9XODM4a+kl03/iMkS0JnU7A34TRHEIU2JrD
         Gycg65aCB/oKw9tdCNpSkxbeb1KIuAXHydMm/826P6BxqjNW2Wl1ete1XC8h/KPxS7d+
         MlHReg+Rd5vkFRwpDJQpczvIJoZY5Antmm9Q1HC8o6ajhFEm81mu2e+/hb/MAg0+isx8
         WiZA==
X-Gm-Message-State: AD7BkJLNscnd+bTea8o60DK3CH8KU1XGkIEK9UVd0CoDf60ozbsGk4fdYM56DlBbof6z99tUC8CWk0v8kfXiwQ==
X-Received: by 10.50.43.168 with SMTP id x8mr1633580igl.92.1456873287216; Tue,
 01 Mar 2016 15:01:27 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Tue, 1 Mar 2016 15:01:07 -0800 (PST)
In-Reply-To: <1456872598-32571-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288076>

On Tue, Mar 1, 2016 at 2:49 PM, Stefan Beller <sbeller@google.com> wrote:
> The wording is introduced in c3f0baaca (Documentation: sync git.txt
> command list and manual page title, 2007-01-18), but rebase has evolved
> since then, capture the modern usage by being more generic about the
> rebase command in the summary.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Inspired by
>  https://medium.freecodecamp.com/git-rebase-and-the-golden-rule-explained-70715eccc372
>  (I tried to cc the author, but I am not sure if I got the right email address)
>
>  Thanks,
>  Stefan
>
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6cca8bb..6ed610a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -3,7 +3,7 @@ git-rebase(1)
>
>  NAME
>  ----
> -git-rebase - Forward-port local commits to the updated upstream head
> +git-rebase - Reapply commits on top of another base tip
>

Seems like a reasonable summary to me, and definitely more fitting of
what rebase does today.

Thanks,
Jake
