From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 11:04:52 +0100
Message-ID: <81b0412b0703010204m7ccba9f0nedc14a180cf1b2cf@mail.gmail.com>
References: <20070228151516.GC57456@codelabs.ru>
	 <200702281541.41164.andyparkins@gmail.com>
	 <20070301051323.GG57456@codelabs.ru>
	 <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com>
	 <7vslcpux62.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Eygene Ryabinkin" <rea-git@codelabs.ru>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:07:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMiBn-0002IB-Ra
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbXCAKFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXCAKFB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:05:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:38684 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964825AbXCAKEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 05:04:53 -0500
Received: by nf-out-0910.google.com with SMTP id o25so843193nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 02:04:52 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8z6U28KC5KjAxnVDWyEo/zi+PGOpGRp5ypQX277TiLuvB0rovtnSEHlUL5hJMyxHcY1908KM+PqGPZ13K6vXI3Ng2ErJ3aoqrMipBKIvRC6jeH54QR4O+De0VFFnlvqIqrqfFZh5EnxT2cZPMJiKvShEyntzmPTuZtcPb3/h3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rEQUxuh2EsXuG12nLb0qMicThIuWxCbK3hBS0rao+QsMkGpbyeIIyptEtYYOw5SmlOFsQ1QvyW+b+TbQF3Ko8tknYS8qid35Yuj0tuNaQhNM5BT8lyjDtLZxF6IoL21eGnBd7ifB09n8Ixno4hA9WV6BpbivKDCC1Qo3Nt5iWh4=
Received: by 10.78.140.17 with SMTP id n17mr142639hud.1172743492142;
        Thu, 01 Mar 2007 02:04:52 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 02:04:52 -0800 (PST)
In-Reply-To: <7vslcpux62.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41073>

On 3/1/07, Junio C Hamano <junkio@cox.net> wrote:
> >> As Johannes pointed out, old habits are still alive. And when some
> >> tool serves me the right way, I am happy with it. To make the patch
> >> with Git I should create repository, hack there, merge it to the
> >
> > hacking on Git you already have a git repo, don't you?
>
> You do not have to insist on using git to hack on git itself.

that wasn't it. It just haven't occurred to me at all, that someone
could hack on git without using it. I feel very uncomfortable
changing anything not under version control (specifically - not
in git repository ;) Just haven't though of tarballs.
