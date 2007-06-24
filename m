From: "Jason Sewall" <jasonsewall@gmail.com>
Subject: Re: [PATCH][RESEND] Escape some tilde characters causing spurious subscripts in documentation
Date: Sat, 23 Jun 2007 17:22:00 -0700
Message-ID: <31e9dd080706231722v760b5a0cnc31e24b83deafb90@mail.gmail.com>
References: <11826426733115-git-send-email-jasonsewall@gmail.com>
	 <Pine.LNX.4.64.0706240109540.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 24 02:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Frj-00073m-LH
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 02:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbXFXAWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 20:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXFXAWD
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 20:22:03 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:41479 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbXFXAWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 20:22:01 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1140701wxc
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 17:22:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pmIBiRPm7GuLs+QquE9jpasd0zrYFvKYLaz9qnFis/Yijd5CBB8UCjKvc3sBbPGh/o5fz890YtV28wCDCK3R232jBf3qPNgTu6l/U+8yxuVg6F6M1QezAPTOp5V8/5KOB2Wzvtn6i5cYvoLu/m5DXstJpnm6bZ0ETP4Y5bukuVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N7kUZFnAtVFxL+jbI2elehSct2shQKQKXBEahidxDsg3+8ipywxPahx2owpJSPhe/9tTRhnqwt9ovGTnHwNmXionmCD1IpJPoYivrgs9b/S98mTKIL7K0/3EiAUYiqy3v1fpy2d+BR/kV2rELBH9wYKHJd+80aaMAPERIkLeMzk=
Received: by 10.90.25.3 with SMTP id 3mr3454108agy.1182644520579;
        Sat, 23 Jun 2007 17:22:00 -0700 (PDT)
Received: by 10.90.54.18 with HTTP; Sat, 23 Jun 2007 17:22:00 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706240109540.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50763>

On 6/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I just checked with my copy of asciidoc, though, and there is no mangling
> going on, at least in git-bundle.html (which is the only file I checked).
> My asciidoc is version 8.2.1. What is yours?

I've got 8.1.0; perhaps that's the problem. I wasn't so surprised to
hear the asciidoc 7 and 8 don't get along, but I'm surprised to see
that 8.1 and 8.2 are so different.

Anyway, 8.1.0 is apparently what's in Fedora 7 (the distro I'm using
right now) so it might be worth hanging on to the patch.

Thanks for your help,
Jason
