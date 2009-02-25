From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig PATCH v2 0/2] popup menu
Date: Wed, 25 Feb 2009 23:32:11 +0100
Message-ID: <2c6b72b30902251432p18f7cb48sb5565cc200d5e3b9@mail.gmail.com>
References: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 23:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcSJy-0004Fb-02
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 23:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbZBYWcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 17:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbZBYWcP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 17:32:15 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:59144 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbZBYWcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 17:32:14 -0500
Received: by bwz26 with SMTP id 26so221983bwz.37
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 14:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cW2arLRbPivSXamgm8bwAK32+oS5dsPjtRr6Y83M5i0=;
        b=Gzz/yJZ0L8rgI1WXv2EeHyX4VVaAG+t8/sUvDY7Ndkis5AaS4ZDFHgHvCj6cgimdzp
         7cV1XF6tMHgFqePHLFEjJsXqbvMFkn+G1zcXrFnuhaqLu9D2K1erQUtb2fp1h1ocKbNs
         rKkyZFF9igY9rWTrOCnfsNiIZqpEtE6SOnP+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RT1wLDXdwVRVaBQRst4GZ2EApUak+cU3cBHOsEdNGb6BhE29dvWBfJXYyXdb59DrOc
         WUQVbg9IOepdpxihBFzzVcjootMRDa4kMzuioX5plqGnbkPBMc6V4saXZJGtgx7UG6jp
         uN0p9d2vJkhFuDMVeRch5iToQpBRQlVVX3GCY=
Received: by 10.181.2.2 with SMTP id e2mr198698bki.74.1235601131157; Wed, 25 
	Feb 2009 14:32:11 -0800 (PST)
In-Reply-To: <1235311778-11112-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111507>

On Sun, Feb 22, 2009 at 15:09, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Second version, in two patches. The first one is just the same as
> previous one, minus a couple of leftovers.
>
> The second one reimplements the menu drawing routine so that it can be
> called when necessary to redraw the menu entirely, e.g. after a resize
> or when background loading finishes.

I didn't read them through very carefully yet, so will "queue" them
for now until I get fully back to tig. There are still some quirks
that might needs to be addressed related with resizing, but this could
also be fixed later. Anyway, I would like to think a bit more whether
or not I like the cute menus, and also whether options might be served
better by introducing an option view.

Regarding the "tig branch", would you mind if I postpone applying it
until the branch view develops into something that is actually usable?

-- 
Jonas Fonseca
