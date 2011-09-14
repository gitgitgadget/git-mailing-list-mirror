From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 18:23:16 -0400
Message-ID: <CAEBDL5UJLLzpSsop9OzLuTyohZ4y854js-DfDM3dY+5DtDgx9Q@mail.gmail.com>
References: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
	<CAEBDL5UprYM0=SgNQrsY8_aCGf+pxKc1NP0AFjJy8igzt3vDZQ@mail.gmail.com>
	<CAG+J_Dw-vf7FtyT-vPpj-LHBo0rCBJi39bHh=8vWjc52QBMM2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 00:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3xrd-0006w9-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747Ab1INWXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 18:23:18 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33308 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab1INWXR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 18:23:17 -0400
Received: by qyk7 with SMTP id 7so2292307qyk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 15:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=x2/id2mLt1y2lJD6PlTKtZRz8qk9gFNbmeoDUIlbOAk=;
        b=MUvZ/1e4r+FZqOwQlrHIYDvhWwfQrAyIPUm39vuWEp6dUOIy4bZ8VBshnw2JPvSIjT
         Du3HnoZKLTHfOpBxFQMPByA87P7T5pNBdXfaJtNKDRWLCfgPzi4pvw/S/FMPqcmyIxRF
         umVoHOzjImyEuK5+ylsMeKR+fnT0vv5ohnaS8=
Received: by 10.52.23.130 with SMTP id m2mr349483vdf.191.1316038996986; Wed,
 14 Sep 2011 15:23:16 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Wed, 14 Sep 2011 15:23:16 -0700 (PDT)
In-Reply-To: <CAG+J_Dw-vf7FtyT-vPpj-LHBo0rCBJi39bHh=8vWjc52QBMM2A@mail.gmail.com>
X-Google-Sender-Auth: yewEvJvn5-yEuzPB-SoO01uqbRM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181404>

On Wed, Sep 14, 2011 at 9:31 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
[snip]
> Nope, you snipped out too much context. That command is turned into a
> string and then sent to /usr/bin/security on its stdin. It is
> absolutely not passed on the command-line.

Bah.  I see it now.  Thanks.

-John
