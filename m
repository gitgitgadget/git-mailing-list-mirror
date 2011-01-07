From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Fri, 7 Jan 2011 12:19:46 -0600
Message-ID: <20110107181946.GB28980@burratino>
References: <4D260A03.90903@ramsay1.demon.co.uk>
 <20110107173114.GA31376@dcvr.yhbt.net>
 <AANLkTi=VpHtQ+x5hyfCei-=X=ry4X=+TSGg7EKa7zs4j@mail.gmail.com>
 <20110107180220.GA20031@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>,
	Steven Walter <stevenrwalter@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbGv6-0003kz-V8
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab1AGSUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:20:05 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40051 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755100Ab1AGSUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:20:04 -0500
Received: by vws16 with SMTP id 16so7230073vws.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gmnVe+2ZIE2WMuNGNw/LGzx8ybveUDkXGijAt4qsra8=;
        b=eJ2kyuFipqXF4x53sB0saKAOGKx90TCAbofFJo/cmmugyVcCWRruyE6w5VF3lGgPwx
         MLXvHT1SBvmRPvsph2nYhUluJTVcnZskdjWvKGN5wspVjmJ2I+3F6iOrMuc/Jwcn/0PD
         KzqOVQsaiP9NuBcMCu7aHXmh0KS/fiQSAc9DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vMPXxqxFIJWLqUXeoBv2dgt3Uim85Ip3dYzmDMVBU7+Wroo7S+hmVgQuSCKFQF8mwk
         Ws5zzgGIq/4CgtNcIhoaHLeR6CGYukQjTX0UbVy7QK3QmEEO5E2jeYo5IUSAFYcOExgz
         I90u7YyrhlIL9GvtHHLRH7uFZ4JHmT16gVQT4=
Received: by 10.220.191.200 with SMTP id dn8mr3033070vcb.147.1294424402215;
        Fri, 07 Jan 2011 10:20:02 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id c11sm5160618vcc.14.2011.01.07.10.19.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 10:19:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107180220.GA20031@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164731>

Eric Wong wrote:

> Wait, looking through my backlog, this could fix the problem
> Ramsay was having but was lost in the shuffle (my fault) :x
> 
> Ramsay: does this fix it?
> 
> From 9a4f35d6ff9a66b7b5e57c7124a7cd6df0adad7b Mon Sep 17 00:00:00 2001
> From: Steven Walter <stevenrwalter@gmail.com>
> Date: Fri, 22 Oct 2010 21:55:58 -0400
> Subject: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on subversion 1.5

Context, for reference:

  http://thread.gmane.org/gmane.linux.kernel/1052314/focus=161717
