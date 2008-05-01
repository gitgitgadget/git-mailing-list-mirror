From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Tracability in git commits
Date: Thu, 1 May 2008 13:09:45 +0800
Message-ID: <46dff0320804302209o2af9d630s48564a9b68c24ec1@mail.gmail.com>
References: <1209473739.5642.31.camel@dax.rpnet.com>
	 <7vd4o873cm.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804301033k1dea34ecx863ecfa8e386e0af@mail.gmail.com>
	 <20080430194651.GC23672@genesis.frugalware.org>
	 <20080501002827.GX29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Richard Purdie" <rpurdie@rpsys.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 01 07:10:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrR3y-0003kW-I0
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 07:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYEAFJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 01:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYEAFJr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 01:09:47 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:38159 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYEAFJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 01:09:46 -0400
Received: by an-out-0708.google.com with SMTP id d40so176854and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RYyRikKU3SeUGZARU9oAHRNM9hBmA5UUHDrFQi42FH0=;
        b=g56/0wAMGf7lenkqiGD2sksCql95+Yth24hyd8IvCfys0QJeG1lIcuknI5F94U2xtM5ZS5//SWNP05kJanWIEBxJtgZakdaCh34H/slld76tWRZv9WFzUqvDQBbiD4BPJtvv/iiBqhIoIN3KiahOp6R3yDEFM0CDAUQ5hupAD74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lll5DfStzy0A6TpO+5A/adHjw4df88+Xo1rarLas1+TNjgI5jwQFNMl8wVAvhLG9pxhuBiDB68+bWX0pH/fOlC1ULH0UZQ6K6ZnYz4fwfDvFyNHb83rvKG0SyT9m68CU/JOnZScDpMxucSD3xbvpzXuR+ZgKC9V0RcmVFGX1NYY=
Received: by 10.100.140.15 with SMTP id n15mr2510067and.94.1209618585353;
        Wed, 30 Apr 2008 22:09:45 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 22:09:45 -0700 (PDT)
In-Reply-To: <20080501002827.GX29771@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80889>

On Thu, May 1, 2008 at 8:28 AM, Shawn O. Pearce <spearce@spearce.org> wrote:

>  `git config core.logAllRefUpdates true` right after you make the
>  repository solves that nicely.  I actually have a script that I use
>  to make a new bare central repo:
>
>         #!/bin/sh
>         git --git-dir="$1" init &&
>         git --git-dir="$1" config core.logAllRefUpdates true ||
>         exit

I wonder  why not make it the default behaviour. If someone push the
wrong commit to the bare repository (for example, with 'git push -f'),
there is no easy way to recover without reflog.

So as a solution, i would rather put this config to ~/.gitconfig




-- 
Ping Yin
