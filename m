From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Tabs and spaces
Date: Wed, 20 Apr 2011 21:18:25 -0500
Message-ID: <20110421021825.GA23373@elie>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <20110420064318.GF28597@sigill.intra.peff.net>
 <d74e95d4-ef16-42fb-ae8f-b1d7a8b9d91e-mfwitten@gmail.com>
 <20110421000701.GA10987@elie>
 <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 04:18:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCjTa-0003UH-7Z
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 04:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1DUCSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 22:18:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63093 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab1DUCSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 22:18:33 -0400
Received: by iyb14 with SMTP id 14so1076315iyb.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KLpgqDvf3JK227bk7NVvC3S3M/vdASKbfEgtgBrmgyw=;
        b=r8xn5acgpBz+DIscr0BaXlu0hxPKU4G1qe/thyCCRx/aBJHxrpD9EDCmAeui3mU3BX
         kayeZA7FuEHnOT236thGhvuTiCkuDQ5MM3WxabxQe5gwqxMktXlX5nkStLpNQjta66ad
         ZcCXWA4+FCEnLtmgKxQleyXMxpKkf/GmImqbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wyd67/chR1TAzOEZJI/yf5j07zBNXSTba3964OeMAHSgfALi8rIhvwSSJSgoGPvVRW
         jbThk388twgluTXEqR7+RnvpbeciN8co/yYegqr+sXArjZe0lBtTMYdJ6YJgHQr2fa6M
         qAIyvDaiiBowHsvConcdrrq5HtZLOTzZD/F/Y=
Received: by 10.42.18.66 with SMTP id w2mr72821ica.169.1303352312403;
        Wed, 20 Apr 2011 19:18:32 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.sbcglobal.net [69.209.64.141])
        by mx.google.com with ESMTPS id i3sm578277iby.6.2011.04.20.19.18.30
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 19:18:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1235e29d-6cbb-445b-9b6f-4e174c03ba8f-mfwitten@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171889>

Michael Witten wrote:

> You just need an editor that [...]

which many contributors don't have (or haven't configured that way).
Really.

[...]
> However, with a tabstop of 2, it looks like this:
>
>   if (foo && bar && baz &&
>       qux && quux) {
>     ...
>   } else if (quuux(quuuux, quuuuux,
>         long_expresion_comes_here(quuuuuux))) {
>     ...
>   }
>
> Notice that your `qux && quux' line (which follows the method we both like)
> remained nicely aligned, but your `long_expression_comes_here' line has
> moved back so much that it doesn't even satisfy the `right margin' rule
> anymore.

Oh, I still think a tabstop of 2 is insane (for various reasons, some
explained in the thread you mentioned).

No matter --- Junio will use --whitespace=fixup to convert your spaces
to tabs anyway.  Just thought I could give some survival tips.

Regards,
Jonathan
