From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 04:43:05 -0400
Message-ID: <CAPig+cQqre7iW4DK+XSvFypng5sW=sK8os+ODz2kxYE8nkBw_Q@mail.gmail.com>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpre-0003mE-R4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab3DUInH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:43:07 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:44455 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3DUInG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:43:06 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so4730651lbh.41
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ExGnf3ppGj4SmbCYB8PtjNvaZ8H0QZGeIcQBesLjQeU=;
        b=ydqUCge4YbPodmxhetrE16/fniZxtrcSKNGr3zgTw+miQmmZzd4HKA2pdtYPJZhV/Z
         E90XQkz3PcI54KufeEcZhyDTfhyFaiKPp+/GIr5hsAGv2zqLiH8PDsgKj1LVeek0Hh+G
         fIGLHGcIPOa9aLQWr0PSa1Tql1XkKdZbbayGchvmgCoUjLAtOd2CEKF9HSdcaHWhvpw1
         8a2inBMwVsBUwoJCrr06+Gxtrowo61og+KxMvkDfYNA90rkPa98H14mxA4kNNpc6ke2g
         d0p0cpVcVzVUG9e5seWhu/wQTO3Gtz+KJSVusUE4hFoM+s6lsqgWg9z8w4TBZziUOxMd
         +6ww==
X-Received: by 10.112.209.38 with SMTP id mj6mr10356845lbc.52.1366533785124;
 Sun, 21 Apr 2013 01:43:05 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sun, 21 Apr 2013 01:43:05 -0700 (PDT)
In-Reply-To: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: MXQr4rNd6Im3sfSpjDJcxfq86aU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221924>

On Sun, Apr 21, 2013 at 4:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> When this option is enabled, the prompt gets totally screwed in zsh
> because all the codes start with % in zsh (like they are \ in bas). So

s/bas/bash/

> we need to escape the % character.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
