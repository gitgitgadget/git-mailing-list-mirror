From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 1 Feb 2007 10:54:56 +0100
Message-ID: <81b0412b0702010154v47b290act4e1c8d3722d23dd3@mail.gmail.com>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	 <20070131231942.GB31145@coredump.intra.peff.net>
	 <Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	 <20070201030030.GA1979@coredump.intra.peff.net>
	 <7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	 <7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0702010153m301a3603idc182df8abbf89a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Nicolas Pitre" <nico@cam.org>,
	cworth@cworth.org, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCYek-0001E5-4q
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422734AbXBAJy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422735AbXBAJy6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:54:58 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:30687 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422734AbXBAJy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:54:57 -0500
Received: by wr-out-0506.google.com with SMTP id i22so477665wra
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 01:54:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kgq1LMWp+wz8b35XGorFlojQZR554O9am6xzIvRPtbSRpdw7lusv41Gldgz/BmjGuFxGcUfpLgtDKkLII9VhixO5+8BkM6feZVgk6NPdruoc4Jj1BWn9BKiIe+jlZU75jZX1BJDd3zhqOJebupstlYFDqugzl6bT5bkrZsSg/nw=
Received: by 10.78.193.5 with SMTP id q5mr456924huf.1170323696474;
        Thu, 01 Feb 2007 01:54:56 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 1 Feb 2007 01:54:56 -0800 (PST)
In-Reply-To: <81b0412b0702010153m301a3603idc182df8abbf89a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38338>

On 2/1/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 2/1/07, Junio C Hamano <junkio@cox.net> wrote:
> >     [git.git (master)]$ git checkout master^
> >     M       git-checkout.sh
> >     Note: you are not on any branch and are at commit "master^"
> >     If you want to create a new branch from this checkout, you may do so
> >     (now or later) by using -b with the checkout command again. Example:
> >       git checkout -b <new_branch_name>
>
> How do you detach HEAD _without_ changing working tree at all?
> IOW, is there a "git checkout --detach"?
>

Ah.. I see, the "obscure, but useful trick".
