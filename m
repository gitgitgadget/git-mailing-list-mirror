From: Ondrej Certik <ondrej@certik.cz>
Subject: Re: mailmap distinguishing names
Date: Thu, 16 Jul 2009 11:09:06 -0600
Message-ID: <85b5c3130907161009k64029bd3t23155040728d9d9@mail.gmail.com>
References: <85b5c3130907151522x1009a796tced7726d9be4ca7d@mail.gmail.com>
	 <20090716085532.GA8843@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:09:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRUSL-0007B2-8X
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 19:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbZGPRJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 13:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbZGPRJI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 13:09:08 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:52240 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbZGPRJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 13:09:08 -0400
Received: by gxk9 with SMTP id 9so431169gxk.13
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5MjKKoFZutbVw0nYz5IsRPyx5PNf4yQKuldg3aHfMqo=;
        b=dHiLQ4mFmCYsaTSMdZJQuAVM1vExZSGd2zuo0slLLSKGWjisDhwkobznWERnOKC3Ky
         fTTv7YGcgtKK9Pw/Jn60jPMO+euQCTBIW1kOviGJb4ZOGXIAqPvpA9DZZ1SEip9F4iaj
         WL6jUgHJTt+WGfnHrgrTXZkDf55U8O9UwMv5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rTz02yAlXJFFarfim/rKIQcjJoVCYs5emcgUHl7djnLWlPvohxn6w3RVUV6rMHCQIh
         +bzYcDEAxiSWSy21z4oUw0AUIRkh6TvOSUitEgML9SEgT77wedzkaX7p6r6QIZWKZ5tp
         lVp5YimQAMllfNvj/aqlFWz8jTSOgLSMcYnF8=
Received: by 10.90.28.16 with SMTP id b16mr5422816agb.101.1247764146912; Thu, 
	16 Jul 2009 10:09:06 -0700 (PDT)
In-Reply-To: <20090716085532.GA8843@landau.phys.spbu.ru>
X-Google-Sender-Auth: e902d9dda2a84e2a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123409>

Hi Kirill!

>
> You just do
>
>    Ondrej Certik <...@...>   ondrej.certik  <devnull@localhost>
>
>
> in .mailmap
>
> See Documentation/mailmap.txt for details

Many thanks for help, that's exactly what I want.

Only I think I am probably doing something stupid, because I can't get
it to work (I use the latest git from git),
I put this into the root directory:

$ cat .mailmap
Ondrej Certik <...@...>   ondrej.certik <devnull@localhost>

(if have my real address instead of the ...@..), and:

$ git shortlog -ns
  654  Ondrej Certik
  322  Kirill Smelkov
  268  ondrej.certik
[...]

it still shows ondrej.certik.  I will try to debug it why it doesn't
work, I think according to the documentation it should work.

Ondrej
