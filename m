From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: partial checkouts
Date: Sun, 24 May 2009 16:57:52 +0100
Message-ID: <18071eea0905240857x2433e7a1x5776def3209afbf5@mail.gmail.com>
References: <200905231401.11651.chanika@gmail.com>
	 <fcaeb9bf0905231907q16160ad1t8aa8ef71e2adc8b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chani <chanika@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 18:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8G8R-0000Xf-Vq
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 18:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbZEXP5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 11:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759355AbZEXP5x
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 11:57:53 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:43289 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389AbZEXP5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 11:57:52 -0400
Received: by bwz22 with SMTP id 22so2598155bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I4nN1f0v1LUePuTv85UIggLGVZ/hZ6zH/eS3yw8lEac=;
        b=N0uOwczKGyaAFIJJl7w7o/xm4gjUwwo6KWSiKgnnHgjNKEa9Z1vbGEtP5zu4PwpvNE
         hbJAAkPh2uPaEb0/L7jEBnsghGWUpKcyi/IGCmkEU41LANX4aHpXoH/YmBdl1LhESkLL
         yY+nZDf4ZCFQ4rNORnaeYVGARSOm5FBissUTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tDdpkmbRaCCHpWrjORoeQd+cPVY2d4Gr/sIgUiF++96LuNsNo5ErlmqCRFkBPelzQA
         E5T0LBg+IpyXjHl0ZxnLsvG8/7xHyZJVi720JwBy2x9Sl/JsgFj2b074YxttmZykxMjG
         O0h9TFOrN8Pck+uYXDdEI2uyw0zD4uOQTYVcs=
Received: by 10.204.63.20 with SMTP id z20mr5874141bkh.200.1243180673037; Sun, 
	24 May 2009 08:57:53 -0700 (PDT)
In-Reply-To: <fcaeb9bf0905231907q16160ad1t8aa8ef71e2adc8b0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119840>

2009/5/24 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Sun, May 24, 2009 at 7:00 AM, Chani <chanika@gmail.com> wrote:
>> checking out the entire git repo isn't really feasible, because once KDE
>> finishes switching to git that'll mean checking out all of KDE.
>> I don't think that turning every doc folder into a submodule is feasible,
>> either - they sound kinda awkward to work with, and I can imagine lots of
>> people getting confused and messing them up...
>
> If you don't mind cloning the entire git repo (which may be quite
> large in KDE case, I guess), then you may want to try "sparse
> checkout". The patch series is available as a topic branch "tp/sco" in
> this branch:
>
> http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=refs/heads/inst
>
> Or I can send the patch series to you. It lets you specify what part
> of the tree you want to checkout.

I recall following this series when you first announced it.  Do you
have any plans to try and get it included in mainline?  ISTR there was
some more work needed to be done on it before then.

-- Thomas Adam
