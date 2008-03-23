From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: Recording cherry-picked commits
Date: Sun, 23 Mar 2008 14:57:33 +0100
Message-ID: <b77c1dce0803230657i6d61abefg3b0ee7b42119927c@mail.gmail.com>
References: <ae63f8b50803210533n12645fb3w9a8be601c4cc394@mail.gmail.com>
	 <ae63f8b50803220937k78571fbdl1eeb60966ec7aa40@mail.gmail.com>
	 <b77c1dce0803221548x3250cb90taa9a9d53464f7ea7@mail.gmail.com>
	 <ae63f8b50803230407u7062586dy26fab7d98090efb9@mail.gmail.com>
	 <alpine.LSU.1.00.0803231309370.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:58:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQiE-0003f6-Tn
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759386AbYCWN5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758973AbYCWN5e
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:57:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10357 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbYCWN5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:57:33 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2501273wff.4
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BcqFdZYwhRZUCzf5YflytQhSALCMAZtHljpCulu2TRs=;
        b=CmBYdunP9jGwFQ/9Vi8XK+n4MM4dcLUU7W5oFYoQBdlhPqTYhuw5Ul+ZXhRvvJGjSuhOGMC97oMll9jYlfvNgCEz9HM2Bahnd2YX48OLCoe2GNF9LIGbemHOqlt363ynGD2r3ojkfHA4Ba8GQ20cbtUXaik6tNfOb7ESTVtAp80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VKyGoa4xPXooWzyC0PnFmuQMg/6iSkSygdo24Jaij60pH16neZMojwvk7jLRmgZNDg8f5tx6pQ3NXHz9BpvX0+H5jDNsCpM0fB5dg34gPTnOzmNpraLL/amkzDGgksdq4XhrbrWrblcLKrkPjQgXUcSyLj6ax5EtdBVdcgXHxfM=
Received: by 10.142.178.13 with SMTP id a13mr3745423wff.50.1206280653064;
        Sun, 23 Mar 2008 06:57:33 -0700 (PDT)
Received: by 10.142.156.10 with HTTP; Sun, 23 Mar 2008 06:57:33 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803231309370.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77897>

On 23/03/2008, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Actually, you should not store it in the root of the working tree, but in
>  the git dir (because it should never be tracked!), and then you can make
>  it non-hidden:
>
>         file="$(git rev-parse --git-dir)"/cherry

But this way, how can it be shared among several repositories?
(without patching git-clone itself, that might be a solution.) The use
case being many commiters cherry-picking patches from a development
branch to a maintainance one.
