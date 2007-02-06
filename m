From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Tue, 6 Feb 2007 14:32:02 +0100
Message-ID: <81b0412b0702060532l31f88f64s812d2829f4d45844@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
	 <20070205194508.GD8409@spearce.org>
	 <81b0412b0702051449l3951ee43s34bde4614c83612d@mail.gmail.com>
	 <20070205225505.GA9222@spearce.org>
	 <81b0412b0702060220l3887624ax762e5cba3f75fd0c@mail.gmail.com>
	 <Pine.LNX.4.63.0702061144430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070206110015.GA10231@coredump.intra.peff.net>
	 <Pine.LNX.4.63.0702061202260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702060509l1283fcb2j105a0580a718b2e0@mail.gmail.com>
	 <Pine.LNX.4.63.0702061420420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 06 14:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEQQh-00031f-At
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 14:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXBFNcG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 08:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbXBFNcG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 08:32:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:56788 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXBFNcF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 08:32:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1603575uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 05:32:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sh4eQia1s5xm+EV+Fshh6wOB4wz73m6xVPi78XqzNN4Ipd+VQnlM6mLM5YnUaqFPW+ts8kMlO3C6ZCg+dmZ0rKPb2lspekcrSNQPFHdLEXlvgHzehyKj68q9VA7VzqSwhtC5xp1v42fuzV/kDcDVqvwGnLHyvIJrW0VWLP0/Qis=
Received: by 10.78.201.2 with SMTP id y2mr1659933huf.1170768722743;
        Tue, 06 Feb 2007 05:32:02 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 6 Feb 2007 05:32:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0702061420420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38838>

On 2/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Or just do no repack in the referenced repo.
>
> That is not the solution.
>
> The error in your setup is to _rely_ on data which just _might go away_!

The data cannot "just" go away. I'll have to "go the data away" manually.

> IOW do _not_ use an unreliable repository for --reference!

Well, that being an accident, I see no way to follow your advice.

> > Anyway, the discussion outlived its usefulness.
> > I have what I wanted (git fsck --unreachable), and nobody can force
> > me to repack my shared repo, so the issue does not exist for the original
> > poster.
>
> Well, I think unless you understand that you do something really fragile,
> the discussion did not yet outlive its usefulness.

Yes, preacher.
