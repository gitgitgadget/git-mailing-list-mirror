From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 09/13] exclude: filter out patterns not applicable to
 the current directory
Date: Tue, 12 Mar 2013 19:13:02 -0400
Message-ID: <CAPig+cTjmEVpr7gK4wp_+mvO9AHUenvpzGAy2wGht=HB+quvLQ@mail.gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
	<1363093500-16796-1-git-send-email-pclouds@gmail.com>
	<1363093500-16796-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 00:13:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFYO4-0006SG-GH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 00:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933659Ab3CLXNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 19:13:08 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:58796 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933548Ab3CLXNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Mar 2013 19:13:05 -0400
Received: by mail-lb0-f177.google.com with SMTP id go11so431119lbb.8
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6JT7MyTk3nP+8d3ZiJtWlmLzYiib+g71ZaA5Pig7L2Y=;
        b=tE2WWZ+SOU6ZMYeY/zsHYDGOts8Ft2rjFk4P6A0WyR7ZWZDDssDWQd7sGo+rUqvROF
         KbQUwEJ9r+nsLtz16iHHavqc5L9Q5ge/h4rgDlrg2lwR+hLNeTjWQ/XyaUH+S4QON1u7
         TPFBlF0OpTLJw95bKtulDWBb3qpDXdWTmX/h/L8+QqFYrGdikucWbRBtngT27TDOIvdJ
         nI1Tc9DgPpY2I3VNUudutCSrKNoWz7agbpkK+g9j5Erd3U7PZuzl7os7de5AEwkXbekg
         ABi3kxt3hgVGPCS9XUy1J9l+IdXewJZLEA1D+6BIENxgv68XfCAEycYb4mV91+J3fJER
         NbDw==
X-Received: by 10.112.88.35 with SMTP id bd3mr6931369lbb.56.1363129982793;
 Tue, 12 Mar 2013 16:13:02 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Tue, 12 Mar 2013 16:13:02 -0700 (PDT)
In-Reply-To: <1363093500-16796-10-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 9iNRwA3OmXF4Yqc8mICNteegolc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218008>

On Tue, Mar 12, 2013 at 9:04 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The algorithm implemented here is a naive one. Patterns can be either
> active or passive:
>
>  - When we enter a new directory (e.g. from root to foo), currently
>    active patterns may no longer be applicable and can be turned to
>    passive.
>
>  - On the opposite, when we leave a directory (foo back to roo),

s/roo/root/

Also, perhaps you meant s/On/Or/ ?

> +/*
> + * If pushed is non-zero, we have entered a new directory. Some
> + * pathname patterns may no longer applicable. Go over all active

s/applicable/be applicable/

-- ES
