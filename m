From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a custom ./configure script
Date: Wed, 5 Jul 2006 18:46:43 +0200
Message-ID: <81b0412b0607050946y34bf28d5gca30264375fb7957@mail.gmail.com>
References: <20060704004012.22639.44317.stgit@machine.or.cz>
	 <e8drmq$8ec$1@sea.gmane.org> <20060704215747.GQ29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 18:47:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAWY-0002OR-Ep
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 18:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWGEQqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 12:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWGEQqq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 12:46:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:3251 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964869AbWGEQqp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 12:46:45 -0400
Received: by ug-out-1314.google.com with SMTP id s2so249613uge
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 09:46:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jG8YaFiGo2qJWzRau6FqjbyhYRobgeUKdPjaaTgfpsoA1ZZRmlubdzAqewgdh3at9WmfPKXvni8HZtN5tXb2qUx+I7nzfLEnP73EdIQqruNoe+fKm/lL9ZZlu+tvRiBT0Joenj8jl0grk5a4Psdol3uWIeiC73zrIBzlibfv08s=
Received: by 10.78.165.16 with SMTP id n16mr2409286hue;
        Wed, 05 Jul 2006 09:46:44 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 5 Jul 2006 09:46:43 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060704215747.GQ29115@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23354>

On 7/4/06, Petr Baudis <pasky@suse.cz> wrote:
> >
> > If you named it for example configure.sh, then autoconf generated version,
> > and your by hand created version could coexist.
>
> I'm not opposed to it per se, but I'm just not sure if it makes any
> sense to support them both in parallel, since then you have parallel
> infrastructure doing the exactly same thing, or worse yet - performing
> a subtly different set of tests. The benefit is unclear to me.

The benefit is on user side: he'll take what works for him, without waiting
for you or Jakub to fix it for him.

> Another thing is that it's named *everywhere* ./configure and if I use a
> different name now then it will be hard to rename.

but it not the same configure as "everywhere". It's your very own script.

That said, I like your script better than the autoconf thing.
