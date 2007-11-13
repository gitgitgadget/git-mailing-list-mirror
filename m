From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 10:53:43 +1100
Message-ID: <ee77f5c20711131553j587cb566id6d76bd23182dd6@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <20071113234722.GK3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kristis Makris" <kristis.makris@asu.edu>, git@vger.kernel.org,
	scmbug-users@lists.mkgnu.net
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5aX-0007dD-LF
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762071AbXKMXxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762020AbXKMXxr
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:53:47 -0500
Received: from el-out-1112.google.com ([209.85.162.182]:2944 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759408AbXKMXxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:53:45 -0500
Received: by el-out-1112.google.com with SMTP id j27so568549elf
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 15:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DxfU3l8V0I6DZ7RRxHvoB5JZ+KGpdttwQKjhCy9pRp4=;
        b=DpNIfgFuG2+jWVcXfRPUHTYqXcIgZS4AU8PBjJZ5mAwpG//g44VuNTInvbJkOXRshGqbKTpXf194xj2JUw+gp4pbLl5krI0iGxagSDNDgzksHytgOpJq+VzkRkEE8hJZxQa3OHwD/sq2yj+UdqrY/dmdpClR8kmMOA6tHd5zsFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hBQ3XzDS5fGD9CX9oI0iRYyBDNqEpcepc35PQdq98ZL+4zKGFLtHfpQLws5wN49d+2+gNFmVfBtazDUYllFt1j5ZLq9w5FOquJvS4G2myLDLQF0LUn3U0tDUVK9VmZTZqLjRP1DdHVk3GWjx2LZItcRLhFgLispsTS3b2w+hwKc=
Received: by 10.142.52.9 with SMTP id z9mr991480wfz.1194998023867;
        Tue, 13 Nov 2007 15:53:43 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 15:53:43 -0800 (PST)
In-Reply-To: <20071113234722.GK3268@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64911>

On Nov 14, 2007 10:47 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Kristis Makris, Tue, Nov 13, 2007 20:06:32 +0100:
> > http://bugzilla.mkgnu.net/show_bug.cgi?id=991
> >
> > There's no hook that will trigger when a tag is applied.
>
> what for?
>
> > http://bugzilla.mkgnu.net/show_bug.cgi?id=992
> >
> > Git does not offer metadata describing a change on the commit trigger
> >
> > The commit trigger seems to be "post-commit" but it supplies no arguments.
>
> HEAD?

That wouldn't be particularly safe if you have a very quick succession
of commits (say, via a rebase, or automated operations) because HEAD
could be moved by the time the post-commit hook reads it.


Dave.
