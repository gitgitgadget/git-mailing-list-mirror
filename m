From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 30 Nov 2005 14:15:55 +0100
Message-ID: <81b0412b0511300515u5d2840ccv92be6e374dd795be@mail.gmail.com>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
	 <20051127131147.GF22159@pasky.or.cz>
	 <20051129204729.GA3033@steel.home>
	 <200511301405.19541.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 15:39:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhRol-0003ax-Sc
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 14:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVK3NP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 08:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVK3NP5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 08:15:57 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:40276 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751206AbVK3NP4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 08:15:56 -0500
Received: by nproxy.gmail.com with SMTP id o25so618385nfa
        for <git@vger.kernel.org>; Wed, 30 Nov 2005 05:15:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aw/3+7AupxxuWJzkfZjeX1cLLyu3ZYJEtFZBTH0sNF2nypU7ROTxemAFGJMYQr1EhJCiRQrGEFT5/pDdB8yc8n8b4GWzDJ+swwbFLmdm6CRFc/LMjXwM59JU4td4CebBwxuxHCuJIYMaTUZBR1j/rYqydUeJnvXVZbVt9Apw2Kk=
Received: by 10.49.1.16 with SMTP id d16mr19333nfi;
        Wed, 30 Nov 2005 05:15:55 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Wed, 30 Nov 2005 05:15:55 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200511301405.19541.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12997>

On 11/30/05, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > BTW, how does git-mv behave for out-of-tree renaming? How about
> > inter-repo renaming (remove+add)?
>
> git-mv will fail. The source has to appear in git-ls-files, and the
> target simply is given to "git-update-index -add", which will return an
> 'outside repository' error. Hmmm... git-mv should check this itself.
>
> To detect inter-repository renaming, one has to see both repositories.
> Currently, git/cogito etc. commands only work with one repository only.

This case is somewhat special: one is _guaranteed_ to see both repositories.

PS: Im'restoring git@vger.kernel.org in cc-list, the discussion could be useful
