From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: git-config: replaces ~/.gitconfig symlink with real file
Date: Mon, 16 Jul 2007 07:33:56 -0400
Message-ID: <f158199e0707160433v27fe7073w9c550712c41c32e8@mail.gmail.com>
References: <f158199e0707151427h52da3e38rae3be6e44e27e918@mail.gmail.com>
	 <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nikolai Weibull" <now@bitwi.se>
X-From: git-owner@vger.kernel.org Mon Jul 16 13:34:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAOq3-00062O-Ji
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 13:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbXGPLd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 07:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbXGPLd7
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 07:33:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:21509 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbXGPLd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 07:33:59 -0400
Received: by wr-out-0506.google.com with SMTP id i30so507704wra
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 04:33:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VGs17dHd6iO3LIVE96vtWTCywmDmB1dbSSyew7fHnHYbMOMizwB2mKjjEw+pcjl1JzeUcLnm6s7VEM5lk093Xn8SecnaP+b0U7jMERPnYhr26vyrBTrIkefHMpH3+G5WEt3O7Bu+JUxc+7Qcf5t3GWjeKQZSTeM//drPI/vbaRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GbN8ue3x9f3ey1YWJveuGyuxECnhSw0aTcbsEBnJvbbXKzoEIyGHm+fR+H1Tk31KqVXXG9ometcrfiJ4QR4jPfFlP5Y36dsDKSfxStiN7XyOIUo+BNxRPd8TcL++DN+T1+g8PEWojTsKMwY97Fe8ze2bjfvj9FJwAtP206fIh3Q=
Received: by 10.78.160.2 with SMTP id i2mr1141776hue.1184585636242;
        Mon, 16 Jul 2007 04:33:56 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Mon, 16 Jul 2007 04:33:56 -0700 (PDT)
In-Reply-To: <dbfc82860707160237v6772b5b8o541f2045ccd824d5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52663>

On 7/16/07, Nikolai Weibull <now@bitwi.se> wrote:
> On 7/15/07, Bradford Smith <bradford.carl.smith@gmail.com> wrote:
> > Since the number of dot-files and dot-directories that I have in my
> > home directory these days is somewhat overwhelming, I like to keep
> > those I directly edit all together in an ~/etc directory so I can
> > easily back them up and/or copy them in bulk to new accounts.  So,
> > several of my home dot-files are just symlinks to something in ~/etc,
> > including ~/.gitconfig.
>
> How about adding an environment variable telling Git where to find
> user-global .gitconfig instead?
> > home directory these days is somewhat overwhelming, I like to keep
> > those I directly edit all together in an ~/etc directory so I can
> > easily back them up and/or copy them in bulk to new accounts.  So,
> > several of my home dot-files are just symlinks to something in ~/etc,
> > including ~/.gitconfig.
>
> How about adding an environment variable telling Git where to find
> user-global .gitconfig instead?

Thanks for suggesting that.

Actually, by looking at the code I discovered I could use the
environment variable GIT_CONFIG to specify where the configuration
file is, and I have already changed my setup to use this.
Unfortunately, I found the documentation for this variable in
git-config(1) confusing or I would have used it before.  If I get the
chance, I'll submit a patch for git-config.txt, and maybe for git.txt
as well, since it lists lots of other environment variables but not
GIT_CONFIG or GIT_CONFIG_LOCAL.

Thanks,

Bradford
