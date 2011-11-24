From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 12/13] credentials: add "store" helper
Date: Thu, 24 Nov 2011 09:29:36 -0500
Message-ID: <CAPig+cQ_eP0wG=AFB0rt-SueW-XxrFXKYAXr+4PneYC-dciyuw@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net>
	<20111124110756.GJ8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 24 15:29:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTaJ4-0001Cm-Tp
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 15:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab1KXO3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 09:29:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48908 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab1KXO3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 09:29:37 -0500
Received: by iage36 with SMTP id e36so3061121iag.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 06:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=X82NtYRFbwHbB2+1fPI3ktwOcJN/NFrj40aR61sk6kg=;
        b=XRsFt/M+Rh31euP3ioYw1ppd1gAREfbB4zAliwasWT7GSUiju+er6RgMjs95u747a7
         DZxgEubNZ1TUCz4bF1xUaCYmgtyoY9VDIHt0wvSZNdERy2W8WJrWWA7bDzBhfFGoLwdY
         p5QSB/eedUpq0GO+ETYepb/YSGJ3RMIRQI1Vs=
Received: by 10.50.85.129 with SMTP id h1mr33081310igz.47.1322144976628; Thu,
 24 Nov 2011 06:29:36 -0800 (PST)
Received: by 10.231.105.1 with HTTP; Thu, 24 Nov 2011 06:29:36 -0800 (PST)
In-Reply-To: <20111124110756.GJ8417@sigill.intra.peff.net>
X-Google-Sender-Auth: U0i9xrYs9L8t5V45Z56GYrI4fRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185914>

On Thu, Nov 24, 2011 at 6:07 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
> new file mode 100644
> index 0000000..3dcffbd
> --- /dev/null
> +++ b/Documentation/git-credential-store.txt
> @@ -0,0 +1,75 @@
> [snip]
> +The `.git-credentials` file is stored in plaintext. Each credential is
> +stored on its own line as a URL like:
> +
> +------------------------------
> +https://user:pass@example.com
> +------------------------------
> +
> +When git needs authentication for a particular context URL context,

"context URL context"?

-- ES
