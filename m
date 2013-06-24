From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diff-options: document default similarity index
Date: Mon, 24 Jun 2013 21:57:33 +0530
Message-ID: <CALkWK0k7VZxKx5OMvPE1wJ5qDxDp7BVVah8ajbmuhkvP+geLQQ@mail.gmail.com>
References: <1372072632-27313-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9co-0007lB-Na
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531Ab3FXQ2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:28:15 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54037 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab3FXQ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:28:14 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so25901709iej.29
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=plPXQvIoNCkQ+bIwn3KxCAfIk/90xqzgDwqroQIcNdE=;
        b=m5bhGmhBW68I80OTw9L4WoZWmAVzL0SbjicgUbpjkGVuCyLNZaI0NR3h6Z4i5PZLnV
         LNKgmWzBlAzlRbrPw1JeHwB1q7j1dwRfi/fM0SkESF9SipFBRncWSPrcNfsxC8OKwrWi
         v6kJmSkdWUy3CPhPl6711oTm5ayapgxfJ1c1fxNgvArmA6tcE0JOIwaOwaSq+GtomhoD
         YewwrJyb2LgS563QzbO9IQfy50c6xfWMbRLjkemODtyHRoknIAkIk7QGeUHX0iqrnbuV
         03BBY7gVEEsb8yxraLVpYBn875CnLwcUVGStvQXMF/AZsLLfOBxPnQc87OHXXL/9R5xF
         Qfgw==
X-Received: by 10.42.190.74 with SMTP id dh10mr12084196icb.35.1372091293821;
 Mon, 24 Jun 2013 09:28:13 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 09:27:33 -0700 (PDT)
In-Reply-To: <1372072632-27313-1-git-send-email-frase@frase.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228847>

Fraser Tweedale wrote:
> The default similarity index of 50% is documented in gitdiffcore(7)
> but it is worth also mentioning it in the description of the
> -M/--find-renames option.

Looks good from a quick look at diffcore.h:

#define DEFAULT_RENAME_SCORE 30000 /* rename/copy similarity minimum (50%) */
