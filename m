From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Working on merged branches whilst seeing current master
Date: Thu, 12 Nov 2009 16:14:25 +0100
Message-ID: <20091112151425.GD25398@vidovic>
References: <1257959806206-3987667.post@n2.nabble.com> <20091111215727.GK27518@vidovic> <1258037862366-3993313.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bNi-0005jc-Cj
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbZKLPO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 10:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZKLPO3
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:14:29 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:45907 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZKLPO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 10:14:29 -0500
Received: by qw-out-2122.google.com with SMTP id 3so433126qwe.37
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 07:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=kjdRh/WQfs+RGrmo2pHNuP5zwhf782rEYRhEd3aY1Fc=;
        b=svkzcYYWmZjz8rZJF6wIY3rdMkf4TLR+FCzOlc7W1dwcT+WXql8qt72CUXiyQ3mAoW
         fIYgY6s9UIof+hN0hD2OjBlIB1HuhgVu3CJCfeSpvcRvY4If5Fo2i5GJKOe2967Y63v1
         tDGdObdbZqweLneyXrKZi3RkEdSCLYPrp1IIY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i+QMgqW9v3aE00b8w368oyZrzmj/vkpo+DRJs6md0z5fPtciJn0UofdaBNgf2XIMOY
         CrN1/mE7p0HKw5GsMiJkVkSGUIiP/SY8IamdCbxAAuUkuwcN6G4csgflqnwZq91U0TQR
         C8NgeMG81w4mgItRxxfnZNjYBjePHOHq1bu8M=
Received: by 10.213.26.140 with SMTP id e12mr7541838ebc.0.1258038873978;
        Thu, 12 Nov 2009 07:14:33 -0800 (PST)
Received: from @ (91-165-129-166.rev.libertysurf.net [91.165.129.166])
        by mx.google.com with ESMTPS id 7sm3800682eyb.8.2009.11.12.07.14.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 12 Nov 2009 07:14:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1258037862366-3993313.post@n2.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132773>

The 12/11/09, rhlee wrote:
> Nicolas Sebrecht-3 wrote:
> > 
> >>                                      Yes I know I probably should not be
> >> working like this. My branches should be wholly independent. But I doing
> >> web
> >> development not kernel development so there is much less modularity and
> >> branches/features have a tendency to creep into one another.
> > 
> > This should not be the case. Modularity in the release process and the
> > development strategy is not tied to "what I am developing". I'm doing
> > some web development too and have no difficulty around this point.
> 
> Just to clarify. Do you mean that this should not be the case that you get
> feature creep in branches or the fact that this happens does interfere with
> your release process/development strategy.

I mean that the independency of the feature branches is mostly relying
on "what do I (as a developer) commit in this branch", which is really
tied to "how to write nice atomic commits" (easily reversible, etc).

This must be applicable whatever the product/software you're working on
and it is applicable for web development too.

-- 
Nicolas Sebrecht
