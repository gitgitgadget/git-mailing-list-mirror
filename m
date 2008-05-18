From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 19:04:01 +0200
Message-ID: <81b0412b0805181004s45de5ba1v328a8753ecaca42@mail.gmail.com>
References: <20080518152337.GB3058@steel.home>
	 <alpine.DEB.1.00.0805181634100.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Jeff King" <peff@peff.net>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 18 19:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxmJe-00059A-Gx
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 19:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYERREG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 13:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbYERREF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 13:04:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:36958 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbYERRED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 13:04:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1400466fgg.17
        for <git@vger.kernel.org>; Sun, 18 May 2008 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CNRusaRKleEQaoR0GbYsM+RnoDZsUkFj5OAsYpiRUvU=;
        b=juW2UtTc3IyFDSlSiPcgsOcfo5c+1Em7L4skXRJBTne5JVcXGvY7UV/ScMTFcIyBxICeTJqQCnx0hlYVcg8S33Fohbnce5ua4zZG1vbfVPbLBGxnQEDPn/riyFu6sYZJ8yMrHS2G2UC1pMh123d82RrkxDVMIF0eNV5bX6nU94k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DhhzWJCIXvQxmD9HKm4Byt4BVf3xiAjaOJpIQuf+nQhXUkEIxeHCFwj3AYNHhlEUttxrxz+h9HO3XVfMVCQg0RlIVvSicl4ya66WNDS6ham36PVJbcnpXsPPyYBEeNKoRaqJMUkwIKzXTpq6IkKu3/6GOY0s74wzWod1xQQ1fGw=
Received: by 10.78.138.6 with SMTP id l6mr1620766hud.71.1211130241873;
        Sun, 18 May 2008 10:04:01 -0700 (PDT)
Received: by 10.78.100.12 with HTTP; Sun, 18 May 2008 10:04:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805181634100.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82392>

2008/5/18 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Sun, 18 May 2008, Alex Riesen wrote:
>> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>
> Are you sure that you want the commit message to read "t3701 fails if
> core.filemode disabled"?  Not rather "skip t3701 if core.filemode is
> disabled"?

It is not meant for inclusion. More an RFC. I'll resubmit, of course,
if just skipping the two last tests is ok (maybe git-add--interactive
can be changed so that it handles this filemode problem internally).
