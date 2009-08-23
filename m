From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Pulling one commit at a time.
Date: Sun, 23 Aug 2009 22:11:35 +0200
Message-ID: <81b0412b0908231311w483d737bncf8d4604cf7490db@mail.gmail.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <4A9172D0.6030507@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sanjiv Gupta <sanjiv.gupta@microchip.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:13:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJRQ-0004CL-FY
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934014AbZHWULf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933984AbZHWULe
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:11:34 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:58099 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933983AbZHWULe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:11:34 -0400
Received: by ey-out-2122.google.com with SMTP id 22so493674eye.37
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JIT88H3m1HBpThTUZxSOmeITOq24icjIaXjPsDQ+06o=;
        b=uWjpuGMRsDoj7p8doOma3x8fxMId1/c0gvUk+iKHUCAIrm7V3wvBj4ni8IZwvxsbcY
         FUilW4W3WBaqNUcuZGW6zApRrVm4pG84exI89hZCGQZPSgj+3JHfkCumm/1PbzGbTDpP
         p94L8gBQ/yzuw1HOco0TF3BEFbo2ongG3Th0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MHkBOf1aOyNWvp5R0NBPsydnnYB5oFrLaCFbzQsMoBT8jNRauvL9HgQp9KdkNkgIAS
         dBGtBJfdMGgnffmd7yRi/0HD80p714k+yMNxa7MF+KCZlnRPi65dR+yhNY6UmBNP7RXg
         kKN1m/UwRvtc7IUBfrEe5ZcMAfYgZfR61FH6s=
Received: by 10.210.62.4 with SMTP id k4mr3946971eba.25.1251058295165; Sun, 23 
	Aug 2009 13:11:35 -0700 (PDT)
In-Reply-To: <4A9172D0.6030507@microchip.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126867>

On Sun, Aug 23, 2009 at 18:48, Sanjiv Gupta<sanjiv.gupta@microchip.com> wrote:
> when I first cloned from the public repo, it was at X. now it has reached Y.
> I just want to pull x+1.
>
> how to do that?

Depending on what you mean, it maybe either the what Git already
does (a git fetch/git pull always transmits only the differences) or a
security risk and impossible (an ability to fetch an arbitrary commit
bypasses checks imposed by the reference names published).
