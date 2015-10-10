From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Draft of Git Rev News edition 8
Date: Sat, 10 Oct 2015 19:45:05 -0400
Message-ID: <CAPig+cQrJFEOSiNQ=Ls0XZJUQWre+_QniKo1RFofg7orj7ts4A@mail.gmail.com>
References: <CAP8UFD1a=1c2g9MfeSo1rPL7BFrFQG9RQY6OmdaJQtoL2wZang@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Stefan Beller <sbeller@google.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Karsten Blees <karsten.blees@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 01:45:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zl3pB-0001hY-QA
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 01:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbbJJXpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 19:45:07 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35816 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbJJXpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 19:45:06 -0400
Received: by vkgc187 with SMTP id c187so640651vkg.2
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TdGJm+5YYSLKxiAG1DQgH8UVfCV/C5Zx6cuVcALTwPA=;
        b=gm8vqSKHPka7QSN1UEJi1NAw2GM/AOmP7Eg+k5WOZTAInLNkz6dhhTju57qQTazVeS
         GMa6Li1y77MIle4G2ytxvoYhI98T+aliZQKojqaa8G+rJs76pZLUTy2qNYBQx4M2vViD
         w9sbnW2OScGKVeShkMYDoPxZDH98B6Nmz10sP/A8kRLGsPykFxqkR+l++e8MrpbKcV/X
         +0i8bU96h1Xfwx4Pj4mq5oWe1ZPgv9tTvhJoqCcH9QcNhqKspelFw79pGwndeKCC/iPg
         o3MOq0ZkeziZAZmrF8L7BD4bx/Wx4pSh4lO4DbwkUrXSNxyv1k+1zT4ytVpE62e2K9Bs
         aLVw==
X-Received: by 10.31.151.84 with SMTP id z81mr13881235vkd.14.1444520705099;
 Sat, 10 Oct 2015 16:45:05 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sat, 10 Oct 2015 16:45:05 -0700 (PDT)
In-Reply-To: <CAP8UFD1a=1c2g9MfeSo1rPL7BFrFQG9RQY6OmdaJQtoL2wZang@mail.gmail.com>
X-Google-Sender-Auth: AdYwcpoHJ3eh_FKzFFkj-hbZBp4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279332>

On Sat, Oct 10, 2015 at 7:36 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> A draft of Git Rev News edition 8 is available here:
> https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-8.md

Does Karsten's comprehensive post[1] about nanosecond-related racy
detection problems merit mention?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/278683
