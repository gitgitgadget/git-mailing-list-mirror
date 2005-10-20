From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: rsync update appears broken now
Date: Thu, 20 Oct 2005 16:24:42 +0200
Message-ID: <81b0412b0510200724h76dc8457tb5320a644a5ef260@mail.gmail.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
	 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
	 <86ek6g9t0a.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 16:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESbLb-0008Uy-MK
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 16:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJTOYp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 10:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbVJTOYp
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 10:24:45 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:14932 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbVJTOYo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 10:24:44 -0400
Received: by nproxy.gmail.com with SMTP id q29so22715nfc
        for <git@vger.kernel.org>; Thu, 20 Oct 2005 07:24:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G3RhFu1Ism2w01Yv52hawFZTATeZyAus1WupyOsKrXWMzPsWoORqZFN8+pSbvPcUpglcNiv3QEjJM7hIaM47ZKrsAGZ3UCHkRwbRG28ARCNXSikclJWM9aLjzI0KCQ8O+FbMaR5a+UN3Vh9quXrNOmv9i3QFEY3ybPewsU02xp4=
Received: by 10.49.5.4 with SMTP id h4mr133622nfi;
        Thu, 20 Oct 2005 07:24:42 -0700 (PDT)
Received: by 10.48.49.13 with HTTP; Thu, 20 Oct 2005 07:24:42 -0700 (PDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86ek6g9t0a.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10362>

On 20 Oct 2005 07:12:53 -0700, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> Alex> Absolutely normal pull into a changed repository. Just fix the
> Alex> conflict (in fetch-pack.c, look for >>>), git-update-index the file
> Alex> and commit. Doesn't look like a problem at all.
>
> What do you mean "changed repository"?  This is my git image, and I'm
> not working on git.  I made no changes.
>
> Thus, something broken?
>

Not necessarily (I see this every morning, but I know precisely I
touched the sources).
Maybe local damage? What does git-status show?
