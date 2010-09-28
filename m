From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [GITK PATCH] gitk: add menuitem for file checkout from selected
 or parent commit
Date: Tue, 28 Sep 2010 21:09:43 +0000
Message-ID: <AANLkTi=GmR3kV-ChSNybcaw4c=Dwt5G98e31WVuzJcfC@mail.gmail.com>
References: <20100928200344.GA12843@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hQw-0007VK-44
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256Ab0I1VJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 17:09:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57135 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0I1VJo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:09:44 -0400
Received: by iwn5 with SMTP id 5so108128iwn.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LCaxgJPp6FDqbnBAtWx4meilKXFexhzciAnTTom2wac=;
        b=eZBvu0s5omkhHTAMwlcWb2RW5i1eif/c/5RdCW3iIxuXWwFCN+tkWDteChTm80r/OZ
         FTQKKdnG3Rjha0o3tLRYY0+3S4hh79Hs0BbqKKYhXHTsMSsYUNLlKqWLZA1zKOEi/xw6
         POmbADzGDvR+zRZwAKPRRMzQ0umSVdwOiV00A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=plfdEO7eGcPRVfdPsOd5QRyUa6gcM4JYU4/k+Lo87TOiu86k5axLm/0Ra9a7Jd004J
         +jwwOXFpJwuvZWBAR1Ge/cJNeLPbk+KjIfXt50qeQ1SmLmps2sS6LKeCl/Nlys+t5Nya
         8juo56CRUbrKmengtPE27nVZAAsNNx/PXzvkM=
Received: by 10.231.182.204 with SMTP id cd12mr568292ibb.101.1285708183576;
 Tue, 28 Sep 2010 14:09:43 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 28 Sep 2010 14:09:43 -0700 (PDT)
In-Reply-To: <20100928200344.GA12843@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157473>

On Tue, Sep 28, 2010 at 20:03, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> This is useful if a user wants to checkout a file from a certain
> commit. This is equivalent to

It looks like the existing msgid/msgstr pairs have line number
comments. Why not add that for the new strings? Presumably it might
inflate the patch a lot though, as old strings get displaced.
