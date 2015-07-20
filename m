From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] doc: send-email; expand on the meaning of 'auto-cc'
Date: Mon, 20 Jul 2015 14:34:05 -0400
Message-ID: <CAPig+cQ7y0wdAEhUGS6piGWs=qEFQ2cXCFcFSD1dcnpbBppQ0g@mail.gmail.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 20:34:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHFtF-0002fl-0p
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 20:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbbGTSeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 14:34:07 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35098 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbGTSeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 14:34:06 -0400
Received: by ykdu72 with SMTP id u72so145815651ykd.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0byuoH+evuSHJeh6M62tppk2IDxLH0QOidMg51szo+k=;
        b=MHcW0dkS9We1QdAa8v8rhMdSo70kQnY/kVH47iVz2P/Fzt5rDBEgWVr3GG4hNkpFKc
         2G05WmnwoPQwnJhUDXqEV1fKHeo7IgWAiP4Vfvy/t9oHLQtkI2mjYKux+/THguE+n4C0
         GZEYSPQCo9Ndx4j0pU8+tC3viJWzxo2CVkidj1QN1eYmeEaSb5FD4xxS8nWOuHrajcjo
         kh2qDe0l3z32N1hXpTmn1zUcoxaIdNRiIws0z8ze9t6u41RQ/zadRZkvEVd4xC5Q2Yu7
         HVHcamPrl41ZVJid3L3Frs6zcoekkd8dw9hx9RSQRbDKdjRBlDE6b1yOzwwqN8p02Iu3
         l1XQ==
X-Received: by 10.13.192.132 with SMTP id b126mr29384203ywd.163.1437417245653;
 Mon, 20 Jul 2015 11:34:05 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 20 Jul 2015 11:34:05 -0700 (PDT)
In-Reply-To: <1437416790-5792-3-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: AvrVjTLj1z0WDXevsCpbIXzHZKs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274346>

On Mon, Jul 20, 2015 at 2:26 PM, Philip Oakley <philipoakley@iee.org> wrote:
> doc: send-email; expand on the meaning of 'auto-cc'

s/;/:/

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index bc357b8..ddc8a11 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -282,7 +282,7 @@ Automation options
>
>  --suppress-cc=<category>::
>         Specify an additional category of recipients to suppress the
> -       auto-cc of:
> +       inclusion of addresses added via other automation options:
>  +
>  --
>  - 'author' will avoid including the patch author
> --
> 2.4.2.windows.1.5.gd32afb6
