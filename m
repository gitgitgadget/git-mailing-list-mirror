From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v3] add configuration variable for --autosquash option
 of interactive rebase
Date: Tue, 13 Jul 2010 22:15:46 -0700
Message-ID: <4C3D4802.2010707@gmail.com>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org> <20100713112316.GA758@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 14 07:24:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYuS7-0001m4-CX
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 07:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab0GNFYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 01:24:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38587 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0GNFYI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 01:24:08 -0400
Received: by pzk26 with SMTP id 26so1515269pzk.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FQq1KEZFW7kluZj6huF01XrHcP89/gxB4n65XvXzx2g=;
        b=Cq5DrQp2SmwrgJ8loFzcYxzEUV44TFS4hq01GpF02YXh8fdyeqpxrAW7WIaSAbeTAY
         J6eQGlLnJaeUgZdJieWf492ZgyJ20L0A3h05FHl2IPXruN48RVlks0sGxo/a7aQNPzO3
         lBalal8yvhm8ao89zmEpEJZEd1IdqeajiAyGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Rg/+AQdpY+zrEoMZuFqqz5lZVyKgkicH/AWJH4S+jh2/wdKdVpzZZSoQgeqABrSklp
         ZDweiGXh16/MordAqYr1YOrRK9FOdv7FwZWNv93I3WJo7jdoO6rGF2ceZsD1v/x6J4jz
         j5Hxm47DicjLe9XTV8h/DE6JBxpQoSIEB/bLU=
Received: by 10.114.122.13 with SMTP id u13mr1780013wac.0.1279084554196;
        Tue, 13 Jul 2010 22:15:54 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id c10sm98170574wam.13.2010.07.13.22.15.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 22:15:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.4) Gecko/20100713 Thunderbird/3.1
In-Reply-To: <20100713112316.GA758@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150964>

  On 07/13/2010 04:24 AM, Heiko Voigt wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index be23ad2..d357ab1 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -199,6 +199,9 @@ rebase.stat::
>   	Whether to show a diffstat of what changed upstream since the last
>   	rebase. False by default.
>
> +rebase.autosquash::
> +	If set to true enable '--autosquash' option by default.
> +

Can you squash this in too? I know we duplicate the wording, but rebase.stat has set some precedence here on that one.

---->8-------

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 79d54e5..9e3c48b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1533,6 +1533,9 @@ rebase.stat::
         Whether to show a diffstat of what changed upstream since the last
         rebase. False by default.

+rebase.autosquash::
+       If set to true enable '--autosquash' option by default.
+
  receive.autogc::
         By default, git-receive-pack will run "git-gc --auto" after
         receiving data from git-push and updating refs.  You can stop
