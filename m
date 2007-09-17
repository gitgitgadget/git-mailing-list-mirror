From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: metastore
Date: Mon, 17 Sep 2007 15:04:18 +0200
Message-ID: <38b2ab8a0709170604u8f4474fyd990f61fb250bc93@mail.gmail.com>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	 <Pine.LNX.4.64.0709151507310.28586@racer.site>
	 <20070915145437.GA12875@piper.oerlikon.madduck.net>
	 <Pine.LNX.4.63.0709151819200.19941@alpha.polcom.net>
	 <86veaby050.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Grzegorz Kulewski" <kangur@polcom.net>,
	"martin f krafft" <madduck@madduck.net>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:04:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGH8-0000qu-IF
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbXIQNEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753876AbXIQNEU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:04:20 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:34104 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbXIQNET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:04:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1296844rvb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 06:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1ukNuXEcakqUM/hKPCqtFrhS7TvfZk6W4ud6wHHKgHw=;
        b=TLLSXg5Mc/ZGdMUVLQ3orvApnem7BGjz++d2LSWhjNdR87tyAi65SLWRN3/JjshBikNFLzvL6vSvGIySo5/5gTzSHxyxjwpVRl5Si8YJm/EtDZY0Ds3uQmZllFYD07PcsinJK6bgOxZ8+WZTSqcinKr3gfy9+vlWc2kxnO52TZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Cyi7Xa2OHVXscW5js4mvUj+CyOZmnyLARAKDag95HjoNCjW/BXI/6kkza5t7DGMEwKh2+lhbXEW3s/0LVXrWrDRhxHjjHSPAv6aVhuRDXnBCtQWpuKJDKzJ9JZPI+5tB1tGQ6/WC2MZG6s3lxZVrcedBL4a98CcFtzevyBxnGRo=
Received: by 10.114.197.1 with SMTP id u1mr4769243waf.1190034258241;
        Mon, 17 Sep 2007 06:04:18 -0700 (PDT)
Received: by 10.115.47.5 with HTTP; Mon, 17 Sep 2007 06:04:18 -0700 (PDT)
In-Reply-To: <86veaby050.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58437>

Hello,

On 9/16/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Grzegorz" == Grzegorz Kulewski <kangur@polcom.net> writes:
>
> Grzegorz> Not only for tracking /etc or /home but also for example for "web
> Grzegorz> applications" (for example in PHP). In that case file and directory
> Grzegorz> permissions can be as important as the source code tracked and it is pain to
> Grzegorz> chmod (and sometimes chown) all files to different values after each
> Grzegorz> checkout. Not speaking about potential race.
>
> Uh, works just fine for me to manage my web site content.  The point is
> that I treat git for what it is... a source code management system.
> And then I have a Makefile that "installs" my source code into the live
> directory, with the right modes during installation.
>
> Why does everyone keep wanting "work dir == live dir".  Ugh!  The work dir is
> the *source*... it gets *copied* into your live dir *somehow*.  And *that* is
> where the meta information needs to be.  In that "somehow".
>

Interesting. Could you show us what this makefile actually looks ?

How would you create a repo to track /etc ? I'm thinking of importing
this directory by using tar, do you think it's correct ?

thanks.
-- 
Francis
