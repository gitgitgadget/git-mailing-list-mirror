From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] i18n: make the translation of -u advise in one go
Date: Thu, 11 Apr 2013 22:53:24 -0400
Message-ID: <CAPig+cRu7kAsfqftuoC0HDZ3fRTXLC4j21God4SRk67psWR=1g@mail.gmail.com>
References: <4003e29bb04b122897cefe2a8057266e2428dce5.1365734618.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 04:53:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQU7H-0001Ve-JC
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 04:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694Ab3DLCx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 22:53:27 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:34821 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3DLCx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 22:53:26 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so2059421lab.26
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 19:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=8UAmHUBE14egIaxv6PyW5woai+/LPVBH0gFLfVMjRco=;
        b=wiXeHbdtUuAL+ipUDl5Bx5E2cSuniWux25ZEtHjzfQgiGvRD7737bo1GW6te5rk/VR
         2yxX+Xjgm2HI5vBGv0bAL4vooF5wA8fiJWxxBgCwrVHJV1dTETIMTMM5gJIsfNymKbJZ
         eV0pTW8oQSXz55H2JiT3emcYyqoKxyQd/UJL9YAe3+erGfW7TvuWZorfEG+eaIHxxWBM
         37IkiOxWgOKvWxXqSW5qk05uEV18qzuAyfAJ1qMypqgbt/Bvtt7qlfWtar8tQfKdG9oJ
         opvw1iE05XPHLLm9FIZuG4SZVHFVN64iaHEW1/H8bzjLjGfBuM1/9/K3WHF047fCDAAq
         JJkw==
X-Received: by 10.112.137.135 with SMTP id qi7mr4438188lbb.117.1365735204774;
 Thu, 11 Apr 2013 19:53:24 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Thu, 11 Apr 2013 19:53:24 -0700 (PDT)
In-Reply-To: <4003e29bb04b122897cefe2a8057266e2428dce5.1365734618.git.worldhello.net@gmail.com>
X-Google-Sender-Auth: zRN1YYTerBNV42ZRDJ-r2i_KSXo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220946>

On Thu, Apr 11, 2013 at 10:46 PM, Jiang Xin <worldhello.net@gmail.com> wrote:
> i18n: make the translation of -u advise in one go

s/advise/advice/

> The advise (consider use of -u when read_directory takes too long) is

Ditto: s/advise/advice/

> separated into 3 different status_printf_ln() calls, and which brings
> trouble for translators.
>
> Since status_vprintf() called by status_printf_ln() can handle eol in
> buffer, we could simply join these lines into one paragraph.
>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
