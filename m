From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Wed, 17 Oct 2007 08:57:35 +0200
Message-ID: <e5bfff550710162357r2c3744b1me5138edf24a56090@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <20070709173720.GS29994@genesis.frugalware.org>
	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
	 <4713FA4A.5090501@bluelane.com>
	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
	 <471433F3.40606@bluelane.com>
	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
	 <471454B5.7040802@bluelane.com>
	 <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
	 <4714EF53.8090707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: pete@bluelane.com,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Oct 17 08:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii2rI-0002ye-Cc
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 08:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760923AbXJQG5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758924AbXJQG5i
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 02:57:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:24430 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760923AbXJQG5g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 02:57:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1661400rvb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8fU/ikmqTzLfSqVcQv1+0rufaw349Nlk4No4hXpTEzs=;
        b=PMDCgslI8IXQu/CdQLy0XLHxWvnYmGxIPLf/+L7sAmPfDoKVinK3CdKI54/sfuEj84KSD6KmkUwL3uJ9VOwRBiIrGekR81L5bSM/CfgCnX8/kDw+oqlocsinqh0sPL3AgjCB1Tj2IJU8Y77Q+1XNvHVYbVoUEn4JnWyEE+fJwuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U6zzsMJyp0hiFxHyQ5DnWjJZDSMLy+NLbNTDRGg6rTNq4BlZglg5LdAObMsef6rWNUaaeD7muFXyVZgwPQeq6TdTc+zHOanfTo5hjP8gRQSzYwrEtNBw9tDC13OvwdkwgXNs/UcP4VVkLH30NyX8oksVqCIkTZl11WAf+Bm9Vgs=
Received: by 10.141.172.6 with SMTP id z6mr4002046rvo.1192604256014;
        Tue, 16 Oct 2007 23:57:36 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Tue, 16 Oct 2007 23:57:35 -0700 (PDT)
In-Reply-To: <4714EF53.8090707@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61340>

On 10/16/07, Andreas Ericsson <ae@op5.se> wrote:
> Marco Costalba wrote:
> > On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
> >
> >> Would it be worthwhile
> >> to install Qt4 from src and try to use qgit-2.0?
> >>
> >
> > Yes it is. There are a lot of new featrures, is almost as stable as
> > the previous and if you are interested in file history (annotations)
> > in qgit-2.0 this feature has been greatly speeded up.
> >
>
> The only thing I really, really, really don't like about qgit4 is the
> fact that it fudges up the commit-message. I've been trying for two
> days to get rid of the HTML output, but I just can't get it done
> without the signed-off-by email being enclosed in &lt;&gt; tags.
>

You mean when you commit some changes or when you brows the revisions?

If it is the highlighted title that annoy you I can try to remove the
background color, or set as plain text as an option.

> view without the colored box a lot more). The little arrows in the
> commit window are also fairly annoying, as one quite quickly understands
> that up-/down-arrows work much better for that sort of stuff anyway.
>

Little arrows should already be removable from settings->browse->'Show
smart labels' , you can also add lateral tabs with
settings->browse->'Show tabbed revisions' if you like.


Marco
