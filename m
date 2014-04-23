From: Charles Buege <charles.buege@gmail.com>
Subject: Trying to setup Visual Studio 2013 with a CentOS 6.5 x64 git server
Date: Wed, 23 Apr 2014 14:04:08 -0500
Message-ID: <CAOWfAePSjpOaN0pgaVqjHxvdMPp2WnEhHj2-Wea1dV7WyjtMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:04:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2Sy-0004fu-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbaDWTEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:04:12 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:47586 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbaDWTEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:04:09 -0400
Received: by mail-vc0-f179.google.com with SMTP id ij19so1734920vcb.10
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HAknvutCB2ks1D4w17nz35otWaKgEJQv76t0aAh/MiE=;
        b=XgcBr/AOl/Ayf72TH7BCcggjzPDgzPmbVBM4CoGXcPhPXtGNG55pI/B1Fr9vwEN/rb
         Eo9YccaaxH1hFDYo1ECskgW/jI3tsbvd63gVWgzCf0oPVPkUQOc+fzEleXQQMnpNJPZv
         bv5RBjq9dRRhUXoj33oeR4xzGVAj4JGQWw356ovzrDCzDx0guor50GwzlejeF6BimUUx
         1g+Nukn69T9r8OMjm1sB6bhb8cEBNtE8sqru8dAjDQHwku9V49vBqgOhLqqL054304Bq
         88DunJRbVKsm8/bggt/g171AGTPl8D1nMFyiwCke2QbbE+ZaROKfHl8KGehAkNModzLY
         BCpg==
X-Received: by 10.220.105.4 with SMTP id r4mr7832519vco.27.1398279848345; Wed,
 23 Apr 2014 12:04:08 -0700 (PDT)
Received: by 10.220.146.83 with HTTP; Wed, 23 Apr 2014 12:04:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246866>

All -

If this is the wrong place to ask this question (I'm heading to
Microsoft's site next), then I apologize, but communities like this
have always been kind to me in the past, so I thought I'd start here.

I'm looking to setup a git server under CentOS 6.5 x64 that will serve
2-5 .NET developers using Visual Studio Pro 2013.  I've been reading
that Visual Studio 2013 now has 'native git support', but as I've been
reading into this more and more, it appears to me that the 'native git
support' is really the fact that Team Foundation Server has git
support on it and that I'd need to setup TFS in order to use the
Visual Studio 2013's native git support.  Can anyone either confirm
and/or deny this for me?  My personal suspicion is that I will need to
implement TortiseGIT to do what I want to do, but wanted to throw this
question out to all you masters of git to direct me in the proper
path.

If, in actuality, I can use a CentOS git server with Visual Studio
2013, can anyone point me in the direction of an
FAQ/directions/YouTube video/book/anything for how to setup something
like this?  I have the resources to setup a CentOS git server (which
will also host some DreamWeaver CC users as well on other projects),
but setting up a dedicated TFS server isn't an option, hence why I'm
looking into this.

Thanks in advance,
Charles
