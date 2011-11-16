From: Haitao Li <lihaitao@gmail.com>
Subject: Re: Git 1.7.5 problem with HTTPS
Date: Wed, 16 Nov 2011 18:32:56 +0800
Message-ID: <CABk5KLiiNSwf_-FxdWZON_zxVuLLGbFfaQhzuC8dxmYDXEDA6g@mail.gmail.com>
References: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 11:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQcnz-0004J6-Hw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 11:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab1KPKdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 05:33:19 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57279 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab1KPKdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 05:33:18 -0500
Received: by ggnb2 with SMTP id b2so8572680ggn.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 02:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qxjT57Uh9jS36HQaKqaCtIn80RkkMB5wXFiDHJtoYxc=;
        b=AzI3fGI23TpO5k8A0qYD6p0Q1DoKvCH0D9PzPP1xRzLBZyATNquK006kojKk7zLKNW
         bxy9XE6snqADMfwRUoaoY4xY+flR/yhiPpd9Uzzs4rp/KIeYlaadwgeomLzvv6kzFveS
         mikheM45QM1hB6pdeE0pjWTM8/1/0PVAAR1g8=
Received: by 10.146.88.6 with SMTP id l6mr607345yab.35.1321439598017; Wed, 16
 Nov 2011 02:33:18 -0800 (PST)
Received: by 10.147.114.1 with HTTP; Wed, 16 Nov 2011 02:32:56 -0800 (PST)
In-Reply-To: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185535>

> I was also considering that the problem is caused by proxy. But when I
> tried to clone the same git source from another host via the same
> proxy, it works pretty good. The difference is the git version: on the
> first host it is 1.7.5.4 (comes with Ubuntu 11.10), on the second -
> 1.7.0.4

The proxy may have some impact.

I see exactly the same error only behind a proxy on my laptop running
Ubuntu 11.10 with libgnutls26/2.10.5-1ubuntu3. The same laptop works fine
at home without proxy.

I have another machine (Ubuntu 11.04 git/1.7.4.1 libgnutls26/2.8.6-1ubuntu2)
works fine behind the same proxy.
