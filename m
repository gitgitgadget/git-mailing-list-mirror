From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] i18n: branch: mark strings for translation
Date: Sat, 13 Apr 2013 14:29:43 +1000
Message-ID: <CACsJy8DK5U3XErjDYZJZ+RBywDypuDotc-cH=CYGcd9Pu=V4PQ@mail.gmail.com>
References: <d11a226dac05ea7e8ee1d6166a1be1acee360a03.1365819645.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 13 06:30:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQs6o-0004ak-6i
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 06:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab3DMEaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 00:30:20 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46300 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3DMEaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 00:30:14 -0400
Received: by mail-oa0-f52.google.com with SMTP id k18so1195928oag.39
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 21:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dH+pLlFlpR0c+nIXdKop8SJ2w317rikQ8WdHneJp79M=;
        b=naakaahk7Tpa/FNZEtm4/9ZjbFjoFf3g1LTwEOXFu/56BdWNpLDKY5nvdMwiBFa/uv
         2mIFJC2tNE/LnW57ebiZpp03zGFvchw8F+OaaD18fj6rRXEckeGfPCBFZTcKd7REZ4BA
         2e1O/9b9bo43iDPk3P+8n4x1WQbnPDZ6N8p3Bt/TZDDnPw4a0GKqupCqwtIXQH1kWX+S
         fco/wqpzz8cfp0es3x2oXEaRlIVlVmXMRiHnElB+S0Y7geoSl+ApM6nWFcJoWrMxpO2C
         PCmcCGvYMrov/Wz57AMSseyNBMz2SJbFE/GtmgPMYBWC4/1kV+D9A1RzfeJucmZc9PiD
         fNBA==
X-Received: by 10.182.204.5 with SMTP id ku5mr4890449obc.22.1365827413276;
 Fri, 12 Apr 2013 21:30:13 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 12 Apr 2013 21:29:43 -0700 (PDT)
In-Reply-To: <d11a226dac05ea7e8ee1d6166a1be1acee360a03.1365819645.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221047>

On Sat, Apr 13, 2013 at 12:22 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> diff --git a/branch.c b/branch.c
> index 6ae6a..c8745 100644
>                 else
> -                       die("BUG: impossible combination of %d and %p",
> +                       die(_("BUG: impossible combination of %d and %p"),
>                             remote_is_branch, origin);
>         }
>  }

You might want to leave this out. I can hardly happen in real life. If
it is, the unfortunate user just needs to copy it straight to
git@vger.
--
Duy
