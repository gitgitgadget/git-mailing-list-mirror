From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] repack: rewrite the shell script in C
Date: Thu, 29 Aug 2013 16:04:54 -0500
Message-ID: <CAMP44s19gcJAYJ_MbvdoU99EeeHPDj9t+34jBs=MC33VC9nTNw@mail.gmail.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
	<1377808774-12505-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:05:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9On-00084p-HD
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab3H2VE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:04:56 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:37566 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756816Ab3H2VE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:04:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so506981lbh.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gqSTm8kpPc4KIkb6q/hBgoiqrC3IVpO1WDKhQyInjr0=;
        b=v/uozY6D0V5T6l/mpqhm2yzPpjgs6a59Qc9eME0GZLInrCJMAZwjwIILerzB9/mlkc
         asTY30om0Ie728yxWMIaYRWHnRq4Tf8QEbUzbzuMMPgnVPKKeUSqVAHocNvkixx1xBL2
         4HacwakbheCEVTp+q5+Nwrr+1UqHm2zyZ7NrOawxBCxdqjfa4ohdnQHU9n/wQoaCo+K+
         t8EZbS0CP/O6V0xmsR8bP+bt6iA3X+K/0Uoi8KX/UcliCR/wX7bOFfOTtiRU0nWDhg5z
         kChjgq035AvoZTzs6y2hJXldfKc9lx5YSwgwoho1pTWLzlcIPcPoVKiOzEkiu3aUatyj
         w1JQ==
X-Received: by 10.112.64.36 with SMTP id l4mr4751300lbs.15.1377810294779; Thu,
 29 Aug 2013 14:04:54 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 14:04:54 -0700 (PDT)
In-Reply-To: <1377808774-12505-2-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233361>

On Thu, Aug 29, 2013 at 3:39 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> The motivation of this patch is to get closer to a goal of being
> able to have a core subset of git functionality built in to git.
> That would mean
>
>  * people on Windows could get a copy of at least the core parts
>    of Git without having to install a Unix-style shell

I think this is great, I'm looking forward to improve the situation in
this regard.

Do you have in mind any other command that should also be replaced this way?

> This patch is meant to be mostly a literal translation of the
> git-repack script; the intent is that later patches would start using
> more library facilities, but this patch is meant to be as close to a
> no-op as possible so it doesn't do that kind of thing.

I'm not sure if this has been tackled already, or you could take a
look into that, but:

http://article.gmane.org/gmane.comp.version-control.git/147190

Cheers.

-- 
Felipe Contreras
